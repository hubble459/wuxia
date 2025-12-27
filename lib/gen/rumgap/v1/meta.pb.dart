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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'meta.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'meta.pbenum.dart';

class MetaReply extends $pb.GeneratedMessage {
  factory MetaReply({
    $core.Iterable<$core.String>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  MetaReply._();

  factory MetaReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'items')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaReply copyWith(void Function(MetaReply) updates) =>
      super.copyWith((message) => updates(message as MetaReply)) as MetaReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaReply create() => MetaReply._();
  @$core.override
  MetaReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MetaReply>(create);
  static MetaReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get items => $_getList(0);
}

class MetaHostnamesRequest extends $pb.GeneratedMessage {
  factory MetaHostnamesRequest({
    MetaHostnamesOption? option,
  }) {
    final result = create();
    if (option != null) result.option = option;
    return result;
  }

  MetaHostnamesRequest._();

  factory MetaHostnamesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaHostnamesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaHostnamesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<MetaHostnamesOption>(1, _omitFieldNames ? '' : 'option',
        enumValues: MetaHostnamesOption.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaHostnamesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaHostnamesRequest copyWith(void Function(MetaHostnamesRequest) updates) =>
      super.copyWith((message) => updates(message as MetaHostnamesRequest))
          as MetaHostnamesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest create() => MetaHostnamesRequest._();
  @$core.override
  MetaHostnamesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetaHostnamesRequest>(create);
  static MetaHostnamesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaHostnamesOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaHostnamesOption value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => $_clearField(1);
}

class MetaGenresRequest extends $pb.GeneratedMessage {
  factory MetaGenresRequest({
    MetaGenresOption? option,
  }) {
    final result = create();
    if (option != null) result.option = option;
    return result;
  }

  MetaGenresRequest._();

  factory MetaGenresRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaGenresRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaGenresRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<MetaGenresOption>(1, _omitFieldNames ? '' : 'option',
        enumValues: MetaGenresOption.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaGenresRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaGenresRequest copyWith(void Function(MetaGenresRequest) updates) =>
      super.copyWith((message) => updates(message as MetaGenresRequest))
          as MetaGenresRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest create() => MetaGenresRequest._();
  @$core.override
  MetaGenresRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetaGenresRequest>(create);
  static MetaGenresRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaGenresOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaGenresOption value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => $_clearField(1);
}

class StatsReply extends $pb.GeneratedMessage {
  factory StatsReply({
    $fixnum.Int64? countTotalReading,
    $fixnum.Int64? countTotalChapters,
    $fixnum.Int64? countReading,
    $fixnum.Int64? countChapters,
  }) {
    final result = create();
    if (countTotalReading != null) result.countTotalReading = countTotalReading;
    if (countTotalChapters != null)
      result.countTotalChapters = countTotalChapters;
    if (countReading != null) result.countReading = countReading;
    if (countChapters != null) result.countChapters = countChapters;
    return result;
  }

  StatsReply._();

  factory StatsReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'countTotalReading')
    ..aInt64(2, _omitFieldNames ? '' : 'countTotalChapters')
    ..aInt64(3, _omitFieldNames ? '' : 'countReading')
    ..aInt64(4, _omitFieldNames ? '' : 'countChapters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsReply copyWith(void Function(StatsReply) updates) =>
      super.copyWith((message) => updates(message as StatsReply)) as StatsReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsReply create() => StatsReply._();
  @$core.override
  StatsReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatsReply>(create);
  static StatsReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get countTotalReading => $_getI64(0);
  @$pb.TagNumber(1)
  set countTotalReading($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountTotalReading() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountTotalReading() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get countTotalChapters => $_getI64(1);
  @$pb.TagNumber(2)
  set countTotalChapters($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountTotalChapters() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountTotalChapters() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get countReading => $_getI64(2);
  @$pb.TagNumber(3)
  set countReading($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountReading() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountReading() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get countChapters => $_getI64(3);
  @$pb.TagNumber(4)
  set countChapters($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountChapters() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountChapters() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
