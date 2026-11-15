import 'notification_open_io.dart' if (dart.library.js_interop) 'notification_open_web.dart' as impl;

/// Calls [callback] with the manga id whenever a tapped web notification asks the
/// already-open app to show that manga (see web/firebase-messaging-sw.js). Web only; a
/// no-op on native platforms, where taps arrive through Firebase or the local plugin.
void onNotificationOpen(void Function(int mangaId) callback) => impl.onNotificationOpen(callback);
