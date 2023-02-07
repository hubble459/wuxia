import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

final emailRegex = RegExp(r'^[^\s@]+@([^\s@.,]+\.)+[^\s@.,]{2,}$');
final hostRegex = RegExp(r'^(\d+\.){3}(\d+):\d+$');

typedef Validator = String? Function(String? value);

class ValidatorBuilder {
  final BuildContext context;
  final String name;
  final List<Validator> _validators = [];

  ValidatorBuilder(this.context, this.name);

  factory ValidatorBuilder.translate(BuildContext context, String key) {
    return ValidatorBuilder(context, FlutterI18n.translate(context, key));
  }

  ValidatorBuilder required() {
    return custom(_required);
  }

  ValidatorBuilder isEmail() {
    return required().custom(_isEmail);
  }

  ValidatorBuilder isUrl() {
    return required().custom(_isUrl);
  }

  ValidatorBuilder isHostWithPortUrl() {
    return required().custom(_isHostWithPortUrl);
  }

  ValidatorBuilder isNumber() {
    return required().matches(RegExp(r'^\d+$'), _t('validator.is_number'));
  }

  ValidatorBuilder isString() {
    return required().matches(RegExp(r'\w'), _t('validator.is_string'));
  }

  ValidatorBuilder hasNumber() {
    return required().matches(RegExp(r'\d'), _t('validator.has_number'));
  }

  ValidatorBuilder hasSpecialCharacter() {
    return required().matches(RegExp(r'[^a-zA-Z0-9]'), _t('validator.has_special_character'));
  }

  ValidatorBuilder hasUppercase() {
    return required().matches(RegExp(r'[A-Z]'), _t('validator.has_uppercase'));
  }

  ValidatorBuilder hasLowercase() {
    return required().matches(RegExp(r'[a-z]'), _t('validator.has_lowercase'));
  }

  ValidatorBuilder custom(Validator validator) {
    if (!_validators.contains(validator)) {
      _validators.add(validator);
    }
    return this;
  }

  ValidatorBuilder minLength(int length) {
    return required().custom((String? value) {
      return value!.length >= length
          ? null
          : _t('validator.min_length', {
              'length': length.toString(),
            });
    });
  }

  ValidatorBuilder maxLength(int length) {
    return required().custom((String? value) {
      return value!.length <= length
          ? null
          : _t('validator.max_length', {
              'length': length.toString(),
            });
    });
  }

  ValidatorBuilder matches(RegExp expression, [String? message]) {
    return required().custom((String? value) {
      return expression.hasMatch(value!)
          ? null
          : message ??
              _t('validator.regex', {
                'regex': expression.pattern,
              });
    });
  }

  String? _required(String? value) {
    return value != null && value.trim().isNotEmpty ? null : _t('validator.required');
  }

  String? _isEmail(String? value) {
    return emailRegex.hasMatch(value!) ? null : _t('validator.email');
  }

  String? _isUrl(String? value) {
    final url = Uri.tryParse(value!);
    return url != null && url.hasScheme && !url.hasEmptyPath ? null : _t('validator.url');
  }

  String? _isHostWithPortUrl(String? value) {
    final url = Uri.tryParse(value!);
    if (url == null) {
      return hostRegex.hasMatch(value) ? null : _t('validator.url');
    }
    return url.hasPort && !url.hasAbsolutePath && !url.hasScheme ? null : _t('validator.url');
  }

  String _t(String key, [Map<String, String>? params]) {
    final p = params ?? {};
    p['name'] ??= name;
    return FlutterI18n.translate(context, key, translationParams: p);
  }

  Validator build() {
    return (String? value) {
      for (final validator in _validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
