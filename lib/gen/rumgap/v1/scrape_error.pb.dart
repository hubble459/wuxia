//
//  Generated code. Do not modify.
//  source: rumgap/v1/scrape_error.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'scrape_error.pbenum.dart';

export 'scrape_error.pbenum.dart';

class ScrapeError extends $pb.GeneratedMessage {
  factory ScrapeError({
    ScrapeErrorType? type,
    $core.String? message,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ScrapeError._() : super();
  factory ScrapeError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ScrapeError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ScrapeError', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..e<ScrapeErrorType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ScrapeErrorType.Unknown, valueOf: ScrapeErrorType.valueOf, enumValues: ScrapeErrorType.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ScrapeError clone() => ScrapeError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ScrapeError copyWith(void Function(ScrapeError) updates) => super.copyWith((message) => updates(message as ScrapeError)) as ScrapeError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScrapeError create() => ScrapeError._();
  ScrapeError createEmptyInstance() => create();
  static $pb.PbList<ScrapeError> createRepeated() => $pb.PbList<ScrapeError>();
  @$core.pragma('dart2js:noInline')
  static ScrapeError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScrapeError>(create);
  static ScrapeError? _defaultInstance;

  @$pb.TagNumber(1)
  ScrapeErrorType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ScrapeErrorType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
