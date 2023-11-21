import 'package:flutter/material.dart';

final tagRegex = RegExp(r'\w+');

class FilterOptions {
  final List<String> included;
  final List<String> excluded;

  FilterOptions({List<String>? included, List<String>? excluded})
      : included = included ?? [],
        excluded = included ?? [];

  String intoString(String type) {
    String str = '';
    if (included.isNotEmpty) {
      str += included.map((e) => '$type:"${e.replaceAll('"', '')}"').join(' ');
    }
    if (excluded.isNotEmpty) {
      str += excluded.map((e) => ' -$type:"${e.replaceAll('"', '')}"').join(' ');
    }

    return str.trim();
  }
}

class _Field {
  final bool exclude;
  final bool exact;
  final String value;
  final String? name;

  const _Field({
    required this.name,
    required this.value,
    required this.exact,
    required this.exclude,
  });

  @override
  String toString() {
    String self = exclude ? '-' : '';
    if (name != null) {
      self += '${name!}:';
    }
    self += '"$value"';
    return self;
  }
}

class FilterMap {
  final FilterOptions genres = FilterOptions();
  final FilterOptions hosts = FilterOptions();
  String? global;
  String? title;
  String? description;

  @override
  String toString() {
    String sb = '';
    sb += genres.intoString('genre');
    sb += ' ' + hosts.intoString('host');

    if (title?.isNotEmpty == true) {
      sb += ' ';
      sb += title!.split(' ').expand((keyword) => keyword.isEmpty ? [] : ['title:"$keyword"']).join(' ');
    }
    if (description?.isNotEmpty == true) {
      sb += ' ';
      sb += description!.split(' ').expand((keyword) => keyword.isEmpty ? [] : ['description:"$keyword"']).join(' ');
    }
    if (global?.isNotEmpty == true) {
      sb += ' ' + global!;
    }
    sb = sb.trim();
    return sb;
  }

  FilterMap();

  factory FilterMap.fromString(String defaultValue) {
    final map = FilterMap();

    bool inside = false;

    String? name;
    String value = '';
    bool exclude = false;
    bool exact = false;

    List<_Field> fields = [];

    for (final char in defaultValue.characters) {
      if (char == ' ') {
        if (!inside) {
          if (value.isNotEmpty) {
            fields.add(_Field(
              exclude: exclude,
              name: name,
              value: value,
              exact: exact,
            ));
          }

          name = null;
          value = '';
          exclude = false;
          exact = false;
        } else {
          value += ' ';
        }
      } else if (char == ':') {
        if (!inside) {
          name = value;
          value = '';
        }
      } else if (char == '-') {
        if (!inside && value.isEmpty) {
          exclude = true;
        } else {
          value += '-';
        }
      } else if (char == '"') {
        inside = !inside;
        if (inside) {
          exact = true;
        }
      } else {
        value += char;
      }
    }

    if (value.isNotEmpty) {
      fields.add(_Field(
        exclude: exclude,
        name: name,
        value: value,
        exact: exact,
      ));
    }

    for (final field in fields) {
      if (field.name == null) {
        map.global = '${map.global ?? ''} ${field.value}';
      } else if (field.name?.toLowerCase() == 'title') {
        map.title = '${map.title ?? ''} ${field.value}';
      } else if (field.name?.toLowerCase().startsWith('desc') == true) {
        map.description = '${map.description ?? ''} ${field.value}';
      } else if (field.name?.toLowerCase().startsWith('genre') == true) {
        if (field.exclude) {
          map.genres.excluded.add(field.value);
        } else {
          map.genres.included.add(field.value);
        }
      } else if (field.name?.toLowerCase().startsWith('host') == true) {
        if (field.exclude) {
          map.hosts.excluded.add(field.value);
        } else {
          map.hosts.included.add(field.value);
        }
      }
    }

    return map;
  }
}
