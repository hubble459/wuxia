import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenURLDialog extends StatelessWidget {
  final String url;

  const OpenURLDialog({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        FlutterI18n.translate(context, 'dialog.open_url'),
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      children: [
        Text(
          url,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary)),
                onPressed: () async {
                  try {
                    await Clipboard.setData(ClipboardData(text: url));
                    Fluttertoast.showToast(msg: 'URL Copied to clipboard!');
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                child: const Text('Copy'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  launchUrlString(url, mode: LaunchMode.externalApplication);
                },
                child: const Text('Open'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
