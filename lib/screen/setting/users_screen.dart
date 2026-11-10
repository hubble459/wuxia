import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:grpc/grpc.dart' show GrpcError;
import 'package:wuxia/api.dart';
import 'package:wuxia/constant.dart';
import 'package:wuxia/gen/rumgap/v1/admin.pb.dart';
import 'package:wuxia/gen/rumgap/v1/paginate.pb.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/partial/dialog/confirm_dialog.dart';
import 'package:wuxia/partial/new_password_field.dart';
import 'package:wuxia/util/session.dart';
import 'package:wuxia/util/validator_builder.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // A web deep link can land here directly, skipping the screens that
  // normally restore credentials before this screen reads API.loggedIn.
  bool _ready = false;
  late Future<List<UserReply>> _future;

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

    // The settings menu hides this entry point for non-admins, but a deep link
    // could still land here directly.
    if (!API.loggedIn.isAdmin) {
      Navigator.of(context).pushReplacementNamed('root_nav');
      return;
    }

    setState(() {
      _ready = true;
      _future = _fetchAll();
    });
  }

  /// Walks every page of User.Index
  Future<List<UserReply>> _fetchAll() async {
    final users = <UserReply>[];
    var page = Int64.ZERO;
    while (true) {
      final reply = await api.user.index(PaginateQuery(perPage: Int64(50), page: page));
      users.addAll(reply.items);
      if (reply.pagination.page >= reply.pagination.maxPage) break;
      page = reply.pagination.page + 1;
    }
    users.sort((a, b) => a.username.compareTo(b.username));
    return users;
  }

  void _refresh() {
    setState(() => _future = _fetchAll());
  }

  void _showError(Object e) {
    if (!mounted) return;
    final message = e is GrpcError ? (e.message ?? e.codeName) : '$e';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showMessage(String key, Map<String, String> params) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, key, translationParams: params))));
  }

  Future<void> _create() async {
    final request = await showDialog<AdminCreateUserRequest>(context: context, builder: (context) => const _CreateUserDialog());
    if (request == null) return;

    try {
      await api.admin.createUser(request);
      _showMessage('settings.users.created', {'username': request.username});
      _refresh();
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> _resetPassword(UserReply user) async {
    final password = await showDialog<String>(
      context: context,
      builder: (context) => _ResetPasswordDialog(username: user.username),
    );
    if (password == null) return;

    try {
      await api.admin.setPassword(AdminSetPasswordRequest(id: user.id, password: password));
      _showMessage('settings.users.password_reset', {'username': user.username});
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> _delete(UserReply user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        message: FlutterI18n.translate(context, 'settings.users.delete_confirm', translationParams: {'username': user.username}),
        confirmColor: Colors.red,
      ),
    );
    if (confirmed != true) return;

    try {
      await api.admin.deleteUser(AdminDeleteUserRequest(id: user.id));
      _showMessage('settings.users.deleted', {'username': user.username});
      _refresh();
    } catch (e) {
      _showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: I18nText('settings.users.title'),
        actions: [
          IconButton(
            tooltip: FlutterI18n.translate(context, 'basic.refresh'),
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: FlutterI18n.translate(context, 'settings.users.create'),
        onPressed: _create,
        child: const Icon(Icons.person_add),
      ),
      body: FutureBuilder<List<UserReply>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          final users = snapshot.requireData;
          return RefreshIndicator(
            onRefresh: () async {
              _refresh();
              await _future;
            },
            child: ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                final isSelf = user.id == API.loggedIn.id;
                return ListTile(
                  leading: Icon(user.isAdmin ? Icons.admin_panel_settings : Icons.person),
                  title: Text(
                    isSelf ? '${user.username} ${FlutterI18n.translate(context, 'settings.users.you')}' : user.username,
                  ),
                  subtitle: Text(user.email),
                  trailing: PopupMenuButton<String>(
                    onSelected: (action) {
                      switch (action) {
                        case 'reset_password':
                          _resetPassword(user);
                        case 'delete':
                          _delete(user);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'reset_password', child: I18nText('settings.users.reset_password')),
                      if (!isSelf) PopupMenuItem(value: 'delete', child: I18nText('settings.users.delete')),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CreateUserDialog extends StatefulWidget {
  const _CreateUserDialog();

  @override
  State<_CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<_CreateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _admin = false;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context)
        .pop(AdminCreateUserRequest(username: _username.text, email: _email.text, password: _password.text, admin: _admin));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: I18nText('settings.users.create'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _username,
              autofocus: true,
              textInputAction: TextInputAction.next,
              validator: ValidatorBuilder.translate(context, 'login.username').required().minLength(3).maxLength(20).build(),
              decoration: InputDecoration(label: I18nText('login.username')),
            ),
            const SizedBox(height: Constants.padding),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: ValidatorBuilder.translate(context, 'login.email').required().isEmail().build(),
              decoration: InputDecoration(label: I18nText('login.email')),
            ),
            const SizedBox(height: Constants.padding),
            NewPasswordField(controller: _password, onSubmitted: _submit),
            const SizedBox(height: Constants.padding),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: I18nText('settings.users.admin'),
              value: _admin,
              onChanged: (value) => setState(() => _admin = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: I18nText('basic.cancel')),
        TextButton(onPressed: _submit, child: I18nText('basic.add')),
      ],
    );
  }
}

class _ResetPasswordDialog extends StatefulWidget {
  final String username;

  const _ResetPasswordDialog({required this.username});

  @override
  State<_ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<_ResetPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(_password.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.username),
      content: Form(
        key: _formKey,
        child: NewPasswordField(controller: _password, onSubmitted: _submit, autofocus: true),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: I18nText('basic.cancel')),
        TextButton(onPressed: _submit, child: I18nText('basic.save')),
      ],
    );
  }
}
