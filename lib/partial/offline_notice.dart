import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/util/tools.dart';

/// Route argument that makes `root_nav` open on its Downloads tab.
const rootNavDownloadsArgument = 'downloads';

/// Shown in place of a network error: the server can't be reached, but
/// downloaded manga still can.
class OfflineNotice extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineNotice({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48),
            const SizedBox(height: 12),
            Text(FlutterI18n.translate(context, 'offline.title'), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              FlutterI18n.translate(context, downloadsSupported ? 'offline.message_downloads' : 'offline.message'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                if (downloadsSupported)
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil('root_nav', (_) => false, arguments: rootNavDownloadsArgument),
                    icon: const Icon(Icons.download),
                    label: Text(FlutterI18n.translate(context, 'offline.go_to_downloads')),
                  ),
                if (onRetry != null)
                  OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(FlutterI18n.translate(context, 'basic.retry')),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
