import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuxia/util/store.dart';

import 'cbz.dart';
import 'download_storage.dart';

DownloadStorage createDownloadStorage() => IoDownloadStorage();

class IoDownloadStorage extends DownloadStorage {
  @override
  bool get supported => true;

  @override
  bool get canPickLocation => true;

  @override
  bool get isPrivate => false;

  Future<Directory> _root() async {
    final custom = Store.getStoreInstance().getDownloadDir();
    final dir = custom != null ? Directory(custom) : await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    return dir;
  }

  Future<String> _abs(String path) async => '${(await _root()).path}/$path';

  @override
  Future<DownloadStorageStatus> status() async => DownloadStorageStatus.ready;

  @override
  Future<String> location() async => (await _root()).path;

  @override
  Future<bool> pickLocation() async {
    final path = await getDirectoryPath();
    if (path == null) return false;
    await Store.getStoreInstance().setDownloadDir(path);
    return true;
  }

  @override
  Future<void> resetLocation() => Store.getStoreInstance().clearDownloadDir();

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<List<String>> listDirs([String dir = '']) async {
    final directory = Directory(dir.isEmpty ? (await _root()).path : await _abs(dir));
    if (!await directory.exists()) return [];
    return [
      await for (final entry in directory.list())
        if (entry is Directory) entry.uri.pathSegments.lastWhere((s) => s.isNotEmpty),
    ];
  }

  @override
  Future<List<String>> listFiles(String dir) async {
    final directory = Directory(await _abs(dir));
    if (!await directory.exists()) return [];
    return [
      await for (final entry in directory.list())
        if (entry is File) entry.uri.pathSegments.last,
    ];
  }

  @override
  Future<bool> exists(String path) async => File(await _abs(path)).exists();

  @override
  Future<Uint8List?> read(String path) async {
    final file = File(await _abs(path));
    if (!await file.exists()) return null;
    return file.readAsBytes();
  }

  @override
  Future<void> write(String path, Uint8List bytes) async {
    final file = File(await _abs(path));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  @override
  Future<void> deleteDir(String dir) async {
    final directory = Directory(await _abs(dir));
    if (await directory.exists()) await directory.delete(recursive: true);
  }

  @override
  Future<int> totalSize() async {
    var total = 0;
    await for (final entry in (await _root()).list(recursive: true)) {
      if (entry is File) total += await entry.length();
    }
    return total;
  }

  @override
  Future<List<String>?> loadPageSources(String dir) async {
    final files = await listFiles(dir);
    if (files.isEmpty) return null;
    files.sort((a, b) => pageIndexOf(a).compareTo(pageIndexOf(b)));
    final base = await _abs(dir);
    return files.map((f) => '$base/$f').toList();
  }

  @override
  Widget pageImage(String source, {required BoxFit fit, required Alignment alignment, double? height}) {
    return Image.file(
      File(source),
      alignment: alignment,
      filterQuality: FilterQuality.high,
      fit: fit,
      width: double.infinity,
      height: height,
    );
  }

  @override
  Future<String?> exportCbz(String mangaDir) async {
    final String target;
    if (Platform.isAndroid || Platform.isIOS) {
      final dir = await getDirectoryPath();
      if (dir == null) return null;
      target = '$dir/$mangaDir.cbz';
    } else {
      final location = await getSaveLocation(suggestedName: '$mangaDir.cbz');
      if (location == null) return null;
      target = location.path;
    }

    final file = await File(target).open(mode: FileMode.write);
    try {
      final zip = StoredZipBuilder();
      for (final chapter in sortChapterFolders(await listDirs(mangaDir))) {
        final pages = await listFiles('$mangaDir/$chapter');
        pages.sort((a, b) => pageIndexOf(a).compareTo(pageIndexOf(b)));
        for (final page in pages) {
          final bytes = await File(await _abs('$mangaDir/$chapter/$page')).readAsBytes();
          await file.writeFrom(zip.add(cbzEntryName(chapter, page, pageIndexOf(page)), bytes.length, crc32(bytes)));
          await file.writeFrom(bytes);
        }
      }
      await file.writeFrom(zip.finish());
      await file.close();
    } catch (_) {
      await file.close();
      await File(target).delete();
      rethrow;
    }
    return target;
  }
}
