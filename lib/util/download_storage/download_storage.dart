import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'download_storage_io.dart' if (dart.library.js_interop) 'download_storage_web.dart';

enum DownloadStorageStatus {
  ready,

  /// A folder was picked earlier (web), but the browser wants the user to
  /// grant access again -- [DownloadStorage.requestPermission] must be called
  /// from a user gesture (button press).
  needsPermission,
  unsupported,
}

/// Filesystem access for offline downloads. Paths are `/`-separated and
/// relative to the download root (e.g. `42/12/0.jpg`).
abstract class DownloadStorage {
  static final DownloadStorage instance = createDownloadStorage();

  /// Synchronous capability check, for deciding whether download UI is shown
  /// at all.
  bool get supported;

  /// Whether the user can pick where downloads go.
  bool get canPickLocation;

  /// Whether the downloaded files live somewhere the user can't browse to
  /// (the browser's origin-private storage), so exporting is the only way
  /// to get at them.
  bool get isPrivate;

  Future<DownloadStorageStatus> status();

  /// Shown in settings: a path natively, the picked folder's name on web.
  /// `null` when [isPrivate].
  Future<String?> location();

  /// Returns whether a new location was picked.
  Future<bool> pickLocation();

  Future<void> resetLocation();

  /// Returns whether access is now granted.
  Future<bool> requestPermission();

  /// Names of the subdirectories of [dir].
  Future<List<String>> listDirs([String dir = '']);

  /// Names of the files directly inside [dir]; empty if [dir] doesn't exist.
  Future<List<String>> listFiles(String dir);

  Future<bool> exists(String path);

  /// `null` if [path] doesn't exist.
  Future<Uint8List?> read(String path);

  /// Creates parent directories as needed.
  Future<void> write(String path, Uint8List bytes);

  /// `null` if [path] doesn't exist.
  Future<int?> fileSize(String path);

  /// No-op if [path] doesn't exist.
  Future<void> deleteFile(String path);

  /// Recursive; no-op if [dir] doesn't exist.
  Future<void> deleteDir(String dir);

  /// Renames [from] to [to] in one step, when the backend can. [to] must not
  /// exist. Returns false when it can't, so callers fall back to [copyDir].
  Future<bool> renameDir(String from, String to) async => false;

  /// Copies every file under [from] into [to], recursively.
  Future<void> copyDir(String from, String to) async {
    for (final file in await listFiles(from)) {
      final bytes = await read('$from/$file');
      if (bytes != null) await write('$to/$file', bytes);
    }
    for (final dir in await listDirs(from)) {
      await copyDir('$from/$dir', '$to/$dir');
    }
  }

  Future<int> totalSize();

  /// Displayable sources for the page images in [dir], in page order;
  /// `null` if there are none. Pass the result to [pageImage], and to
  /// [releasePageSources] once the reader is done with them.
  Future<List<String>?> loadPageSources(String dir);

  Widget pageImage(String source, {required BoxFit fit, required Alignment alignment, double? height});

  void releasePageSources(List<String> sources) {}

  /// Bundles [mangaDir] into `<name>.cbz`: a browser download on web, a save
  /// dialog on desktop, a picked folder on mobile. Returns the
  /// written path when there is one to show; `null` on web or when the save
  /// dialog was cancelled.
  Future<String?> exportCbz(String mangaDir, String name);
}

/// Sort key for files named `<page index>.<ext>`.
int pageIndexOf(String fileName) => int.tryParse(fileName.split('.').first) ?? 0;

DownloadStorage get downloadStorage => DownloadStorage.instance;
