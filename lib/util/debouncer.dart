import 'dart:async';

import 'package:flutter/foundation.dart';

/// Runs an action once calls pause for [delay], e.g. searching after typing
/// stops. Each call replaces the action still waiting.
class Debouncer {
  Debouncer([this.delay = const Duration(milliseconds: 500)]);

  final Duration delay;
  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Drops the action still waiting, if any.
  void cancel() => _timer?.cancel();
}
