import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/util/push.dart';

enum _PushState { unsupported, notAsked, blocked, on }

/// Web only: turns on new-chapter notifications. A browser only shows its permission
/// prompt after a tap (an iPhone always), so the app can't ask on start like it does on
/// Android. Shows nothing once they're on.
class PushSettingsTile extends StatefulWidget {
  const PushSettingsTile({super.key});

  @override
  State<PushSettingsTile> createState() => _PushSettingsTileState();
}

class _PushSettingsTileState extends State<PushSettingsTile> {
  _PushState? _state;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final state = await _currentState();
    if (mounted) setState(() => _state = state);
  }

  Future<_PushState> _currentState() async {
    final messaging = FirebaseMessaging.instance;
    if (!await messaging.isSupported()) return _PushState.unsupported;
    return switch ((await messaging.getNotificationSettings()).authorizationStatus) {
      AuthorizationStatus.authorized || AuthorizationStatus.provisional => _PushState.on,
      AuthorizationStatus.denied || AuthorizationStatus.deniedPermanently => _PushState.blocked,
      AuthorizationStatus.notDetermined => _PushState.notAsked,
    };
  }

  Future<void> _turnOn() async {
    setState(() => _busy = true);
    try {
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) await registerForPush();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    _busy = false;
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      null || _PushState.on => const SizedBox.shrink(),
      _PushState.unsupported => ListTile(
        title: I18nText('settings.notifications'),
        subtitle: I18nText('settings.notifications_unsupported'),
      ),
      _PushState.blocked => ListTile(
        title: I18nText('settings.notifications'),
        subtitle: I18nText('settings.notifications_blocked'),
      ),
      _PushState.notAsked => ListTile(
        title: I18nText('settings.notifications_turn_on'),
        subtitle: I18nText('settings.notifications_turn_on_hint'),
        trailing: _busy ? const SizedBox.square(dimension: 24, child: CircularProgressIndicator()) : null,
        onTap: _busy ? null : _turnOn,
      ),
    };
  }
}
