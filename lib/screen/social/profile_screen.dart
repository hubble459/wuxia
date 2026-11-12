import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/friend.pb.dart';
import 'package:wuxia/partial/logged_in_gate.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/partial/simple_future_builder.dart';
import 'package:wuxia/partial/stats/stats_widgets.dart';
import 'package:wuxia/screen/setting/statistics_screen.dart';
import 'package:wuxia/screen/social/friends_screen.dart';

String _t(BuildContext context, String key, [Map<String, String>? params]) =>
    FlutterI18n.translate(context, 'social.$key', translationParams: params);

/// Someone's profile: who they are, follow/unfollow, and - when they're public - their stats and
/// what they're reading right now.
class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) => LoggedInGate(builder: (context) => _Profile(username: username));
}

class _Profile extends StatefulWidget {
  final String username;

  const _Profile({required this.username});

  @override
  State<_Profile> createState() => _ProfileState();
}

class _ProfileState extends State<_Profile> {
  late Future<ProfileReply> _profile = _load();
  bool _busy = false;

  Future<ProfileReply> _load() => api.friend.profile(
        ProfileRequest(username: widget.username, utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes),
      );

  Future<void> _toggleFollow(ProfileReply profile) async {
    setState(() => _busy = true);
    try {
      final request = FriendRequest(userId: profile.user.id);
      profile.user.followedByMe ? await api.friend.unfollow(request) : await api.friend.follow(request);
      final next = _load();
      setState(() => _profile = next);
      await next;
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: SimpleFutureBuilder<ProfileReply>(
        future: _profile,
        onErrorBuilder: (context, error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(errorMessage(error ?? ''), textAlign: TextAlign.center),
          ),
        ),
        onLoadedBuilder: (context, profile) {
          final header = _Header(profile: profile, busy: _busy, onToggleFollow: () => _toggleFollow(profile));
          return RefreshIndicator(
            onRefresh: () async {
              final next = _load();
              setState(() => _profile = next);
              await next;
            },
            child: ResponsiveContent(
              child: profile.visible && profile.hasStats()
                  ? StatsView(data: profile.stats, isMe: false, header: [header])
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [header, const _PrivateNotice()],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ProfileReply profile;
  final bool busy;
  final VoidCallback onToggleFollow;

  const _Header({required this.profile, required this.busy, required this.onToggleFollow});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = profile.user;
    final relation = profile.isMe
        ? _t(context, 'this_is_you')
        : [
            if (user.followedByMe && user.followsMe) _t(context, 'mutual'),
            if (!user.followedByMe && user.followsMe) _t(context, 'follows_you'),
          ].join(' · ');

    Widget count(int value, String label) => Column(
          children: [
            Text(groupDigits(value), style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            Text(label, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60)),
          ],
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(username: user.username, radius: 34),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.username,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        if (user.isPrivate)
                          const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.lock, size: 18)),
                      ],
                    ),
                    Text(
                      _t(context, 'member_since', {
                        'date': Jiffy.parseFromMillisecondsSinceEpoch(profile.memberSince.toInt()).yMMMd,
                      }),
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                    ),
                    if (relation.isNotEmpty)
                      Text(relation, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: count(profile.countFollowing.toInt(), _t(context, 'following'))),
              Expanded(child: count(profile.countFollowers.toInt(), _t(context, 'followers'))),
              if (!profile.isMe)
                Expanded(
                  child: user.followedByMe
                      ? OutlinedButton(onPressed: busy ? null : onToggleFollow, child: Text(_t(context, 'unfollow')))
                      : FilledButton(
                          onPressed: busy ? null : onToggleFollow,
                          child: Text(_t(context, user.followsMe ? 'follow_back' : 'follow')),
                        ),
                ),
            ],
          ),
          if (profile.isMe && user.isPrivate)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _t(context, 'own_private_hint'),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white54),
              ),
            ),
        ],
      ),
    );
  }
}

class _PrivateNotice extends StatelessWidget {
  const _PrivateNotice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text('🔒', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          Text(_t(context, 'private_title'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            _t(context, 'private_body'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
