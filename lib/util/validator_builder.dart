import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

final emailRegex = RegExp(r'^[^\s@]+@([^\s@.,]+\.)+[^\s@.,]{2,}$');

/// Parses either a bare `host:port` (IP or hostname, no scheme -- e.g.
/// `192.168.1.54:8000` or `localhost:8000`) or a full `scheme://host[:port]`
/// URL (e.g. `https://api.manga.quentincorreia.nl`, port defaulted from the
/// scheme). A bare hostname:port parses via [Uri.tryParse] as a bogus
/// `scheme:opaque-path` URI (empty host), which is why that case is
/// distinguished by checking `uri.host.isNotEmpty` rather than by whether
/// parsing itself succeeded.
({String host, int port})? parseHostAndPort(String value) {
  final uri = Uri.tryParse(value);
  if (uri != null && uri.host.isNotEmpty) {
    return (host: uri.host, port: uri.port);
  }

  final parts = value.split(':');
  if (parts.length != 2 || parts[0].isEmpty) return null;
  final port = int.tryParse(parts[1]);
  if (port == null) return null;
  return (host: parts[0], port: port);
}

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
    return parseHostAndPort(value!) != null ? null : _t('validator.url');
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
