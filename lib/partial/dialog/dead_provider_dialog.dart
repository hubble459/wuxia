import 'package:flutter/material.dart';

class DeadProviderDialog extends StatelessWidget {
  const DeadProviderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      title: Text('No scrapers available'),
    );
  }
}
