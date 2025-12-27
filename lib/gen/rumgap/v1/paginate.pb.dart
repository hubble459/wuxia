// This is a generated file - do not edit.
//
// Generated from rumgap/v1/paginate.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PaginateQuery extends $pb.GeneratedMessage {
  factory PaginateQuery({
    $fixnum.Int64? perPage,
    $fixnum.Int64? page,
  }) {
    final result = create();
    if (perPage != null) result.perPage = perPage;
    if (page != null) result.page = page;
    return result;
  }

  PaginateQuery._();

  factory PaginateQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginateQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginateQuery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateQuery copyWith(void Function(PaginateQuery) updates) =>
      super.copyWith((message) => updates(message as PaginateQuery))
          as PaginateQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateQuery create() => PaginateQuery._();
  @$core.override
  PaginateQuery createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaginateQuery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginateQuery>(create);
  static PaginateQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get perPage => $_getI64(0);
  @$pb.TagNumber(1)
  set perPage($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPerPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPerPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);
}

class PaginateSearchQuery extends $pb.GeneratedMessage {
  factory PaginateSearchQuery({
    $fixnum.Int64? perPage,
    $fixnum.Int64? page,
    $core.String? search,
    $core.String? order,
  }) {
    final result = create();
    if (perPage != null) result.perPage = perPage;
    if (page != null) result.page = page;
    if (search != null) result.search = search;
    if (order != null) result.order = order;
    return result;
  }

  PaginateSearchQuery._();

  factory PaginateSearchQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginateSearchQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginateSearchQuery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..aOS(4, _omitFieldNames ? '' : 'order')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateSearchQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateSearchQuery copyWith(void Function(PaginateSearchQuery) updates) =>
      super.copyWith((message) => updates(message as PaginateSearchQuery))
          as PaginateSearchQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateSearchQuery create() => PaginateSearchQuery._();
  @$core.override
  PaginateSearchQuery createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaginateSearchQuery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginateSearchQuery>(create);
  static PaginateSearchQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get perPage => $_getI64(0);
  @$pb.TagNumber(1)
  set perPage($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPerPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPerPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get order => $_getSZ(3);
  @$pb.TagNumber(4)
  set order($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrder() => $_clearField(4);
}

class PaginateReply extends $pb.GeneratedMessage {
  factory PaginateReply({
    $fixnum.Int64? total,
    $fixnum.Int64? page,
    $fixnum.Int64? perPage,
    $fixnum.Int64? maxPage,
  }) {
    final result = create();
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    if (maxPage != null) result.maxPage = maxPage;
    return result;
  }

  PaginateReply._();

  factory PaginateReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginateReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginateReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'maxPage', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateReply copyWith(void Function(PaginateReply) updates) =>
      super.copyWith((message) => updates(message as PaginateReply))
          as PaginateReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateReply create() => PaginateReply._();
  @$core.override
  PaginateReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaginateReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginateReply>(create);
  static PaginateReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get total => $_getI64(0);
  @$pb.TagNumber(1)
  set total($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotal() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get page => $_getI64(1);
  @$pb.TagNumber(2)
  set page($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get perPage => $_getI64(2);
  @$pb.TagNumber(3)
  set perPage($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get maxPage => $_getI64(3);
  @$pb.TagNumber(4)
  set maxPage($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxPage() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
