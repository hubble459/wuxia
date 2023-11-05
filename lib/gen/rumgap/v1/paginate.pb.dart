//
//  Generated code. Do not modify.
//  source: rumgap/v1/paginate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class PaginateQuery extends $pb.GeneratedMessage {
  factory PaginateQuery({
    $fixnum.Int64? perPage,
    $fixnum.Int64? page,
  }) {
    final $result = create();
    if (perPage != null) {
      $result.perPage = perPage;
    }
    if (page != null) {
      $result.page = page;
    }
    return $result;
  }
  PaginateQuery._() : super();
  factory PaginateQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginateQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginateQuery', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginateQuery clone() => PaginateQuery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginateQuery copyWith(void Function(PaginateQuery) updates) => super.copyWith((message) => updates(message as PaginateQuery)) as PaginateQuery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateQuery create() => PaginateQuery._();
  PaginateQuery createEmptyInstance() => create();
  static $pb.PbList<PaginateQuery> createRepeated() => $pb.PbList<PaginateQuery>();
  @$core.pragma('dart2js:noInline')
  static PaginateQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginateQuery>(create);
  static PaginateQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get perPage => $_getI64(0);
  @$pb.TagNumber(1)
  set perPage($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPerPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPerPage() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
}

class PaginateSearchQuery extends $pb.GeneratedMessage {
  factory PaginateSearchQuery({
    $fixnum.Int64? perPage,
    $fixnum.Int64? page,
    $core.String? search,
    $core.String? order,
  }) {
    final $result = create();
    if (perPage != null) {
      $result.perPage = perPage;
    }
    if (page != null) {
      $result.page = page;
    }
    if (search != null) {
      $result.search = search;
    }
    if (order != null) {
      $result.order = order;
    }
    return $result;
  }
  PaginateSearchQuery._() : super();
  factory PaginateSearchQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginateSearchQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginateSearchQuery', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..aOS(4, _omitFieldNames ? '' : 'order')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginateSearchQuery clone() => PaginateSearchQuery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginateSearchQuery copyWith(void Function(PaginateSearchQuery) updates) => super.copyWith((message) => updates(message as PaginateSearchQuery)) as PaginateSearchQuery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateSearchQuery create() => PaginateSearchQuery._();
  PaginateSearchQuery createEmptyInstance() => create();
  static $pb.PbList<PaginateSearchQuery> createRepeated() => $pb.PbList<PaginateSearchQuery>();
  @$core.pragma('dart2js:noInline')
  static PaginateSearchQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginateSearchQuery>(create);
  static PaginateSearchQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get perPage => $_getI64(0);
  @$pb.TagNumber(1)
  set perPage($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPerPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPerPage() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get order => $_getSZ(3);
  @$pb.TagNumber(4)
  set order($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrder() => clearField(4);
}

class PaginateReply extends $pb.GeneratedMessage {
  factory PaginateReply({
    $fixnum.Int64? total,
    $fixnum.Int64? page,
    $fixnum.Int64? perPage,
    $fixnum.Int64? maxPage,
  }) {
    final $result = create();
    if (total != null) {
      $result.total = total;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    if (maxPage != null) {
      $result.maxPage = maxPage;
    }
    return $result;
  }
  PaginateReply._() : super();
  factory PaginateReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginateReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginateReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'maxPage', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginateReply clone() => PaginateReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginateReply copyWith(void Function(PaginateReply) updates) => super.copyWith((message) => updates(message as PaginateReply)) as PaginateReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateReply create() => PaginateReply._();
  PaginateReply createEmptyInstance() => create();
  static $pb.PbList<PaginateReply> createRepeated() => $pb.PbList<PaginateReply>();
  @$core.pragma('dart2js:noInline')
  static PaginateReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginateReply>(create);
  static PaginateReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get total => $_getI64(0);
  @$pb.TagNumber(1)
  set total($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get perPage => $_getI64(2);
  @$pb.TagNumber(3)
  set perPage($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get maxPage => $_getI64(3);
  @$pb.TagNumber(4)
  set maxPage($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxPage() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
