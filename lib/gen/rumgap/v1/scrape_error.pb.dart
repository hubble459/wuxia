// This is a generated file - do not edit.
//
// Generated from rumgap/v1/scrape_error.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'scrape_error.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'scrape_error.pbenum.dart';

class ScrapeError extends $pb.GeneratedMessage {
  factory ScrapeError({
    ScrapeErrorType? type,
    $core.String? message,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (message != null) result.message = message;
    return result;
  }

  ScrapeError._();

  factory ScrapeError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScrapeError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScrapeError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<ScrapeErrorType>(1, _omitFieldNames ? '' : 'type',
        enumValues: ScrapeErrorType.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScrapeError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScrapeError copyWith(void Function(ScrapeError) updates) =>
      super.copyWith((message) => updates(message as ScrapeError))
          as ScrapeError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScrapeError create() => ScrapeError._();
  @$core.override
  ScrapeError createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScrapeError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScrapeError>(create);
  static ScrapeError? _defaultInstance;

  @$pb.TagNumber(1)
  ScrapeErrorType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ScrapeErrorType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
