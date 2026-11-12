import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/util/download_manager.dart';

/// One entry of the download queue on the Downloads screen: overall
/// progress and ETA, a progress bar per chapter being downloaded right now,
/// and cancel / retry controls.
class DownloadTaskTile extends StatelessWidget {
  const DownloadTaskTile({super.key, required this.task});

  final DownloadTask task;

  static String _formatEta(Duration eta) {
    if (eta.inHours > 0) return '${eta.inHours}h ${eta.inMinutes.remainder(60)}m';
    if (eta.inMinutes > 0) return '${eta.inMinutes}m';
    return '${eta.inSeconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return ListenableBuilder(
      listenable: task,
      builder: (context, _) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 4, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.manga.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (task.status == DownloadStatus.failed)
                    IconButton(
                      onPressed: () => downloadManager.retry(task),
                      tooltip: FlutterI18n.translate(context, 'basic.retry'),
                      icon: const Icon(Icons.refresh),
                    ),
                  IconButton(
                    onPressed: () => downloadManager.cancel(task),
                    tooltip: FlutterI18n.translate(
                      context,
                      task.status == DownloadStatus.failed ? 'downloads.dismiss' : 'basic.cancel',
                    ),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: switch (task.status) {
                  DownloadStatus.queued => Text(FlutterI18n.translate(context, 'downloads.queued'), style: muted),
                  DownloadStatus.failed => Text(
                    FlutterI18n.translate(context, 'error', translationParams: {'error': '${task.error}'}),
                    style: muted?.copyWith(color: theme.colorScheme.error),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  DownloadStatus.running => _RunningProgress(task: task, muted: muted, formatEta: _formatEta),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RunningProgress extends StatelessWidget {
  const _RunningProgress({required this.task, required this.muted, required this.formatEta});

  final DownloadTask task;
  final TextStyle? muted;
  final String Function(Duration) formatEta;

  @override
  Widget build(BuildContext context) {
    if (!task.started) return const LinearProgressIndicator();

    return ValueListenableBuilder<int>(
      valueListenable: task.progress,
      builder: (context, downloaded, _) {
        final eta = task.eta;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: downloaded / task.totalChapters),
            const SizedBox(height: 4),
            Text(
              [
                '$downloaded / ${task.totalChapters}',
                if (eta != null) FlutterI18n.translate(context, 'manga.download-eta', translationParams: {'eta': formatEta(eta)}),
              ].join(' · '),
              style: muted,
            ),
            ValueListenableBuilder<List<ActiveChapterProgress>>(
              valueListenable: task.activeChapters,
              builder: (context, active, _) => Column(
                children: [
                  for (final chapter in active)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(width: 40, child: Text(chapter.label, style: muted)),
                          Expanded(
                            child: ValueListenableBuilder<int>(
                              valueListenable: chapter.downloaded,
                              builder: (_, pages, _) =>
                                  LinearProgressIndicator(value: chapter.total == 0 ? null : pages / chapter.total, minHeight: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
