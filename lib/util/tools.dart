import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wuxia/util/store.dart';

Future<Directory> getDownloadDirectory() async {
  final custom = Store.getStoreInstance().getDownloadDir();
  if (custom != null) return Directory(custom);
  return getApplicationDocumentsDirectory();
}
