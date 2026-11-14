// This is a generated file - do not edit.
//
// Generated from rumgap/v1/manga.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Where a manga comes from. Prefixed, since enum values share the package's namespace.
class MangaOrigin extends $pb.ProtobufEnum {
  static const MangaOrigin ORIGIN_UNKNOWN =
      MangaOrigin._(0, _omitEnumNames ? '' : 'ORIGIN_UNKNOWN');
  static const MangaOrigin ORIGIN_MANGA =
      MangaOrigin._(1, _omitEnumNames ? '' : 'ORIGIN_MANGA');
  static const MangaOrigin ORIGIN_MANHWA =
      MangaOrigin._(2, _omitEnumNames ? '' : 'ORIGIN_MANHWA');
  static const MangaOrigin ORIGIN_MANHUA =
      MangaOrigin._(3, _omitEnumNames ? '' : 'ORIGIN_MANHUA');

  static const $core.List<MangaOrigin> values = <MangaOrigin>[
    ORIGIN_UNKNOWN,
    ORIGIN_MANGA,
    ORIGIN_MANHWA,
    ORIGIN_MANHUA,
  ];

  static final $core.List<MangaOrigin?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static MangaOrigin? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MangaOrigin._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
