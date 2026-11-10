import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wuxia/util/validator_builder.dart';

/// Password input that mirrors the server's password rules (rumgap util/verify.rs)
class NewPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelKey;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final bool autofocus;

  const NewPasswordField({
    super.key,
    required this.controller,
    this.labelKey = 'login.password',
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: true,
      textInputAction: textInputAction,
      onFieldSubmitted: (_) => onSubmitted?.call(),
      validator: ValidatorBuilder.translate(
        context,
        labelKey,
      ).required().minLength(8).maxLength(255).hasNumber().hasSpecialCharacter().hasUppercase().build(),
      decoration: InputDecoration(label: I18nText(labelKey)),
    );
  }
}
