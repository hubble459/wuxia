import 'package:flutter/material.dart';

/// Shown in place of a manga cover or chapter page that failed to load --
/// scales to whatever box it's given, from a 40px list thumbnail up to a
/// full-width chapter page.
class ImageErrorPlaceholder extends StatelessWidget {
  const ImageErrorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.sentiment_very_dissatisfied_rounded, color: colorScheme.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}
