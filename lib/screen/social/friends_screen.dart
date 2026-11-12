import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/friend.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/partial/logged_in_gate.dart';
import 'package:wuxia/partial/responsive_content.dart';
import 'package:wuxia/util/app_routes.dart';

String _t(BuildContext context, String key, [Map<String, String>? params]) =>
    FlutterI18n.translate(context, 'social.$key', translationParams: params);

/// Follow people by their exact username, and see who you follow and who follows you.
class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) => LoggedInGate(builder: (context) => const _Friends());
}

class _Friends extends StatefulWidget {
  const _Friends();

  @override
  State<_Friends> createState() => _FriendsState();
}

class _FriendsState extends State<_Friends> {
  final _username = TextEditingController();
  final _following = GlobalKey<_UserListState>();
  final _followers = GlobalKey<_UserListState>();
  bool _busy = false;

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  Future<void> _follow() async {
    final username = _username.text.trim();
    if (username.isEmpty || _busy) return;
    setState(() => _busy = true);
    try {
      final user = await api.friend.follow(FriendRequest(username: username));
      _username.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_t(context, 'followed', {'username': user.username}))));
      _following.currentState?.reload();
      _followers.currentState?.reload();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_t(context, 'friends')),
          bottom: TabBar(
            tabs: [
              Tab(text: _t(context, 'following')),
              Tab(text: _t(context, 'followers')),
            ],
          ),
        ),
        body: ResponsiveContent(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _username,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _follow(),
                        decoration: InputDecoration(
                          labelText: _t(context, 'follow_by_username'),
                          prefixIcon: const Icon(Icons.alternate_email),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _busy ? null : _follow,
                      child: _busy
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(_t(context, 'follow')),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _t(context, 'username_only_hint'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _UserList(key: _following, following: true),
                    _UserList(key: _followers, following: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserList extends StatefulWidget {
  final bool following;

  const _UserList({super.key, required this.following});

  @override
  State<_UserList> createState() => _UserListState();
}

class _UserListState extends State<_UserList> with AutomaticKeepAliveClientMixin {
  final List<UserSummary> _users = [];
  Int64 _nextPage = Int64.ZERO;
  bool _hasMore = true;
  bool _loading = false;
  Object? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  void reload() {
    setState(() {
      _users.clear();
      _nextPage = Int64.ZERO;
      _hasMore = true;
      _error = null;
    });
    _loadMore();
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);
    try {
      final query = PaginateQuery(page: _nextPage, perPage: Int64(30));
      final reply = widget.following ? await api.friend.following(query) : await api.friend.followers(query);
      if (!mounted) return;
      setState(() {
        _users.addAll(reply.items);
        _hasMore = reply.items.isNotEmpty && reply.pagination.page < reply.pagination.maxPage;
        _nextPage = reply.pagination.page + 1;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleFollow(int index) async {
    final user = _users[index];
    try {
      final request = FriendRequest(userId: user.id);
      final updated = user.followedByMe ? await api.friend.unfollow(request) : await api.friend.follow(request);
      if (!mounted) return;
      setState(() => _users[index] = updated..since = user.since);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_users.isEmpty) {
      if (_loading) return const Center(child: CircularProgressIndicator());
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            _error != null
                ? errorMessage(_error!)
                : _t(context, widget.following ? 'following_empty' : 'followers_empty'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white60),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => reload(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.extentAfter < 300) _loadMore();
          return false;
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _users.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= _users.length) {
              return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));
            }
            final user = _users[index];
            return UserSummaryTile(
              user: user,
              trailing: widget.following || !user.followedByMe
                  ? TextButton(
                      onPressed: () => _toggleFollow(index),
                      child: Text(_t(context, user.followedByMe ? 'unfollow' : 'follow_back')),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}

/// A user in a list: avatar letter, name, lock when private, and how you're connected.
class UserSummaryTile extends StatelessWidget {
  final UserSummary user;
  final Widget? trailing;

  const UserSummaryTile({super.key, required this.user, this.trailing});

  @override
  Widget build(BuildContext context) {
    final relation = [
      if (user.followedByMe && user.followsMe) _t(context, 'mutual'),
      if (!user.followedByMe && user.followsMe) _t(context, 'follows_you'),
      if (user.since > 0) _t(context, 'since', {'date': Jiffy.parseFromMillisecondsSinceEpoch(user.since.toInt()).yMMMd}),
    ].join(' · ');

    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(profileRouteName(user.username)),
      leading: UserAvatar(username: user.username),
      title: Row(
        children: [
          Flexible(child: Text(user.username, overflow: TextOverflow.ellipsis)),
          if (user.isPrivate) const Padding(padding: EdgeInsets.only(left: 6), child: Icon(Icons.lock, size: 14)),
        ],
      ),
      subtitle: relation.isEmpty ? null : Text(relation),
      trailing: trailing,
    );
  }
}

/// A coloured circle with the username's first letter; the colour is stable per username.
class UserAvatar extends StatelessWidget {
  final String username;
  final double radius;

  const UserAvatar({super.key, required this.username, this.radius = 20});

  static const _colors = [
    Color(0xFF3987E5),
    Color(0xFFD95926),
    Color(0xFF199E70),
    Color(0xFFC98500),
    Color(0xFFD55181),
    Color(0xFF9085E9),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _colors[username.codeUnits.fold(0, (sum, c) => sum + c) % _colors.length];
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        username.isEmpty ? '?' : username.characters.first.toUpperCase(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: radius * 0.9),
      ),
    );
  }
}
