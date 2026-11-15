import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// The channel new-chapter notifications are posted to, by the app while it's open and
/// by Firebase while it's closed (see `default_notification_channel_id` in
/// AndroidManifest.xml), so they share one switch in Android's notification settings.
const _newChapters = AndroidNotificationChannel(
  'new_chapters',
  'New chapters',
  description: 'A manga in your reading list has a new chapter.',
  importance: Importance.high,
);

final _plugin = FlutterLocalNotificationsPlugin();

/// Creates the new-chapters channel and calls [onOpen] with the manga id whenever one of
/// these notifications is tapped, including the one that launched the app. Android only.
Future<void> initLocalNotifications(void Function(int mangaId) onOpen) async {
  void open(NotificationResponse response) {
    final mangaId = int.tryParse(response.payload ?? '');
    if (mangaId != null) onOpen(mangaId);
  }

  await _plugin.initialize(
    settings: const InitializationSettings(android: AndroidInitializationSettings('ic_notification')),
    onDidReceiveNotificationResponse: open,
  );
  await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
    _newChapters,
  );

  final launch = await _plugin.getNotificationAppLaunchDetails();
  final response = launch?.notificationResponse;
  if (launch?.didNotificationLaunchApp == true && response != null) open(response);
}

/// Posts a new-chapter notification for manga [mangaId], the same as the one Firebase
/// shows while the app is closed. A newer one for the same manga replaces it.
Future<void> showNewChapterNotification({required int mangaId, String? title, String? body}) {
  return _plugin.show(
    id: mangaId,
    title: title,
    body: body,
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        _newChapters.id,
        _newChapters.name,
        channelDescription: _newChapters.description,
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    payload: '$mangaId',
  );
}
