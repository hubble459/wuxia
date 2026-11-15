import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';

// Web push key for FCM, supplied at build time via --dart-define=VAPID_KEY.
const _vapidKey = String.fromEnvironment('VAPID_KEY');

/// Registers this device's push token with rumgap, so it gets new-chapter
/// notifications. Needs notification permission already granted. Returns the token.
Future<String?> registerPushToken() async {
  final token = await FirebaseMessaging.instance.getToken(vapidKey: _vapidKey.isEmpty ? null : _vapidKey);
  if (token != null && !API.loggedIn.deviceIds.contains(token)) {
    await api.user.addDeviceToken(DeviceTokenRequest(token: token));
  }
  return token;
}
