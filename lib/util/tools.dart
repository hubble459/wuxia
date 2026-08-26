import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:wuxia/util/store.dart';

/// Offline manga downloads rely on local filesystem access, which isn't
/// available on web -- callers must check this before touching the
/// download directory.
bool get downloadsSupported => !kIsWeb;

Future<Directory> getDownloadDirectory() async {
  if (kIsWeb) {
    throw UnsupportedError('Downloads are not supported on web');
  }
  final custom = Store.getStoreInstance().getDownloadDir();
  if (custom != null) return Directory(custom);
  return getApplicationDocumentsDirectory();
}
