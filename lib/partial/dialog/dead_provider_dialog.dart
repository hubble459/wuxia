import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/gen/rumgap/v1/manga.pb.dart';
import 'package:wuxia/partial/dialog/source_picker_dialog.dart';
import 'package:wuxia/screen/search_screen.dart';

class DeadProviderDialog extends StatelessWidget {
  final String mangaTitle;
  final int mangaId;
  final List<MangaSourceReply> sources;
  final void Function(MangaSourceReply source) onSwitchSource;

  /// Called when the "search alternatives" fallback comes back with a newly
  /// added source (see `SearchMangaItem`'s `existingMangaId` branch), so the
  /// caller can refresh its `sources` list without waiting for a full reload.
  final void Function(MangaReply manga)? onMangaUpdated;

  const DeadProviderDialog({
    super.key,
    required this.mangaTitle,
    required this.mangaId,
    required this.sources,
    required this.onSwitchSource,
    this.onMangaUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      title: Text(
        FlutterI18n.translate(context, 'dead_provider.title'),
        textAlign: TextAlign.center,
      ),
      children: [
        Text(FlutterI18n.translate(context, 'dead_provider.message')),
        const SizedBox(height: 12.0),
        // A source you already have is a faster recovery than searching for
        // a replacement -- offer it first when there's more than one.
        if (sources.length > 1)
          SimpleDialogOption(
            onPressed: () async {
              final selected = await showSourcePickerDialog(context, sources);
              if (selected != null) {
                onSwitchSource(selected);
              }
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Text(FlutterI18n.translate(context, 'manga.switch_source')),
          ),
        SimpleDialogOption(
          onPressed: () async {
            Navigator.of(context).pop();
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: I18nText('nav.search')),
                  body: SearchScreen(query: mangaTitle, existingMangaId: mangaId),
                ),
              ),
            );
            if (result is MangaReply) {
              onMangaUpdated?.call(result);
            }
          },
          child: Text(FlutterI18n.translate(context, 'dead_provider.search_alternatives')),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
