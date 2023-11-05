//
//  Generated code. Do not modify.
//  source: rumgap/v1/meta.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'meta.pbenum.dart';

export 'meta.pbenum.dart';

class MetaReply extends $pb.GeneratedMessage {
  factory MetaReply({
    $core.Iterable<$core.String>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  MetaReply._() : super();
  factory MetaReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MetaReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'items')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaReply clone() => MetaReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaReply copyWith(void Function(MetaReply) updates) => super.copyWith((message) => updates(message as MetaReply)) as MetaReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaReply create() => MetaReply._();
  MetaReply createEmptyInstance() => create();
  static $pb.PbList<MetaReply> createRepeated() => $pb.PbList<MetaReply>();
  @$core.pragma('dart2js:noInline')
  static MetaReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MetaReply>(create);
  static MetaReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get items => $_getList(0);
}

class MetaHostnamesRequest extends $pb.GeneratedMessage {
  factory MetaHostnamesRequest({
    MetaHostnamesOption? option,
  }) {
    final $result = create();
    if (option != null) {
      $result.option = option;
    }
    return $result;
  }
  MetaHostnamesRequest._() : super();
  factory MetaHostnamesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaHostnamesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MetaHostnamesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..e<MetaHostnamesOption>(1, _omitFieldNames ? '' : 'option', $pb.PbFieldType.OE, defaultOrMaker: MetaHostnamesOption.HostnamesReading, valueOf: MetaHostnamesOption.valueOf, enumValues: MetaHostnamesOption.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaHostnamesRequest clone() => MetaHostnamesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaHostnamesRequest copyWith(void Function(MetaHostnamesRequest) updates) => super.copyWith((message) => updates(message as MetaHostnamesRequest)) as MetaHostnamesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest create() => MetaHostnamesRequest._();
  MetaHostnamesRequest createEmptyInstance() => create();
  static $pb.PbList<MetaHostnamesRequest> createRepeated() => $pb.PbList<MetaHostnamesRequest>();
  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MetaHostnamesRequest>(create);
  static MetaHostnamesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaHostnamesOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaHostnamesOption v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => clearField(1);
}

class MetaGenresRequest extends $pb.GeneratedMessage {
  factory MetaGenresRequest({
    MetaGenresOption? option,
  }) {
    final $result = create();
    if (option != null) {
      $result.option = option;
    }
    return $result;
  }
  MetaGenresRequest._() : super();
  factory MetaGenresRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaGenresRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MetaGenresRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..e<MetaGenresOption>(1, _omitFieldNames ? '' : 'option', $pb.PbFieldType.OE, defaultOrMaker: MetaGenresOption.GenresReading, valueOf: MetaGenresOption.valueOf, enumValues: MetaGenresOption.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaGenresRequest clone() => MetaGenresRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaGenresRequest copyWith(void Function(MetaGenresRequest) updates) => super.copyWith((message) => updates(message as MetaGenresRequest)) as MetaGenresRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest create() => MetaGenresRequest._();
  MetaGenresRequest createEmptyInstance() => create();
  static $pb.PbList<MetaGenresRequest> createRepeated() => $pb.PbList<MetaGenresRequest>();
  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MetaGenresRequest>(create);
  static MetaGenresRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaGenresOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaGenresOption v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => clearField(1);
}

class StatsReply extends $pb.GeneratedMessage {
  factory StatsReply({
    $fixnum.Int64? countTotalReading,
    $fixnum.Int64? countTotalChapters,
    $fixnum.Int64? countReading,
    $fixnum.Int64? countChapters,
  }) {
    final $result = create();
    if (countTotalReading != null) {
      $result.countTotalReading = countTotalReading;
    }
    if (countTotalChapters != null) {
      $result.countTotalChapters = countTotalChapters;
    }
    if (countReading != null) {
      $result.countReading = countReading;
    }
    if (countChapters != null) {
      $result.countChapters = countChapters;
    }
    return $result;
  }
  StatsReply._() : super();
  factory StatsReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatsReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StatsReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'countTotalReading')
    ..aInt64(2, _omitFieldNames ? '' : 'countTotalChapters')
    ..aInt64(3, _omitFieldNames ? '' : 'countReading')
    ..aInt64(4, _omitFieldNames ? '' : 'countChapters')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StatsReply clone() => StatsReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StatsReply copyWith(void Function(StatsReply) updates) => super.copyWith((message) => updates(message as StatsReply)) as StatsReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsReply create() => StatsReply._();
  StatsReply createEmptyInstance() => create();
  static $pb.PbList<StatsReply> createRepeated() => $pb.PbList<StatsReply>();
  @$core.pragma('dart2js:noInline')
  static StatsReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatsReply>(create);
  static StatsReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get countTotalReading => $_getI64(0);
  @$pb.TagNumber(1)
  set countTotalReading($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountTotalReading() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountTotalReading() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get countTotalChapters => $_getI64(1);
  @$pb.TagNumber(2)
  set countTotalChapters($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountTotalChapters() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountTotalChapters() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get countReading => $_getI64(2);
  @$pb.TagNumber(3)
  set countReading($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountReading() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountReading() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get countChapters => $_getI64(3);
  @$pb.TagNumber(4)
  set countChapters($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCountChapters() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountChapters() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
