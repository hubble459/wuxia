import 'package:flutter/material.dart';

/// Centers [child] and caps its width so content doesn't stretch edge-to-edge
/// on wide desktop windows -- these screens were built for phone-width
/// portrait layouts.
class ResponsiveContent extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveContent({super.key, required this.child, this.maxWidth = 700});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
