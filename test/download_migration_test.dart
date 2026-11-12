import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wuxia/gen/rumgap/v1/chapter.pb.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/util/download_migration.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';

/// Files only (folders exist implicitly), like the web backend.
class _MemoryStorage extends DownloadStorage {
  _MemoryStorage({required this.canRename});

  final bool canRename;
  final files = <String, Uint8List>{};

  /// Throws on the write after this many more writes, to simulate the app
  /// being killed mid-migration.
  int? crashAfterWrites;

  Iterable<String> _under(String dir) => dir.isEmpty ? files.keys : files.keys.where((k) => k.startsWith('$dir/'));
  String _rest(String dir, String path) => dir.isEmpty ? path : path.substring(dir.length + 1);

  @override
  Future<List<String>> listDirs([String dir = '']) async =>
      {for (final path in _under(dir)) if (_rest(dir, path).contains('/')) _rest(dir, path).split('/').first}.toList();

  @override
  Future<List<String>> listFiles(String dir) async => [
    for (final path in _under(dir))
      if (!_rest(dir, path).contains('/')) _rest(dir, path),
  ];

  @override
  Future<bool> exists(String path) async => files.containsKey(path);

  @override
  Future<Uint8List?> read(String path) async => files[path];

  @override
  Future<void> write(String path, Uint8List bytes) async {
    final left = crashAfterWrites;
    if (left != null) {
      if (left == 0) throw StateError('killed');
      crashAfterWrites = left - 1;
    }
    files[path] = bytes;
  }

  @override
  Future<int?> fileSize(String path) async => files[path]?.length;

  @override
  Future<void> deleteFile(String path) async => files.remove(path);

  @override
  Future<void> deleteDir(String dir) async => files.removeWhere((k, _) => k.startsWith('$dir/'));

  @override
  Future<bool> renameDir(String from, String to) async {
    if (!canRename || _under(to).isNotEmpty) return false;
    for (final path in _under(from).toList()) {
      files['$to/${_rest(from, path)}'] = files.remove(path)!;
    }
    return true;
  }

  @override
  bool get supported => true;
  @override
  bool get canPickLocation => false;
  @override
  bool get isPrivate => false;
  @override
  Future<DownloadStorageStatus> status() async => DownloadStorageStatus.ready;
  @override
  Future<String?> location() async => 'memory';
  @override
  Future<bool> pickLocation() async => false;
  @override
  Future<void> resetLocation() async {}
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<int> totalSize() async => files.values.fold<int>(0, (sum, bytes) => sum + bytes.length);
  @override
  Future<List<String>?> loadPageSources(String dir) async => null;
  @override
  Widget pageImage(String source, {required BoxFit fit, required Alignment alignment, double? height}) => const SizedBox();
  @override
  Future<String?> exportCbz(String mangaDir, String name) async => null;
}

Uint8List _page(int seed, int size) => Uint8List.fromList(List.filled(size, seed % 256));

/// An old-layout download of [sourceId] of manga [mangaId] in [folder].
void _oldDownload(_MemoryStorage storage, String folder, {required int mangaId, required int sourceId, int chapters = 3}) {
  storage.files['$folder/manga.pb'] = MangaReply(
    id: mangaId,
    title: folder,
    sources: [MangaSourceReply(id: sourceId, isPrimary: true)],
  ).writeToBuffer();
  storage.files['$folder/chapters.pb'] = ChaptersReply(
    items: [for (var c = 1; c <= chapters; c++) ChapterReply(mangaSourceId: sourceId, number: c.toDouble())],
  ).writeToBuffer();
  storage.files['$folder/complete'] = Uint8List.fromList('$chapters'.codeUnits);
  for (var c = 1; c <= chapters; c++) {
    for (var p = 0; p < 4; p++) {
      storage.files['$folder/$c/$p.jpg'] = _page(c * 10 + p, 100 + p);
    }
  }
}

/// [storage]'s files under [prefix], with [prefix] stripped, for comparing a
/// folder's contents before and after a move.
Map<String, int> _contents(_MemoryStorage storage, String prefix) => {
  for (final entry in storage.files.entries)
    if (entry.key.startsWith('$prefix/')) entry.key.substring(prefix.length + 1): entry.value.length,
};

void main() {
  for (final canRename in [true, false]) {
    group(canRename ? 'renaming backend' : 'copying backend', () {
      test('moves a title folder to <manga id>/<source id>', () async {
        final storage = _MemoryStorage(canRename: canRename);
        _oldDownload(storage, 'Some Title', mangaId: 42, sourceId: 7);
        final before = _contents(storage, 'Some Title')..remove('manga.pb');

        await migrateDownloadFolders(storage);

        expect(await storage.listDirs(), ['42']);
        expect(storage.files.containsKey('42/manga.pb'), isTrue);
        final after = _contents(storage, '42/7')..removeWhere((k, _) => k.startsWith('.'));
        expect(after, before);
        expect(storage.files.keys.where((k) => k.contains('.migrating')), isEmpty);
        expect(downloadMigrationConflicts.value, isEmpty);
      });

      test('keeps two sources of the same manga apart', () async {
        final storage = _MemoryStorage(canRename: canRename);
        _oldDownload(storage, 'Old Title', mangaId: 42, sourceId: 7);
        _oldDownload(storage, 'New Title', mangaId: 42, sourceId: 8, chapters: 2);

        await migrateDownloadFolders(storage);

        expect(await storage.listDirs(), ['42']);
        expect((await storage.listDirs('42'))..sort(), ['7', '8']);
        expect(await storage.listDirs('42/8'), hasLength(2));
      });

      test('leaves both folders alone when the target already exists', () async {
        final storage = _MemoryStorage(canRename: canRename);
        _oldDownload(storage, 'Old Title', mangaId: 42, sourceId: 7);
        _oldDownload(storage, 'New Title', mangaId: 42, sourceId: 7, chapters: 2);

        await migrateDownloadFolders(storage);

        final dirs = (await storage.listDirs())..sort();
        expect(dirs, hasLength(2));
        expect(dirs, contains('42'));
        expect(downloadMigrationConflicts.value, hasLength(1));
        // Nothing was lost: 3 + 2 chapters of 4 pages each.
        expect(storage.files.keys.where((k) => k.endsWith('.jpg')), hasLength(20));
      });

      test('moves a folder that is already named after its manga id', () async {
        final storage = _MemoryStorage(canRename: canRename);
        _oldDownload(storage, '42', mangaId: 42, sourceId: 7);
        final before = _contents(storage, '42')..remove('manga.pb');

        await migrateDownloadFolders(storage);

        expect(await storage.listDirs(), ['42']);
        expect(_contents(storage, '42/7')..removeWhere((k, _) => k.startsWith('.')), before);
      });

      test('a second run changes nothing', () async {
        final storage = _MemoryStorage(canRename: canRename);
        _oldDownload(storage, 'Some Title', mangaId: 42, sourceId: 7);
        await migrateDownloadFolders(storage);
        final after = Map.of(storage.files);

        await migrateDownloadFolders(storage);

        expect(storage.files, after);
      });
    });
  }

  test('an interrupted copy is redone without losing anything', () async {
    final storage = _MemoryStorage(canRename: false);
    _oldDownload(storage, 'Some Title', mangaId: 42, sourceId: 7);
    final before = _contents(storage, 'Some Title')..remove('manga.pb');

    for (final writes in [0, 1, 3, 7, 12]) {
      storage.crashAfterWrites = writes;
      await migrateDownloadFolders(storage);
      expect(storage.files.keys.where((k) => k.startsWith('Some Title/')), isNotEmpty, reason: 'the original stays until the copy is verified');
    }
    storage.crashAfterWrites = null;
    await migrateDownloadFolders(storage);

    expect(await storage.listDirs(), ['42']);
    expect(_contents(storage, '42/7')..removeWhere((k, _) => k.startsWith('.')), before);
  });

  test('a verified copy whose original was not deleted yet is finished', () async {
    final storage = _MemoryStorage(canRename: false);
    _oldDownload(storage, 'Some Title', mangaId: 42, sourceId: 7);
    storage.files['42/manga.pb'] = storage.files['Some Title/manga.pb']!;
    storage.files['42/7/.migrated_from'] = Uint8List.fromList('Some Title'.codeUnits);
    for (final entry in _contents(storage, 'Some Title').keys) {
      storage.files['42/7/$entry'] = storage.files['Some Title/$entry']!;
    }

    await migrateDownloadFolders(storage);

    expect(await storage.listDirs(), ['42']);
    expect(downloadMigrationConflicts.value, isEmpty);
  });

  test('leaves new-layout folders alone', () async {
    final storage = _MemoryStorage(canRename: true);
    _oldDownload(storage, 'Some Title', mangaId: 42, sourceId: 7);
    await migrateDownloadFolders(storage);
    _oldDownload(storage, 'Other', mangaId: 43, sourceId: 9);
    final first = _contents(storage, '42');

    await migrateDownloadFolders(storage);

    expect(_contents(storage, '42'), first);
    expect((await storage.listDirs())..sort(), ['42', '43']);
  });
}
