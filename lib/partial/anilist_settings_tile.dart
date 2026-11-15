import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/anilist.pb.dart';
import 'package:wuxia/gen/rumgap/v1/v1.pb.dart' show Empty;

/// Connects the user's AniList account. Connecting opens AniList in the browser, which
/// redirects back to rumgap; the status is fetched again once the app is back in front
/// (or, on web, when the redirect reloads the app with `?anilist=`).
class AnilistSettingsTile extends StatefulWidget {
  const AnilistSettingsTile({super.key});

  @override
  State<AnilistSettingsTile> createState() => _AnilistSettingsTileState();
}

class _AnilistSettingsTileState extends State<AnilistSettingsTile> with WidgetsBindingObserver {
  AnilistStatusReply? _status;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showRedirectOutcome());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _load();
  }

  void _showRedirectOutcome() {
    if (!kIsWeb || !mounted) return;
    final outcome = Uri.base.queryParameters['anilist'];
    if (outcome == null) return;
    final key = outcome == 'connected' ? 'anilist.connected' : 'anilist.connect_failed';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, key))));
  }

  Future<void> _load() async {
    try {
      final status = await api.anilist.status(Empty());
      if (mounted) setState(() => _status = status);
    } catch (_) {
      // Offline; keep showing what we had.
    }
  }

  Future<void> _connect() async {
    setState(() => _busy = true);
    try {
      final reply = await api.anilist.connectUrl(
        AnilistConnectUrlRequest(
          returnTarget: kIsWeb ? AnilistReturnTarget.ANILIST_RETURN_WEB : AnilistReturnTarget.ANILIST_RETURN_APP,
        ),
      );
      await launchUrlString(
        reply.url,
        mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
        webOnlyWindowName: '_self',
      );
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _disconnect() async {
    setState(() => _busy = true);
    try {
      await api.anilist.disconnect(Empty());
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;
    if (status == null || !status.connected) {
      return ListTile(
        leading: const Icon(Icons.sync),
        title: I18nText('anilist.connect'),
        subtitle: I18nText('anilist.connect_hint'),
        trailing: _busy ? const SizedBox.square(dimension: 24, child: CircularProgressIndicator()) : null,
        onTap: _busy ? null : _connect,
      );
    }

    return ListTile(
      leading: const Icon(Icons.sync),
      title: Text(FlutterI18n.translate(context, 'anilist.connected_as', translationParams: {'name': status.userName})),
      subtitle: Text(
        FlutterI18n.translate(
          context,
          status.expiresSoon ? 'anilist.expires_soon' : 'anilist.expires',
          translationParams: {'date': _expiry(status)},
        ),
        style: status.expiresSoon ? const TextStyle(color: Colors.orange) : null,
      ),
      trailing: Wrap(
        spacing: 4,
        children: [
          if (status.expiresSoon) TextButton(onPressed: _busy ? null : _connect, child: I18nText('anilist.reconnect')),
          TextButton(
            onPressed: _busy ? null : _disconnect,
            child: Text(FlutterI18n.translate(context, 'anilist.disconnect'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _expiry(AnilistStatusReply status) =>
      status.hasExpiresAt() ? Jiffy.parseFromMillisecondsSinceEpoch(status.expiresAt.toInt()).fromNow() : '?';
}
