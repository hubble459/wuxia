import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

import 'cbz.dart';
import 'download_storage.dart';

DownloadStorage createDownloadStorage() => WebDownloadStorage();

// File System Access API bits package:web doesn't bind (Chromium-only).
extension type _PermissionDescriptor._(JSObject _) implements JSObject {
  external factory _PermissionDescriptor({String mode});
}

extension type _DirectoryPickerOptions._(JSObject _) implements JSObject {
  external factory _DirectoryPickerOptions({String id, String mode});
}

@JS('showDirectoryPicker')
external JSPromise<web.FileSystemDirectoryHandle> _showDirectoryPicker(_DirectoryPickerOptions options);

extension on web.FileSystemHandle {
  external JSPromise<JSString> queryPermission(_PermissionDescriptor descriptor);
  external JSPromise<JSString> requestPermission(_PermissionDescriptor descriptor);
}

extension on web.FileSystemDirectoryHandle {
  external JSObject values();

  Stream<web.FileSystemHandle> entries() async* {
    final iterator = values();
    while (true) {
      final result = await iterator.callMethod<JSPromise<JSObject>>('next'.toJS).toDart;
      if ((result['done'] as JSBoolean?)?.toDart ?? true) return;
      yield result['value'] as web.FileSystemHandle;
    }
  }
}

const _idbName = 'wuxia';
const _idbStore = 'handles';
const _idbRootKey = 'downloadRoot';

class WebDownloadStorage extends DownloadStorage {
  web.FileSystemDirectoryHandle? _picked;
  bool _pickedLoaded = false;
  web.FileSystemDirectoryHandle? _opfs;

  static bool get _hasPicker => globalContext.has('showDirectoryPicker');

  static bool get _hasOpfs {
    final navigator = web.window.navigator as JSObject;
    if (!navigator.has('storage')) return false;
    if (!(navigator['storage'] as JSObject).has('getDirectory')) return false;
    final fileHandle = globalContext['FileSystemFileHandle'] as JSObject?;
    return (fileHandle?['prototype'] as JSObject?)?.has('createWritable') ?? false;
  }

  @override
  bool get supported => _hasPicker || _hasOpfs;

  @override
  bool get canPickLocation => _hasPicker;

  @override
  bool get isPrivate => _picked == null;

  Future<web.FileSystemDirectoryHandle?> _pickedHandle() async {
    if (!_pickedLoaded) {
      try {
        _picked = await _idbGet(_idbRootKey) as web.FileSystemDirectoryHandle?;
      } catch (_) {}
      _pickedLoaded = true;
    }
    return _picked;
  }

  Future<String> _permission(web.FileSystemDirectoryHandle handle, {required bool request}) async {
    final descriptor = _PermissionDescriptor(mode: 'readwrite');
    final result = request ? handle.requestPermission(descriptor) : handle.queryPermission(descriptor);
    return (await result.toDart).toDart;
  }

  Future<web.FileSystemDirectoryHandle> _root() async {
    final picked = await _pickedHandle();
    if (picked != null) {
      if (await _permission(picked, request: false) != 'granted') {
        throw StateError('Access to the download folder "${picked.name}" needs to be granted again');
      }
      return picked;
    }
    if (_opfs != null) return _opfs!;
    final storage = web.window.navigator.storage;
    storage.persist().toDart.ignore();
    final opfsRoot = await storage.getDirectory().toDart;
    return _opfs = await opfsRoot.getDirectoryHandle('downloads', web.FileSystemGetDirectoryOptions(create: true)).toDart;
  }

  @override
  Future<DownloadStorageStatus> status() async {
    if (!supported) return DownloadStorageStatus.unsupported;
    final picked = await _pickedHandle();
    if (picked == null) return _hasOpfs ? DownloadStorageStatus.ready : DownloadStorageStatus.unsupported;
    try {
      return await _permission(picked, request: false) == 'granted'
          ? DownloadStorageStatus.ready
          : DownloadStorageStatus.needsPermission;
    } catch (_) {
      return DownloadStorageStatus.needsPermission;
    }
  }

  @override
  Future<String?> location() async => (await _pickedHandle())?.name;

  @override
  Future<bool> pickLocation() async {
    final web.FileSystemDirectoryHandle handle;
    try {
      handle = await _showDirectoryPicker(_DirectoryPickerOptions(id: 'wuxia-downloads', mode: 'readwrite')).toDart;
    } catch (_) {
      // User dismissed the picker.
      return false;
    }
    await _idbPut(_idbRootKey, handle);
    _picked = handle;
    _pickedLoaded = true;
    return true;
  }

  @override
  Future<void> resetLocation() async {
    await _idbDelete(_idbRootKey);
    _picked = null;
    _pickedLoaded = true;
  }

  @override
  Future<bool> requestPermission() async {
    final picked = await _pickedHandle();
    if (picked == null) return true;
    try {
      return await _permission(picked, request: true) == 'granted';
    } catch (_) {
      return false;
    }
  }

  List<String> _segments(String path) => path.split('/').where((s) => s.isNotEmpty).toList();

  Future<web.FileSystemDirectoryHandle?> _dir(String path, {bool create = false}) async {
    var dir = await _root();
    for (final segment in _segments(path)) {
      try {
        dir = await dir.getDirectoryHandle(segment, web.FileSystemGetDirectoryOptions(create: create)).toDart;
      } catch (_) {
        if (create) rethrow;
        return null;
      }
    }
    return dir;
  }

  Future<web.FileSystemFileHandle?> _file(String path) async {
    final segments = _segments(path);
    final dir = await _dir(segments.sublist(0, segments.length - 1).join('/'));
    if (dir == null) return null;
    try {
      return await dir.getFileHandle(segments.last).toDart;
    } catch (_) {
      return null;
    }
  }

  Future<List<web.FileSystemHandle>> _list(String dir, String kind) async {
    final handle = await _dir(dir);
    if (handle == null) return [];
    return [
      await for (final entry in handle.entries())
        if (entry.kind == kind) entry,
    ];
  }

  @override
  Future<List<String>> listDirs([String dir = '']) async => (await _list(dir, 'directory')).map((e) => e.name).toList();

  @override
  Future<List<String>> listFiles(String dir) async => (await _list(dir, 'file')).map((e) => e.name).toList();

  @override
  Future<bool> exists(String path) async => await _file(path) != null;

  @override
  Future<Uint8List?> read(String path) async {
    final handle = await _file(path);
    if (handle == null) return null;
    final file = await handle.getFile().toDart;
    return (await file.arrayBuffer().toDart).toDart.asUint8List();
  }

  @override
  Future<void> write(String path, Uint8List bytes) async {
    final segments = _segments(path);
    final dir = await _dir(segments.sublist(0, segments.length - 1).join('/'), create: true);
    final handle = await dir!.getFileHandle(segments.last, web.FileSystemGetFileOptions(create: true)).toDart;
    final writable = await handle.createWritable().toDart;
    await writable.write(bytes.toJS).toDart;
    await writable.close().toDart;
  }

  @override
  Future<void> deleteDir(String dir) async {
    final segments = _segments(dir);
    final parent = await _dir(segments.sublist(0, segments.length - 1).join('/'));
    if (parent == null) return;
    try {
      await parent.removeEntry(segments.last, web.FileSystemRemoveOptions(recursive: true)).toDart;
    } catch (_) {}
  }

  @override
  Future<int> totalSize() async {
    Future<int> sizeOf(web.FileSystemDirectoryHandle dir) async {
      var total = 0;
      await for (final entry in dir.entries()) {
        if (entry.kind == 'file') {
          total += (await (entry as web.FileSystemFileHandle).getFile().toDart).size;
        } else {
          total += await sizeOf(entry as web.FileSystemDirectoryHandle);
        }
      }
      return total;
    }

    return sizeOf(await _root());
  }

  @override
  Future<List<String>?> loadPageSources(String dir) async {
    final files = (await _list(dir, 'file')).cast<web.FileSystemFileHandle>();
    if (files.isEmpty) return null;
    files.sort((a, b) => pageIndexOf(a.name).compareTo(pageIndexOf(b.name)));
    return [for (final handle in files) web.URL.createObjectURL(await handle.getFile().toDart)];
  }

  // Blob URLs go through the same HTML <img> path as online pages, which
  // sidesteps CanvasKit's texture-size cap on long strips.
  @override
  Widget pageImage(String source, {required BoxFit fit, required Alignment alignment, double? height}) {
    return Image.network(
      source,
      webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
      alignment: alignment,
      filterQuality: FilterQuality.high,
      fit: fit,
      width: double.infinity,
      height: height,
    );
  }

  @override
  void releasePageSources(List<String> sources) {
    for (final source in sources) {
      web.URL.revokeObjectURL(source);
    }
  }

  @override
  Future<String?> exportCbz(String mangaDir) async {
    final zip = StoredZipBuilder();
    final parts = <JSAny>[];
    for (final chapter in sortChapterFolders(await listDirs(mangaDir))) {
      final pages = (await _list('$mangaDir/$chapter', 'file')).cast<web.FileSystemFileHandle>();
      pages.sort((a, b) => pageIndexOf(a.name).compareTo(pageIndexOf(b.name)));
      for (final page in pages) {
        final file = await page.getFile().toDart;
        final crc = crc32((await file.arrayBuffer().toDart).toDart.asUint8List());
        parts
          ..add(zip.add(cbzEntryName(chapter, page.name, pageIndexOf(page.name)), file.size, crc).toJS)
          // The page's on-disk File, so its bytes never have to stay in memory.
          ..add(file);
      }
    }
    parts.add(zip.finish().toJS);

    final blob = web.Blob(parts.toJS, web.BlobPropertyBag(type: 'application/vnd.comicbook+zip'));
    final url = web.URL.createObjectURL(blob);
    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = '$mangaDir.cbz';
    web.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    Timer(const Duration(minutes: 1), () => web.URL.revokeObjectURL(url));
    return null;
  }
}

Future<web.IDBDatabase> _idbOpen() {
  final request = web.window.indexedDB.open(_idbName, 1);
  request.onupgradeneeded = ((web.Event _) {
    (request.result as web.IDBDatabase).createObjectStore(_idbStore);
  }).toJS;
  return _idbResult(request).then((db) => db as web.IDBDatabase);
}

Future<JSAny?> _idbResult(web.IDBRequest request) {
  final completer = Completer<JSAny?>();
  request.onsuccess = ((web.Event _) => completer.complete(request.result)).toJS;
  request.onerror = ((web.Event _) => completer.completeError(request.error ?? 'IndexedDB error')).toJS;
  return completer.future;
}

Future<T> _idb<T>(String mode, Future<T> Function(web.IDBObjectStore store) action) async {
  final db = await _idbOpen();
  try {
    return await action(db.transaction(_idbStore.toJS, mode).objectStore(_idbStore));
  } finally {
    db.close();
  }
}

Future<JSAny?> _idbGet(String key) => _idb('readonly', (store) => _idbResult(store.get(key.toJS)));

Future<void> _idbPut(String key, JSAny value) => _idb('readwrite', (store) => _idbResult(store.put(value, key.toJS)));

Future<void> _idbDelete(String key) => _idb('readwrite', (store) => _idbResult(store.delete(key.toJS)));
