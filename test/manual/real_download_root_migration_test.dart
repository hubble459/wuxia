// Runs the folder migration with the real IO backend against a copy of a
// download root. Skipped unless WUXIA_DOWNLOAD_ROOT_COPY points at a copy
// (never the real folder):
//   WUXIA_DOWNLOAD_ROOT_COPY=/tmp/copy flutter test test/manual/real_download_root_migration_test.dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuxia/util/download_migration.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/store.dart';
import 'package:wuxia/util/tools.dart';

void main() {
  final root = Platform.environment['WUXIA_DOWNLOAD_ROOT_COPY'];

  test('migrates a real download root', () async {
    SharedPreferences.setMockInitialValues({Store.downloadDirKey: root!});
    await Store.init();

    final before = await listDownloadedManga();
    await migrateDownloadFolders(downloadStorage);
    final after = await listDownloadedManga();

    expect(after.keys.toSet(), {for (final manga in before.values) '${manga.id}'});
    for (final manga in before.values) {
      final sources = await listDownloadedSources(manga.id);
      expect(sources, hasLength(1), reason: manga.title);
      expect(await loadOfflineChapters(manga.id), isNotEmpty, reason: manga.title);
      // ignore: avoid_print
      print('${manga.id} "${manga.title}" -> ${sources.single.dir} (${sources.single.completedChapters} chapters complete)');
    }
    expect(downloadMigrationConflicts.value, isEmpty);

    final files = await Directory(root).list(recursive: true).where((e) => e is File).length;
    // ignore: avoid_print
    print('files after: $files');
  }, skip: root == null ? 'set WUXIA_DOWNLOAD_ROOT_COPY to a copy of a download root' : false);
}
