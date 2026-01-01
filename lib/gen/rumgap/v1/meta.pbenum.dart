// This is a generated file - do not edit.
//
// Generated from rumgap/v1/meta.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MetaHostnamesOption extends $pb.ProtobufEnum {
  static const MetaHostnamesOption HostnamesReading =
      MetaHostnamesOption._(0, _omitEnumNames ? '' : 'HostnamesReading');
  static const MetaHostnamesOption HostnamesManga =
      MetaHostnamesOption._(1, _omitEnumNames ? '' : 'HostnamesManga');
  static const MetaHostnamesOption HostnamesOnline =
      MetaHostnamesOption._(2, _omitEnumNames ? '' : 'HostnamesOnline');

  static const $core.List<MetaHostnamesOption> values = <MetaHostnamesOption>[
    HostnamesReading,
    HostnamesManga,
    HostnamesOnline,
  ];

  static final $core.List<MetaHostnamesOption?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static MetaHostnamesOption? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MetaHostnamesOption._(super.value, super.name);
}

class MetaGenresOption extends $pb.ProtobufEnum {
  static const MetaGenresOption GenresReading =
      MetaGenresOption._(0, _omitEnumNames ? '' : 'GenresReading');
  static const MetaGenresOption GenresManga =
      MetaGenresOption._(1, _omitEnumNames ? '' : 'GenresManga');

  static const $core.List<MetaGenresOption> values = <MetaGenresOption>[
    GenresReading,
    GenresManga,
  ];

  static final $core.List<MetaGenresOption?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static MetaGenresOption? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MetaGenresOption._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
