import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/util/store.dart';

/// Offline manga downloads rely on local filesystem access, which isn't
/// available on web -- callers must check this before touching the
/// download directory.
bool get downloadsSupported => !kIsWeb;

const githubWuxiaReleasesUrl = 'https://github.com/hubble459/wuxia/releases';

Future<Directory> getDownloadDirectory() async {
  if (kIsWeb) {
    throw UnsupportedError('Downloads are not supported on web');
  }
  final custom = Store.getStoreInstance().getDownloadDir();
  final dir = custom != null ? Directory(custom) : await getApplicationDocumentsDirectory();
  // Nothing guarantees this exists yet (e.g. a completely fresh install) --
  // every caller below assumes it does, some via `.list()`, which throws
  // outright on a missing directory. `create` is a no-op if it already
  // exists, so this is safe to call unconditionally.
  await dir.create(recursive: true);
  return dir;
}

/// Downloaded manga folders are keyed by a sanitized title, not id (see
/// `_downloadManga` in `manga_screen.dart`), so finding "is manga [mangaId]
/// downloaded" means scanning every folder's `manga.pb` rather than building
/// a path directly -- same approach `DownloadsScreen` uses for its listing.
Future<Directory?> findDownloadedMangaDir(int mangaId) async {
  if (kIsWeb) return null;

  final dir = await getDownloadDirectory();
  await for (final entry in dir.list()) {
    if (entry is! Directory) continue;
    final pbFile = File('${entry.path}/manga.pb');
    if (!await pbFile.exists()) continue;
    try {
      final manga = MangaReply.fromBuffer(await pbFile.readAsBytes());
      if (manga.id == mangaId) return entry;
    } catch (_) {}
  }
  return null;
}

/// Deletes a manga's entire downloaded folder -- its `manga.pb`/
/// `chapters.pb` snapshots and every downloaded chapter's images. No-op if
/// it isn't downloaded.
Future<void> deleteDownloadedManga(int mangaId) async {
  if (kIsWeb) return;

  final dir = await findDownloadedMangaDir(mangaId);
  if (dir == null) return;
  await dir.delete(recursive: true);
}

/// The full chapter list `_downloadManga` saved to `chapters.pb`, in its
/// stored order (reversed: false / newest-first) -- callers reverse as
/// needed to match whatever order they're after. `null` if there's no usable
/// local copy: never downloaded, web (no filesystem access), or a corrupt/
/// missing `chapters.pb`.
Future<List<ChapterReply>?> loadOfflineChapters(int mangaId) async {
  if (kIsWeb) return null;

  final dir = await findDownloadedMangaDir(mangaId);
  if (dir == null) return null;
  try {
    final bytes = await File('${dir.path}/chapters.pb').readAsBytes();
    return ChaptersReply.fromBuffer(bytes).items;
  } catch (_) {
    return null;
  }
}

/// Whether [chapter] counts as already read, given [manga]'s current
/// progress. Prefers `progressOrdinal` (the one rank comparable across
/// sources) over the per-source `chapter.index`, except when a
/// `syncReadingProgress` write for this manga is still pending -- offline,
/// there's no way to get an updated ordinal from the server, so the plain
/// index comparison (accurate within a single source) is used instead.
bool isChapterRead(MangaReply manga, ChapterReply chapter) {
  final hasPendingUpdate = Store.getStoreInstance().getPendingProgress(manga.id) != null;
  if (!hasPendingUpdate && manga.hasProgressOrdinal() && chapter.hasOrdinal()) {
    return manga.progressOrdinal >= chapter.ordinal;
  }
  return manga.readingProgress >= chapter.index.toInt();
}

/// Rewrites the downloaded `manga.pb` snapshot (if this manga is downloaded)
/// so offline-only readers (`DownloadsScreen`, and the various offline
/// fallbacks) show current progress instead of whatever was true at
/// download time -- that file is otherwise never touched again after
/// `_downloadManga` first writes it. No-op if the manga isn't downloaded.
Future<void> updateOfflineMangaSnapshot(MangaReply manga) async {
  if (kIsWeb) return;

  final dir = await findDownloadedMangaDir(manga.id);
  if (dir == null) return;
  try {
    await File('${dir.path}/manga.pb').writeAsBytes(manga.writeToBuffer());
  } catch (_) {}
}

/// Persists a reading-progress update, merging the server's response back
/// into `manga` on success -- it carries fields the client can't compute
/// locally (e.g. `progressOrdinal`, the cross-source-comparable rank
/// `ChapterSelector` actually greys "read" chapters by), so a caller that
/// only hand-sets `manga.readingProgress` before calling this leaves that
/// stale until the merge lands. Falls back to `Store`'s single-latest-value
/// pending slot when the write fails (typically offline) so it can be
/// retried once back online instead of just lost.
Future<void> syncReadingProgress(MangaReply manga, {required int progress, int? chapterId}) async {
  try {
    final request = ReadingPatchRequest(mangaId: manga.id, progress: progress);
    if (chapterId != null) request.chapterId = chapterId;
    final updated = await api.reading.update(request);
    manga.clear();
    manga.mergeFromMessage(updated);
    await Store.getStoreInstance().clearPendingProgress(manga.id);
  } catch (_) {
    await Store.getStoreInstance().setPendingProgress(manga.id, progress: progress, chapterId: chapterId);
  }
  await updateOfflineMangaSnapshot(manga);
}

/// Retries a reading-progress update left pending by an earlier
/// `syncReadingProgress` call that couldn't reach the server, merging the
/// response into `manga` on success exactly like a fresh write. Sets
/// `manga.readingProgress` optimistically first, so it's reflected locally
/// even if this retry itself still fails.
///
/// `manga` must already reflect a fresh fetch (the caller's job) -- if
/// something else (another device, the web client) advanced progress past
/// the pending offline value in the meantime, that fresh value already
/// leads the stale pending one, and pushing the pending value would regress
/// it. So this only pushes when the pending value is still ahead; otherwise
/// it's just discarded as superseded. Either way, `manga`'s downloaded
/// snapshot (if any) is brought up to date with whatever ends up current --
/// this is the one place a normal online refresh (no pending write at all)
/// also gets a chance to fix a stale `DownloadsScreen` entry.
Future<void> flushPendingProgress(MangaReply manga) async {
  final store = Store.getStoreInstance();
  final pending = store.getPendingProgress(manga.id);
  if (pending == null) {
    await updateOfflineMangaSnapshot(manga);
    return;
  }

  if (pending <= manga.readingProgress) {
    await store.clearPendingProgress(manga.id);
    await updateOfflineMangaSnapshot(manga);
    return;
  }

  manga.readingProgress = pending;
  await syncReadingProgress(manga, progress: pending, chapterId: store.getPendingProgressChapterId(manga.id));
}
