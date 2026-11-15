// This is a generated file - do not edit.
//
// Generated from rumgap/v1/anilist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AnilistReturnTarget extends $pb.ProtobufEnum {
  /// Ends on a page saying the account is connected, for the apps.
  static const AnilistReturnTarget ANILIST_RETURN_APP =
      AnilistReturnTarget._(0, _omitEnumNames ? '' : 'ANILIST_RETURN_APP');

  /// Redirects back to the web app's settings.
  static const AnilistReturnTarget ANILIST_RETURN_WEB =
      AnilistReturnTarget._(1, _omitEnumNames ? '' : 'ANILIST_RETURN_WEB');

  static const $core.List<AnilistReturnTarget> values = <AnilistReturnTarget>[
    ANILIST_RETURN_APP,
    ANILIST_RETURN_WEB,
  ];

  static final $core.List<AnilistReturnTarget?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static AnilistReturnTarget? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AnilistReturnTarget._(super.value, super.name);
}

/// The statuses of an AniList list entry. NONE: not on the list.
class AnilistListStatus extends $pb.ProtobufEnum {
  static const AnilistListStatus ANILIST_LIST_NONE =
      AnilistListStatus._(0, _omitEnumNames ? '' : 'ANILIST_LIST_NONE');
  static const AnilistListStatus ANILIST_LIST_CURRENT =
      AnilistListStatus._(1, _omitEnumNames ? '' : 'ANILIST_LIST_CURRENT');
  static const AnilistListStatus ANILIST_LIST_PLANNING =
      AnilistListStatus._(2, _omitEnumNames ? '' : 'ANILIST_LIST_PLANNING');
  static const AnilistListStatus ANILIST_LIST_COMPLETED =
      AnilistListStatus._(3, _omitEnumNames ? '' : 'ANILIST_LIST_COMPLETED');
  static const AnilistListStatus ANILIST_LIST_DROPPED =
      AnilistListStatus._(4, _omitEnumNames ? '' : 'ANILIST_LIST_DROPPED');
  static const AnilistListStatus ANILIST_LIST_PAUSED =
      AnilistListStatus._(5, _omitEnumNames ? '' : 'ANILIST_LIST_PAUSED');
  static const AnilistListStatus ANILIST_LIST_REPEATING =
      AnilistListStatus._(6, _omitEnumNames ? '' : 'ANILIST_LIST_REPEATING');

  static const $core.List<AnilistListStatus> values = <AnilistListStatus>[
    ANILIST_LIST_NONE,
    ANILIST_LIST_CURRENT,
    ANILIST_LIST_PLANNING,
    ANILIST_LIST_COMPLETED,
    ANILIST_LIST_DROPPED,
    ANILIST_LIST_PAUSED,
    ANILIST_LIST_REPEATING,
  ];

  static final $core.List<AnilistListStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static AnilistListStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AnilistListStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
