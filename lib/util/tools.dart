import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/gen/rumgap/v1/reading.pb.dart';
import 'package:wuxia/util/download_migration.dart';
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

extension MangaSourceDetails on MangaReply {
  /// This manga with [source]'s own details (title, cover, genres, chapter count, ...),
  /// or unchanged when [source] has none: an offline snapshot or server from before
  /// sources had their own details.
  MangaReply withSourceDetails(MangaSourceReply source) {
    if (source.title.isEmpty) return this;
    final manga = deepCopy()
      ..title = source.title
      ..description = source.description
      ..status = source.status
      ..isOngoing = source.isOngoing
      ..countChapters = source.countChapters;
    manga.genres
      ..clear()
      ..addAll(source.genres);
    manga.authors
      ..clear()
      ..addAll(source.authors);
    manga.altTitles
      ..clear()
      ..addAll(source.altTitles);
    if (source.hasCover()) manga.cover = source.cover;
    if (source.hasLast()) manga.last = source.last;
    return manga;
  }
}

/// Download folder name for a manga, relative to the download root. Holds
/// its `manga.pb` and one [sourceFolderName] folder per downloaded source.
String mangaFolderName(int mangaId) => '$mangaId';

/// Download folder name for a source, relative to its manga's folder. Holds
/// that source's `chapters.pb`, `complete` marker and chapter folders.
String sourceFolderName(int sourceId) => '$sourceId';

/// [name] with everything but letters, digits, spaces and dashes replaced,
/// for use as a file name.
String safeFileName(String name) => name.replaceAll(RegExp(r'[^\w\s\-]'), '_');

/// Download folder name for a chapter, relative to its source's folder.
String chapterFolderName(double number) => number.toStringAsFixed(1).replaceAll('.0', '');

/// Every downloaded manga, keyed by its folder name. Empty when the storage
/// isn't accessible (e.g. web folder access still needs to be re-granted).
Future<Map<String, MangaReply>> listDownloadedManga() async {
  final result = <String, MangaReply>{};
  try {
    for (final folder in await downloadStorage.listDirs()) {
      if (await downloadStorage.exists('$folder/$migratingMarker')) continue;
      final bytes = await downloadStorage.read('$folder/manga.pb');
      if (bytes == null) continue;
      try {
        result[folder] = MangaReply.fromBuffer(bytes);
      } catch (_) {}
    }
  } catch (_) {}
  return result;
}

/// The download folder of manga [mangaId], or `null` if it isn't downloaded.
/// Folders are named after the manga id, but one that hasn't been moved
/// from its old title-named folder yet (see `ensureDownloadsMigrated`) is
/// found by scanning every folder's `manga.pb`.
Future<String?> findDownloadedMangaDir(int mangaId) async {
  final dir = mangaFolderName(mangaId);
  try {
    if (await downloadStorage.exists('$dir/manga.pb') && !await downloadStorage.exists('$dir/$migratingMarker')) return dir;
  } catch (_) {}
  final downloaded = await listDownloadedManga();
  for (final entry in downloaded.entries) {
    if (entry.value.id == mangaId) return entry.key;
  }
  return null;
}

/// One downloaded source of a manga.
class DownloadedSource {
  final int sourceId;

  /// Folder holding its `chapters.pb`, `complete` marker and chapter folders.
  final String dir;

  /// Chapters of its last finished download; `0` if it never finished.
  final int completedChapters;

  const DownloadedSource(this.sourceId, this.dir, this.completedChapters);
}

/// Every downloaded source of manga [mangaId], the most complete one first.
/// Empty if the manga isn't downloaded.
Future<List<DownloadedSource>> listDownloadedSources(int mangaId) async {
  final mangaDir = await findDownloadedMangaDir(mangaId);
  if (mangaDir == null) return [];
  final result = <DownloadedSource>[];
  try {
    final oldLayoutSource = await _chaptersSourceId(mangaDir);
    if (oldLayoutSource != null) {
      // Not moved into the per-source layout yet: the folder is the source.
      result.add(DownloadedSource(oldLayoutSource, mangaDir, await _completedChapters(mangaDir)));
    } else {
      for (final sub in await downloadStorage.listDirs(mangaDir)) {
        final sourceId = int.tryParse(sub);
        final dir = '$mangaDir/$sub';
        if (sourceId == null || await downloadStorage.exists('$dir/$migratingMarker')) continue;
        if (!await downloadStorage.exists('$dir/chapters.pb')) continue;
        result.add(DownloadedSource(sourceId, dir, await _completedChapters(dir)));
      }
    }
  } catch (_) {}
  result.sort((a, b) => b.completedChapters.compareTo(a.completedChapters));
  return result;
}

/// The downloaded copy of source [sourceId] of manga [mangaId], or with no
/// [sourceId] (or when that source isn't downloaded) the most complete
/// downloaded source. `null` if the manga isn't downloaded.
Future<DownloadedSource?> findDownloadedSource(int mangaId, {int? sourceId}) async {
  final sources = await listDownloadedSources(mangaId);
  return sources.where((s) => s.sourceId == sourceId).firstOrNull ?? sources.firstOrNull;
}

Future<int?> _chaptersSourceId(String dir) async {
  final bytes = await downloadStorage.read('$dir/chapters.pb');
  if (bytes == null) return null;
  try {
    return ChaptersReply.fromBuffer(bytes).items.firstOrNull?.mangaSourceId ?? 0;
  } catch (_) {
    return 0;
  }
}

Future<int> _completedChapters(String dir) async {
  try {
    final bytes = await downloadStorage.read('$dir/complete');
    return bytes == null ? 0 : int.tryParse(utf8.decode(bytes)) ?? 0;
  } catch (_) {
    return 0;
  }
}

/// The `manga.pb` snapshot saved at download time, or `null` if this manga
/// isn't downloaded.
Future<MangaReply?> loadOfflineManga(int mangaId) async {
  final dir = await findDownloadedMangaDir(mangaId);
  if (dir == null) return null;
  try {
    final bytes = await downloadStorage.read('$dir/manga.pb');
    return bytes == null ? null : MangaReply.fromBuffer(bytes);
  } catch (_) {
    return null;
  }
}

/// Deletes a manga's entire downloaded folder -- its `manga.pb` snapshot and
/// every downloaded source with its chapters' images. No-op if it isn't
/// downloaded.
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

/// Records in [sourceDir] that a download finished with [chapterCount]
/// chapters. `chapters.pb` is written when a download starts (the offline
/// reader needs it), so it can't tell a finished download from one that
/// was interrupted; this marker is only written once every chapter is on
/// disk.
Future<void> writeDownloadCompleteMarker(String sourceDir, int chapterCount) async {
  await downloadStorage.write('$sourceDir/complete', utf8.encode('$chapterCount'));
}

/// How many chapters the last finished download of source [sourceId] of
/// [mangaId] had, `0` if it's downloaded but never finished (or finished
/// before this marker existed), or `null` if that source isn't downloaded.
Future<int?> loadDownloadedChapterCount(int mangaId, int sourceId) async {
  final sources = await listDownloadedSources(mangaId);
  return sources.where((s) => s.sourceId == sourceId).firstOrNull?.completedChapters;
}

/// The full chapter list `DownloadManager` saved to `chapters.pb` for
/// source [sourceId] (or the most complete downloaded source, see
/// [findDownloadedSource]), oldest first (ascending `index`) -- callers
/// reverse as needed to match whatever order they're after. `null` if
/// there's no usable local copy: never downloaded, storage not accessible,
/// or a corrupt/missing `chapters.pb`.
Future<List<ChapterReply>?> loadOfflineChapters(int mangaId, {int? sourceId}) async {
  final source = await findDownloadedSource(mangaId, sourceId: sourceId);
  if (source == null) return null;
  try {
    final bytes = await downloadStorage.read('${source.dir}/chapters.pb');
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
/// `DownloadManager` first writes it. No-op if the manga isn't downloaded.
Future<void> updateOfflineMangaSnapshot(MangaReply manga) async {
  final dir = await findDownloadedMangaDir(manga.id);
  if (dir == null) return;
  try {
    await downloadStorage.write('$dir/manga.pb', manga.writeToBuffer());
  } catch (_) {}
}

/// Marks `MangaReply` instances whose `readingProgress` was set locally to
/// read a manga that isn't in the reading list. Tied to the instance, so a
/// fresh reply from the server carries the server's state again.
final _localProgress = Expando<bool>('localProgress');

/// Whether [manga] is in the user's reading list (as opposed to only having
/// a local position from reading it outside the list).
bool isInReadingList(MangaReply manga) => manga.hasReadingProgress() && _localProgress[manga] != true;

/// Moves [manga]'s position to [progress] before navigating to a chapter.
/// For a manga outside the reading list the position stays local to this
/// instance and [syncReadingProgress] doesn't send it to the server.
void setReadingProgress(MangaReply manga, int progress) {
  if (!manga.hasReadingProgress()) _localProgress[manga] = true;
  manga.readingProgress = progress;
}

/// Records that [manga] was just added to the reading list: replaces it with
/// the server's [reply] and drops any local-only position.
void markAddedToReadingList(MangaReply manga, MangaReply reply) {
  _localProgress[manga] = null;
  manga.clear();
  manga.mergeFromMessage(reply);
}

/// Persists a reading-progress update, merging the server's response back
/// into `manga` on success -- it carries fields the client can't compute
/// locally (e.g. `progressOrdinal`, the cross-source-comparable rank
/// `ChapterSelector` actually greys "read" chapters by), so a caller that
/// only hand-sets `manga.readingProgress` before calling this leaves that
/// stale until the merge lands. Falls back to `Store`'s single-latest-value
/// pending slot when the write fails (typically offline) so it can be
/// retried once back online instead of just lost. Does nothing for a manga
/// outside the reading list.
Future<void> syncReadingProgress(MangaReply manga, {required int progress, int? chapterId}) async {
  if (!isInReadingList(manga)) return;
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
