import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:grpc/grpc.dart' show GrpcError;
import 'package:wuxia/api.dart';
import 'package:wuxia/constant.dart';
import 'package:wuxia/gen/rumgap/v1/user.pb.dart';
import 'package:wuxia/partial/new_password_field.dart';
import 'package:wuxia/util/validator_builder.dart';

/// Changes the logged in user's password; pops `true` once saved
class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving || !_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      API.loggedIn = await api.user.update(UserUpdateRequest(currentPassword: _current.text, password: _new.text));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _saving = false;
        _error = e is GrpcError ? (e.message ?? e.codeName) : '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: I18nText('settings.change_password.title'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: Constants.padding),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            TextFormField(
              controller: _current,
              autofocus: true,
              obscureText: true,
              textInputAction: TextInputAction.next,
              validator: ValidatorBuilder.translate(context, 'settings.change_password.current').required().build(),
              decoration: InputDecoration(label: I18nText('settings.change_password.current')),
            ),
            const SizedBox(height: Constants.padding),
            NewPasswordField(controller: _new, labelKey: 'settings.change_password.new', textInputAction: TextInputAction.next),
            const SizedBox(height: Constants.padding),
            TextFormField(
              obscureText: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: ValidatorBuilder.translate(context, 'login.confirm_password')
                  .required()
                  .custom((value) => value == _new.text ? null : FlutterI18n.translate(context, 'validator.password_not_match'))
                  .build(),
              decoration: InputDecoration(label: I18nText('login.confirm_password')),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _saving ? null : () => Navigator.of(context).pop(), child: I18nText('basic.cancel')),
        TextButton(onPressed: _saving ? null : _submit, child: I18nText('basic.save')),
      ],
    );
  }
}
