import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;
  final Color? confirmColor;

  const ConfirmDialog({
    super.key,
    required this.message,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        FlutterI18n.translate(context, 'dialog.confirm.title'),
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      children: [
        Text(message),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: I18nText('dialog.confirm.no'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(confirmColor ?? Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: I18nText('dialog.confirm.yes'),
            ),
          ],
        )
      ],
    );
  }
}
