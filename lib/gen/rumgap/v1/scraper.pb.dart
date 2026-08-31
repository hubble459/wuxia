// This is a generated file - do not edit.
//
// Generated from rumgap/v1/scraper.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'scrape_error.pbenum.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ScraperStatusRequest extends $pb.GeneratedMessage {
  factory ScraperStatusRequest() => create();

  ScraperStatusRequest._();

  factory ScraperStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScraperStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScraperStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatusRequest copyWith(void Function(ScraperStatusRequest) updates) =>
      super.copyWith((message) => updates(message as ScraperStatusRequest))
          as ScraperStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScraperStatusRequest create() => ScraperStatusRequest._();
  @$core.override
  ScraperStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScraperStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScraperStatusRequest>(create);
  static ScraperStatusRequest? _defaultInstance;
}

/// One recent failed attempt for a given hostname.
class ScraperErrorEntry extends $pb.GeneratedMessage {
  factory ScraperErrorEntry({
    $core.String? operation,
    $core.String? url,
    $0.ScrapeErrorType? errorType,
    $core.String? message,
    $fixnum.Int64? createdAt,
  }) {
    final result = create();
    if (operation != null) result.operation = operation;
    if (url != null) result.url = url;
    if (errorType != null) result.errorType = errorType;
    if (message != null) result.message = message;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  ScraperErrorEntry._();

  factory ScraperErrorEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScraperErrorEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScraperErrorEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'operation')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aE<$0.ScrapeErrorType>(3, _omitFieldNames ? '' : 'errorType',
        enumValues: $0.ScrapeErrorType.values)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aInt64(5, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperErrorEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperErrorEntry copyWith(void Function(ScraperErrorEntry) updates) =>
      super.copyWith((message) => updates(message as ScraperErrorEntry))
          as ScraperErrorEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScraperErrorEntry create() => ScraperErrorEntry._();
  @$core.override
  ScraperErrorEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScraperErrorEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScraperErrorEntry>(create);
  static ScraperErrorEntry? _defaultInstance;

  /// `manga | chapter_images` -- which manga_parser call failed.
  @$pb.TagNumber(1)
  $core.String get operation => $_getSZ(0);
  @$pb.TagNumber(1)
  set operation($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOperation() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperation() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.ScrapeErrorType get errorType => $_getN(2);
  @$pb.TagNumber(3)
  set errorType($0.ScrapeErrorType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorType() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get createdAt => $_getI64(4);
  @$pb.TagNumber(5)
  set createdAt($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
}

class ScraperStatus extends $pb.GeneratedMessage {
  factory ScraperStatus({
    $core.String? hostname,
    $fixnum.Int64? lastAttemptAt,
    $core.bool? lastAttemptSuccess,
    $fixnum.Int64? lastSuccessAt,
    $fixnum.Int64? attempts24h,
    $fixnum.Int64? failures24h,
    $core.Iterable<ScraperErrorEntry>? recentErrors,
  }) {
    final result = create();
    if (hostname != null) result.hostname = hostname;
    if (lastAttemptAt != null) result.lastAttemptAt = lastAttemptAt;
    if (lastAttemptSuccess != null)
      result.lastAttemptSuccess = lastAttemptSuccess;
    if (lastSuccessAt != null) result.lastSuccessAt = lastSuccessAt;
    if (attempts24h != null) result.attempts24h = attempts24h;
    if (failures24h != null) result.failures24h = failures24h;
    if (recentErrors != null) result.recentErrors.addAll(recentErrors);
    return result;
  }

  ScraperStatus._();

  factory ScraperStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScraperStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScraperStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hostname')
    ..aInt64(2, _omitFieldNames ? '' : 'lastAttemptAt')
    ..aOB(3, _omitFieldNames ? '' : 'lastAttemptSuccess')
    ..aInt64(4, _omitFieldNames ? '' : 'lastSuccessAt')
    ..aInt64(5, _omitFieldNames ? '' : 'attempts24h', protoName: 'attempts_24h')
    ..aInt64(6, _omitFieldNames ? '' : 'failures24h', protoName: 'failures_24h')
    ..pPM<ScraperErrorEntry>(7, _omitFieldNames ? '' : 'recentErrors',
        subBuilder: ScraperErrorEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatus copyWith(void Function(ScraperStatus) updates) =>
      super.copyWith((message) => updates(message as ScraperStatus))
          as ScraperStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScraperStatus create() => ScraperStatus._();
  @$core.override
  ScraperStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScraperStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScraperStatus>(create);
  static ScraperStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hostname => $_getSZ(0);
  @$pb.TagNumber(1)
  set hostname($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHostname() => $_has(0);
  @$pb.TagNumber(1)
  void clearHostname() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lastAttemptAt => $_getI64(1);
  @$pb.TagNumber(2)
  set lastAttemptAt($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastAttemptAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastAttemptAt() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get lastAttemptSuccess => $_getBF(2);
  @$pb.TagNumber(3)
  set lastAttemptSuccess($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastAttemptSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastAttemptSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get lastSuccessAt => $_getI64(3);
  @$pb.TagNumber(4)
  set lastSuccessAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastSuccessAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastSuccessAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get attempts24h => $_getI64(4);
  @$pb.TagNumber(5)
  set attempts24h($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAttempts24h() => $_has(4);
  @$pb.TagNumber(5)
  void clearAttempts24h() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get failures24h => $_getI64(5);
  @$pb.TagNumber(6)
  set failures24h($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFailures24h() => $_has(5);
  @$pb.TagNumber(6)
  void clearFailures24h() => $_clearField(6);

  /// Up to the 5 most recent failed attempts for this hostname, newest first.
  @$pb.TagNumber(7)
  $pb.PbList<ScraperErrorEntry> get recentErrors => $_getList(6);
}

class ScraperStatusReply extends $pb.GeneratedMessage {
  factory ScraperStatusReply({
    $core.Iterable<ScraperStatus>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ScraperStatusReply._();

  factory ScraperStatusReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScraperStatusReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScraperStatusReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPM<ScraperStatus>(1, _omitFieldNames ? '' : 'items',
        subBuilder: ScraperStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatusReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScraperStatusReply copyWith(void Function(ScraperStatusReply) updates) =>
      super.copyWith((message) => updates(message as ScraperStatusReply))
          as ScraperStatusReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScraperStatusReply create() => ScraperStatusReply._();
  @$core.override
  ScraperStatusReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScraperStatusReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScraperStatusReply>(create);
  static ScraperStatusReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ScraperStatus> get items => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
