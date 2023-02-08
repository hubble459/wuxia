import 'package:flutter/material.dart';
import 'package:wuxia/partial/dialog/open_url_dialog.dart';

class OpenURLAction extends StatelessWidget {
  final String url;

  const OpenURLAction({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => OpenURLDialog(url: url));
      },
      icon: const Icon(Icons.open_in_browser),
    );
  }
}
