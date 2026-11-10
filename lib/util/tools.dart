import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/store.dart';

/// Whether this platform can store offline downloads at all -- callers must
/// check this before showing download UI.
bool get downloadsSupported => downloadStorage.supported;

/// Whether [error] means the server couldn't be reached at all (offline,
/// server down), as opposed to the server answering with an error.
bool isNetworkError(Object? error) {
  if (error is GrpcError) {
    if (error.code == StatusCode.unavailable || error.code == StatusCode.deadlineExceeded) return true;
    // grpc-web reports a failed XHR (no connection) as UNKNOWN with no status.
    final message = error.message ?? '';
    return error.code == StatusCode.unknown && (message.contains('without a status') || message.contains('XMLHttpRequest'));
  }
  final text = error.toString();
  return text.contains('SocketException') || text.contains('ClientException') || text.contains('Failed to fetch');
}

const githubWuxiaReleasesUrl = 'https://github.com/hubble459/wuxia/releases';
const accountRequestEmail = 'geraldd459@gmail.com';

/// Download folder name for a manga, relative to the download root.
String mangaFolderName(String title) => title.replaceAll(RegExp(r'[^\w\s\-]'), '_');

/// Download folder name for a chapter, relative to its manga's folder.
String chapterFolderName(double number) => number.toStringAsFixed(1).replaceAll('.0', '');

/// Every downloaded manga, keyed by its folder name. Empty when the storage
/// isn't accessible (e.g. web folder access still needs to be re-granted).
Future<Map<String, MangaReply>> listDownloadedManga() async {
  final result = <String, MangaReply>{};
  try {
    for (final folder in await downloadStorage.listDirs()) {
      final bytes = await downloadStorage.read('$folder/manga.pb');
      if (bytes == null) continue;
      try {
        result[folder] = MangaReply.fromBuffer(bytes);
      } catch (_) {}
    }
  } catch (_) {}
  return result;
}

/// Downloaded manga folders are keyed by a sanitized title, not id (see
/// `MangaDownloader`), so finding "is manga [mangaId] downloaded" means
/// scanning every folder's `manga.pb` rather than building a path directly.
Future<String?> findDownloadedMangaDir(int mangaId) async {
  final downloaded = await listDownloadedManga();
  for (final entry in downloaded.entries) {
    if (entry.value.id == mangaId) return entry.key;
  }
  return null;
}

/// The `manga.pb` snapshot saved at download time, or `null` if this manga
/// isn't downloaded.
Future<MangaReply?> loadOfflineManga(int mangaId) async {
  final downloaded = await listDownloadedManga();
  return downloaded.values.where((m) => m.id == mangaId).firstOrNull;
}

/// Deletes a manga's entire downloaded folder -- its `manga.pb`/
/// `chapters.pb` snapshots and every downloaded chapter's images. No-op if
/// it isn't downloaded.
Future<void> deleteDownloadedManga(int mangaId) async {
  final dir = await findDownloadedMangaDir(mangaId);
  if (dir == null) return;
  await downloadStorage.deleteDir(dir);
}

/// Deletes every downloaded manga folder (anything with a `manga.pb`),
/// leaving unrelated files in the download root alone.
Future<void> deleteAllDownloads() async {
  for (final dir in (await listDownloadedManga()).keys) {
    await downloadStorage.deleteDir(dir);
  }
}

/// The full chapter list `MangaDownloader` saved to `chapters.pb`, oldest
/// first (ascending `index`) -- callers reverse as needed to match whatever
/// order they're after. `null` if there's no usable local copy: never
/// downloaded, storage not accessible, or a corrupt/missing `chapters.pb`.
Future<List<ChapterReply>?> loadOfflineChapters(int mangaId) async {
  final dir = await findDownloadedMangaDir(mangaId);
  if (dir == null) return null;
  try {
    final bytes = await downloadStorage.read('$dir/chapters.pb');
    if (bytes == null) return null;
    return ChaptersReply.fromBuffer(bytes).items.toList()..sort((a, b) => a.index.compareTo(b.index));
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
/// `MangaDownloader` first writes it. No-op if the manga isn't downloaded.
Future<void> updateOfflineMangaSnapshot(MangaReply manga) async {
  final dir = await findDownloadedMangaDir(manga.id);
  if (dir == null) return;
  try {
    await downloadStorage.write('$dir/manga.pb', manga.writeToBuffer());
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
