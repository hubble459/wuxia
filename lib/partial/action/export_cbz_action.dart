import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';
import 'package:wuxia/util/tools.dart';

/// Exports a downloaded source of a manga as a `.cbz` (source [sourceId], or
/// the most complete downloaded one), toasting where it was saved (or why it
/// failed). No-op if the manga isn't downloaded. The file is named after the
/// manga, plus the source's hostname when more than one source is downloaded.
Future<void> exportMangaCbz(BuildContext context, int mangaId, {int? sourceId}) async {
  try {
    final source = await findDownloadedSource(mangaId, sourceId: sourceId);
    final manga = await loadOfflineManga(mangaId);
    var name = manga?.title ?? '$mangaId';
    if ((await listDownloadedSources(mangaId)).length > 1) {
      final hostname = manga?.sources.where((s) => s.id == source?.sourceId).firstOrNull?.hostname;
      if (hostname != null) name = '$name ($hostname)';
    }
    final path = source == null ? null : await downloadStorage.exportCbz(source.dir, safeFileName(name));
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
