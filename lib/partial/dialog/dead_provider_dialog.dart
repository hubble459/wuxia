import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/screen/search_screen.dart';

class DeadProviderDialog extends StatelessWidget {
  final String mangaTitle;

  const DeadProviderDialog({super.key, required this.mangaTitle});

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
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: I18nText('nav.search')),
                  body: SearchScreen(query: mangaTitle),
                ),
              ),
            );
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
