import 'dart:js_interop';

import 'package:web/web.dart' as web;

void onPageUnload(void Function() callback) {
  final listener = ((web.Event _) => callback()).toJS;
  // `beforeunload` fires first, before the browser aborts in-flight
  // requests; `pagehide` also covers unloads that skip it (e.g. bfcache).
  web.window.addEventListener('beforeunload', listener);
  web.window.addEventListener('pagehide', listener);
}
