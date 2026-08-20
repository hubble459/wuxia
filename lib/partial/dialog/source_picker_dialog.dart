import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';

/// Shared "pick a source" list, reused by the manga screen, the chapter
/// reader, and the dead-provider recovery dialog.
Future<MangaSourceReply?> showSourcePickerDialog(BuildContext context, List<MangaSourceReply> sources) {
  return showDialog<MangaSourceReply>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: Text(FlutterI18n.translate(ctx, 'manga.switch_source')),
      children: sources
          .map((source) => SimpleDialogOption(
                onPressed: () => Navigator.of(ctx).pop(source),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('${source.hostname} (${source.language})'),
                    ),
                    if (source.isPrimary)
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(Icons.star, size: 16),
                      ),
                  ],
                ),
              ))
          .toList(),
    ),
  );
}
