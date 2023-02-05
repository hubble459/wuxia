///
//  Generated code. Do not modify.
//  source: meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'meta.pbenum.dart';

export 'meta.pbenum.dart';

class MetaReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MetaReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items')
    ..hasRequiredFields = false
  ;

  MetaReply._() : super();
  factory MetaReply({
    $core.Iterable<$core.String>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory MetaReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaReply clone() => MetaReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaReply copyWith(void Function(MetaReply) updates) => super.copyWith((message) => updates(message as MetaReply)) as MetaReply; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MetaHostnamesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..e<MetaHostnamesOption>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'option', $pb.PbFieldType.OE, defaultOrMaker: MetaHostnamesOption.HostnamesReading, valueOf: MetaHostnamesOption.valueOf, enumValues: MetaHostnamesOption.values)
    ..hasRequiredFields = false
  ;

  MetaHostnamesRequest._() : super();
  factory MetaHostnamesRequest({
    MetaHostnamesOption? option,
  }) {
    final _result = create();
    if (option != null) {
      _result.option = option;
    }
    return _result;
  }
  factory MetaHostnamesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaHostnamesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaHostnamesRequest clone() => MetaHostnamesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaHostnamesRequest copyWith(void Function(MetaHostnamesRequest) updates) => super.copyWith((message) => updates(message as MetaHostnamesRequest)) as MetaHostnamesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MetaGenresRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..e<MetaGenresOption>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'option', $pb.PbFieldType.OE, defaultOrMaker: MetaGenresOption.GenresReading, valueOf: MetaGenresOption.valueOf, enumValues: MetaGenresOption.values)
    ..hasRequiredFields = false
  ;

  MetaGenresRequest._() : super();
  factory MetaGenresRequest({
    MetaGenresOption? option,
  }) {
    final _result = create();
    if (option != null) {
      _result.option = option;
    }
    return _result;
  }
  factory MetaGenresRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MetaGenresRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MetaGenresRequest clone() => MetaGenresRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MetaGenresRequest copyWith(void Function(MetaGenresRequest) updates) => super.copyWith((message) => updates(message as MetaGenresRequest)) as MetaGenresRequest; // ignore: deprecated_member_use
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

