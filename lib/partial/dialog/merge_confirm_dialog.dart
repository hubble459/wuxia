import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';

/// Confirms a merge direction, showing source-count and latest-update for both sides so
/// the admin can sanity-check which manga is more complete/fresher before committing to an
/// irreversible merge.
Future<bool> showMergeConfirmDialog(
  BuildContext context, {
  required MangaReply source,
  required MangaReply target,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(FlutterI18n.translate(ctx, 'manga.merge-confirm-title')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(FlutterI18n.translate(ctx, 'manga.merge-confirm-body')),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _MergeSide(manga: source, label: FlutterI18n.translate(ctx, 'manga.merge-deleted'))),
                const SizedBox(width: 12),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 12),
                Expanded(child: _MergeSide(manga: target, label: FlutterI18n.translate(ctx, 'manga.merge-survives'))),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(FlutterI18n.translate(ctx, 'basic.cancel')),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(FlutterI18n.translate(ctx, 'basic.confirm')),
        ),
      ],
    ),
  ) ??
      false;
}

class _MergeSide extends StatelessWidget {
  final MangaReply manga;
  final String label;

  const _MergeSide({required this.manga, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
          manga.title.replaceAll('\n', ' '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(FlutterI18n.translate(
          context,
          'manga.source-count',
          translationParams: {'amount': manga.sources.length.toString()},
        )),
        Text(
          '${FlutterI18n.translate(context, 'details.updated')}: '
          '${Jiffy.parseFromMillisecondsSinceEpoch(manga.updatedAt.toInt()).fromNow()}',
        ),
      ],
    );
  }
}
