import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/tools.dart';

/// Exports a downloaded manga as a `.cbz`, toasting where it was saved (or
/// why it failed). No-op if the manga isn't downloaded.
Future<void> exportMangaCbz(BuildContext context, int mangaId) async {
  try {
    final dir = await findDownloadedMangaDir(mangaId);
    final path = dir == null ? null : await downloadStorage.exportCbz(dir);
    if (path != null && context.mounted) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'downloads.exported', translationParams: {'path': path}))
          .ignore();
    }
  } catch (e) {
    if (context.mounted) {
      Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'downloads.export_failed', translationParams: {'error': '$e'}))
          .ignore();
    }
  }
}
