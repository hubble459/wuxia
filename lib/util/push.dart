import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/util/store.dart';

// Web push key for FCM, supplied at build time via --dart-define=VAPID_KEY.
const _vapidKey = String.fromEnvironment('VAPID_KEY');

StreamSubscription<String>? _registered;

/// Registers this device with Firebase so it gets new-chapter notifications. rumgap is
/// given the id Firebase sends to (the Firebase Installation ID), now and whenever it
/// changes. Needs notification permission already granted.
Future<void> registerForPush() async {
  final messaging = FirebaseMessaging.instance;
  _registered ??= messaging.onRegistered.listen(
    (pushId) => _giveRumgap(pushId).catchError((Object e) => debugPrint('Failed to register push id: $e')),
  );
  await messaging.register(vapidKey: _vapidKey.isEmpty ? null : _vapidKey);
}

/// Adds [pushId] to rumgap and removes the id this device gave it before, so the device
/// isn't notified twice.
Future<void> _giveRumgap(String pushId) async {
  final store = Store.getStoreInstance();
  final previous = store.getPushId();
  if (!API.loggedIn.deviceIds.contains(pushId)) {
    await api.user.addDeviceToken(DeviceTokenRequest(token: pushId));
  }
  if (previous != null && previous != pushId) {
    await api.user.removeDeviceToken(DeviceTokenRequest(token: previous));
  }
  await store.setPushId(pushId);
}
