import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';

/// Download folders used to be one folder per manga, named after its title:
/// `<title>/{manga.pb, chapters.pb, complete, <chapter>/<page>}`. A title
/// change made the next download write a second folder, and downloading a
/// second source of the same manga mixed its pages into the first one's.
/// Now every downloaded source has its own folder: `<manga id>/manga.pb`
/// and `<manga id>/<source id>/{chapters.pb, complete, <chapter>/<page>}`.
/// This moves old folders over.
///
/// Folders are only ever moved. Where the backend can rename a folder that
/// is a single step. Otherwise (web) the folder is copied with
/// [migratingMarker] in it, compared file by file, and the original is only
/// deleted once the marker is gone, so an interrupted run never loses
/// anything: a copy that still has the marker is thrown away and redone,
/// and a finished copy whose original is still there gets that original
/// removed. Folders that can't be moved because the target already exists
/// are left alone and reported in [downloadMigrationConflicts].

/// Present in a folder while it's still being copied into place.
const migratingMarker = '.migrating';
const _migratedFromFile = '.migrated_from';

/// Old folders that weren't moved because a folder for the same manga and
/// source already exists. Both are left untouched for the user to sort out.
final downloadMigrationConflicts = ValueNotifier<List<String>>(const []);

String? _migratedLocation;
Future<void>? _running;

/// Moves any old-layout download folders into the per-source layout. Cheap
/// once done for the current download location; re-runs after the location
/// changes, and does nothing until storage access is granted (web).
Future<void> ensureDownloadsMigrated() async {
  if (!downloadStorage.supported) return;
  try {
    if (await downloadStorage.status() != DownloadStorageStatus.ready) return;
    final location = await downloadStorage.location() ?? '';
    if (_migratedLocation == location) return;
    await (_running ??= migrateDownloadFolders(downloadStorage).whenComplete(() => _running = null));
    _migratedLocation = location;
  } catch (e) {
    debugPrint('download folder migration failed: $e');
  }
}

/// One migration pass over [storage]'s download root; see the top of this
/// file. Use [ensureDownloadsMigrated] instead outside tests.
@visibleForTesting
Future<void> migrateDownloadFolders(DownloadStorage storage) async {
  // Interrupted copies. Their originals are only deleted after the marker is
  // removed, so they're still there: start over from them.
  for (final folder in await storage.listDirs()) {
    if (await storage.exists('$folder/$migratingMarker')) {
      await storage.deleteDir(folder);
      continue;
    }
    for (final sub in await storage.listDirs(folder)) {
      if (await storage.exists('$folder/$sub/$migratingMarker')) await storage.deleteDir('$folder/$sub');
    }
  }

  // Moving one folder can free up or create another's target, so keep going
  // while folders are still being moved.
  var conflicts = <String>[];
  for (var moved = true; moved;) {
    moved = false;
    conflicts = [];
    for (final folder in await storage.listDirs()) {
      final old = await _oldLayout(storage, folder);
      if (old == null) continue;
      final mangaDir = '${old.mangaId}';
      final target = '$mangaDir/${old.sourceId}';

      try {
        if (folder == mangaDir) {
          // Its target is inside it; move it aside first, the next pass
          // moves it into place.
          if (await _dirExists(storage, '${folder}_old')) {
            conflicts.add(folder);
            continue;
          }
          await _move(storage, folder, '${folder}_old');
          moved = true;
          continue;
        }
        if (await _dirExists(storage, target)) {
          if (await _isFinishedCopyOf(storage, target, folder)) {
            await storage.deleteDir(folder);
            await storage.deleteFile('$target/manga.pb');
            moved = true;
          } else {
            conflicts.add(folder);
          }
          continue;
        }
        if (!await storage.exists('$mangaDir/manga.pb')) await storage.write('$mangaDir/manga.pb', old.mangaPb);
        await _move(storage, folder, target);
        await storage.deleteFile('$target/manga.pb');
        moved = true;
      } catch (e) {
        debugPrint('could not move download folder "$folder" to "$target": $e');
      }
    }
  }
  downloadMigrationConflicts.value = conflicts;
}

/// The manga and source an old-layout [folder] belongs to, or `null` when
/// it's already a per-source manga folder (or not a download at all).
Future<({int mangaId, int sourceId, Uint8List mangaPb})?> _oldLayout(DownloadStorage storage, String folder) async {
  final mangaPb = await storage.read('$folder/manga.pb');
  if (mangaPb == null) return null;
  final MangaReply manga;
  try {
    manga = MangaReply.fromBuffer(mangaPb);
  } catch (_) {
    return null;
  }

  final chaptersPb = await storage.read('$folder/chapters.pb');
  if (chaptersPb == null && folder == '${manga.id}') return null;

  int? sourceId;
  if (chaptersPb != null) {
    try {
      sourceId = ChaptersReply.fromBuffer(chaptersPb).items.firstOrNull?.mangaSourceId;
    } catch (_) {}
  }
  sourceId ??= (manga.sources.where((s) => s.isPrimary).firstOrNull ?? manga.sources.firstOrNull)?.id ?? 0;
  return (mangaId: manga.id, sourceId: sourceId, mangaPb: mangaPb);
}

Future<bool> _dirExists(DownloadStorage storage, String path) async {
  final slash = path.lastIndexOf('/');
  final parent = slash == -1 ? '' : path.substring(0, slash);
  return (await storage.listDirs(parent)).contains(path.substring(slash + 1));
}

Future<void> _move(DownloadStorage storage, String folder, String target) async {
  if (await storage.renameDir(folder, target)) return;

  await storage.write('$target/$migratingMarker', Uint8List(0));
  await storage.write('$target/$_migratedFromFile', utf8.encode(folder));
  await storage.copyDir(folder, target);
  if (!await _hasSameFiles(storage, folder, target)) {
    await storage.deleteDir(target);
    throw StateError('the copy differs from the original');
  }
  await storage.deleteFile('$target/$migratingMarker');
  await storage.deleteDir(folder);
}

Future<bool> _isFinishedCopyOf(DownloadStorage storage, String target, String folder) async {
  if (await storage.exists('$target/$migratingMarker')) return false;
  final from = await storage.read('$target/$_migratedFromFile');
  if (from == null || utf8.decode(from) != folder) return false;
  return _hasSameFiles(storage, folder, target);
}

/// Whether every file under [from] exists under [to] with the same size.
Future<bool> _hasSameFiles(DownloadStorage storage, String from, String to) async {
  for (final file in await storage.listFiles(from)) {
    final size = await storage.fileSize('$from/$file');
    if (size == null || size != await storage.fileSize('$to/$file')) return false;
  }
  for (final dir in await storage.listDirs(from)) {
    if (!await _hasSameFiles(storage, '$from/$dir', '$to/$dir')) return false;
  }
  return true;
}
