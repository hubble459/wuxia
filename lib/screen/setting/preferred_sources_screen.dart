import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/api.dart';
import 'package:wuxia/gen/rumgap/v1/meta.pb.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/util/session.dart';

/// Orders the hostnames a manga is shown through when the user hasn't picked a source for it.
class PreferredSourcesScreen extends StatefulWidget {
  const PreferredSourcesScreen({super.key});

  @override
  State<PreferredSourcesScreen> createState() => _PreferredSourcesScreenState();
}

class _PreferredSourcesScreenState extends State<PreferredSourcesScreen> {
  // A web deep link can land here directly, skipping the screens that
  // normally restore credentials before this screen reads API.loggedIn.
  bool _ready = false;
  String? _error;

  final List<String> _preferred = [];
  final List<String> _others = [];

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await restoreSession();
    if (!mounted) return;

    if (!API.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('login');
      return;
    }

    try {
      final hostnames = await api.meta.hostnames(MetaHostnamesRequest(option: MetaHostnamesOption.HostnamesManga));
      _preferred.addAll(API.loggedIn.preferredHostnames);
      _others.addAll(hostnames.items.toSet().difference(_preferred.toSet()).toList()..sort());
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _ready = true);
  }

  Future<void> _save() async {
    try {
      API.loggedIn = await api.user.update(UserUpdateRequest(preferredHostnames: _preferred));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _toggle(String hostname) {
    if (_preferred.contains(hostname)) {
      if (_preferred.length == 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, 'settings.preferred_sources.keep_one'))));
        return;
      }
      setState(() {
        _preferred.remove(hostname);
        _others
          ..add(hostname)
          ..sort();
      });
    } else {
      setState(() {
        _others.remove(hostname);
        _preferred.add(hostname);
      });
    }
    _save();
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() => _preferred.insert(newIndex, _preferred.removeAt(oldIndex)));
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: I18nText('settings.preferred_sources.title')),
      body: !_ready
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(padding: const EdgeInsets.all(16.0), child: I18nText('settings.preferred_sources.description')),
                ),
                SliverReorderableList(
                  itemCount: _preferred.length,
                  onReorderItem: _reorder,
                  itemBuilder: (context, index) {
                    final hostname = _preferred[index];
                    return Material(
                      key: ValueKey(hostname),
                      child: ListTile(
                        leading: Checkbox(value: true, onChanged: (_) => _toggle(hostname)),
                        title: Text(hostname),
                        trailing: ReorderableDragStartListener(index: index, child: const Icon(Icons.drag_handle)),
                      ),
                    );
                  },
                ),
                if (_preferred.isNotEmpty && _others.isNotEmpty) const SliverToBoxAdapter(child: Divider()),
                SliverList.builder(
                  itemCount: _others.length,
                  itemBuilder: (context, index) {
                    final hostname = _others[index];
                    return ListTile(
                      leading: Checkbox(value: false, onChanged: (_) => _toggle(hostname)),
                      title: Text(hostname),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
