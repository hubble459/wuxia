import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wuxia/util/download_manager.dart';
import 'package:wuxia/util/download_storage/download_storage.dart';

/// Re-requests access to a previously picked web download folder. Must run
/// from a user gesture (a button press). Returns whether access is granted;
/// once it is, any download queued while access was missing starts.
Future<bool> reconnectDownloads(BuildContext context) async {
  final granted = await downloadStorage.requestPermission();
  if (granted) downloadManager.resume();
  if (!granted && context.mounted) {
    Fluttertoast.showToast(msg: FlutterI18n.translate(context, 'downloads.reconnect_failed')).ignore();
  }
  return granted;
}

/// Shows a snackbar with a "Reconnect" action when the picked web download
/// folder needs its access re-granted (browsers reset it between visits
/// unless "Allow on every visit" was chosen).
Future<void> promptDownloadReconnectIfNeeded(BuildContext context, {VoidCallback? onReconnected}) async {
  if (!downloadStorage.supported) return;
  if (await downloadStorage.status() != DownloadStorageStatus.needsPermission) return;
  final folder = await downloadStorage.location() ?? '';
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 15),
      content: Text(FlutterI18n.translate(context, 'downloads.reconnect_message', translationParams: {'folder': folder})),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, 'downloads.reconnect'),
        onPressed: () async {
          if (await reconnectDownloads(context)) onReconnected?.call();
        },
      ),
    ),
  );
}
