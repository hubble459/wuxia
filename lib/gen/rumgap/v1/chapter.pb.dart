// This is a generated file - do not edit.
//
// Generated from rumgap/v1/chapter.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'paginate.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ChapterRequest extends $pb.GeneratedMessage {
  factory ChapterRequest({
    $core.int? mangaId,
    $core.int? index,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (index != null) result.index = index;
    return result;
  }

  ChapterRequest._();

  factory ChapterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChapterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChapterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aI(2, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterRequest copyWith(void Function(ChapterRequest) updates) =>
      super.copyWith((message) => updates(message as ChapterRequest))
          as ChapterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterRequest create() => ChapterRequest._();
  @$core.override
  ChapterRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChapterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChapterRequest>(create);
  static ChapterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => $_clearField(2);
}

class ChapterOffset extends $pb.GeneratedMessage {
  factory ChapterOffset({
    $core.int? pixels,
    $core.int? page,
  }) {
    final result = create();
    if (pixels != null) result.pixels = pixels;
    if (page != null) result.page = page;
    return result;
  }

  ChapterOffset._();

  factory ChapterOffset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChapterOffset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChapterOffset',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pixels')
    ..aI(2, _omitFieldNames ? '' : 'page')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterOffset clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterOffset copyWith(void Function(ChapterOffset) updates) =>
      super.copyWith((message) => updates(message as ChapterOffset))
          as ChapterOffset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterOffset create() => ChapterOffset._();
  @$core.override
  ChapterOffset createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChapterOffset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChapterOffset>(create);
  static ChapterOffset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pixels => $_getIZ(0);
  @$pb.TagNumber(1)
  set pixels($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPixels() => $_has(0);
  @$pb.TagNumber(1)
  void clearPixels() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);
}

class ChapterReply extends $pb.GeneratedMessage {
  factory ChapterReply({
    $core.int? id,
    $core.int? mangaId,
    $core.String? url,
    $core.String? title,
    $core.double? number,
    $fixnum.Int64? index,
    $fixnum.Int64? posted,
    ChapterOffset? offset,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (mangaId != null) result.mangaId = mangaId;
    if (url != null) result.url = url;
    if (title != null) result.title = title;
    if (number != null) result.number = number;
    if (index != null) result.index = index;
    if (posted != null) result.posted = posted;
    if (offset != null) result.offset = offset;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  ChapterReply._();

  factory ChapterReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChapterReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChapterReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'mangaId')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aD(5, _omitFieldNames ? '' : 'number', fieldType: $pb.PbFieldType.OF)
    ..aInt64(6, _omitFieldNames ? '' : 'index')
    ..aInt64(7, _omitFieldNames ? '' : 'posted')
    ..aOM<ChapterOffset>(8, _omitFieldNames ? '' : 'offset',
        subBuilder: ChapterOffset.create)
    ..aInt64(9, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChapterReply copyWith(void Function(ChapterReply) updates) =>
      super.copyWith((message) => updates(message as ChapterReply))
          as ChapterReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterReply create() => ChapterReply._();
  @$core.override
  ChapterReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChapterReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChapterReply>(create);
  static ChapterReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get mangaId => $_getIZ(1);
  @$pb.TagNumber(2)
  set mangaId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMangaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMangaId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get number => $_getN(4);
  @$pb.TagNumber(5)
  set number($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get index => $_getI64(5);
  @$pb.TagNumber(6)
  set index($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIndex() => $_has(5);
  @$pb.TagNumber(6)
  void clearIndex() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get posted => $_getI64(6);
  @$pb.TagNumber(7)
  set posted($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPosted() => $_has(6);
  @$pb.TagNumber(7)
  void clearPosted() => $_clearField(7);

  @$pb.TagNumber(8)
  ChapterOffset get offset => $_getN(7);
  @$pb.TagNumber(8)
  set offset(ChapterOffset value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasOffset() => $_has(7);
  @$pb.TagNumber(8)
  void clearOffset() => $_clearField(8);
  @$pb.TagNumber(8)
  ChapterOffset ensureOffset() => $_ensure(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get createdAt => $_getI64(8);
  @$pb.TagNumber(9)
  set createdAt($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get updatedAt => $_getI64(9);
  @$pb.TagNumber(10)
  set updatedAt($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
}

class ChaptersReply extends $pb.GeneratedMessage {
  factory ChaptersReply({
    $0.PaginateReply? pagination,
    $core.Iterable<ChapterReply>? items,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (items != null) result.items.addAll(items);
    return result;
  }

  ChaptersReply._();

  factory ChaptersReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChaptersReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChaptersReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<$0.PaginateReply>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginateReply.create)
    ..pPM<ChapterReply>(2, _omitFieldNames ? '' : 'items',
        subBuilder: ChapterReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChaptersReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChaptersReply copyWith(void Function(ChaptersReply) updates) =>
      super.copyWith((message) => updates(message as ChaptersReply))
          as ChaptersReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChaptersReply create() => ChaptersReply._();
  @$core.override
  ChaptersReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChaptersReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChaptersReply>(create);
  static ChaptersReply? _defaultInstance;

  @$pb.TagNumber(1)
  $0.PaginateReply get pagination => $_getN(0);
  @$pb.TagNumber(1)
  set pagination($0.PaginateReply value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagination() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.PaginateReply ensurePagination() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<ChapterReply> get items => $_getList(1);
}

class ImagesReply extends $pb.GeneratedMessage {
  factory ImagesReply({
    $core.Iterable<$core.String>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ImagesReply._();

  factory ImagesReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ImagesReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImagesReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'items')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImagesReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImagesReply copyWith(void Function(ImagesReply) updates) =>
      super.copyWith((message) => updates(message as ImagesReply))
          as ImagesReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImagesReply create() => ImagesReply._();
  @$core.override
  ImagesReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ImagesReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImagesReply>(create);
  static ImagesReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get items => $_getList(0);
}

class PaginateChapterQuery extends $pb.GeneratedMessage {
  factory PaginateChapterQuery({
    $core.int? id,
    $0.PaginateQuery? paginateQuery,
    $core.bool? reversed,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (paginateQuery != null) result.paginateQuery = paginateQuery;
    if (reversed != null) result.reversed = reversed;
    return result;
  }

  PaginateChapterQuery._();

  factory PaginateChapterQuery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaginateChapterQuery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaginateChapterQuery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.PaginateQuery>(2, _omitFieldNames ? '' : 'paginateQuery',
        subBuilder: $0.PaginateQuery.create)
    ..aOB(3, _omitFieldNames ? '' : 'reversed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateChapterQuery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaginateChapterQuery copyWith(void Function(PaginateChapterQuery) updates) =>
      super.copyWith((message) => updates(message as PaginateChapterQuery))
          as PaginateChapterQuery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateChapterQuery create() => PaginateChapterQuery._();
  @$core.override
  PaginateChapterQuery createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaginateChapterQuery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaginateChapterQuery>(create);
  static PaginateChapterQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.PaginateQuery get paginateQuery => $_getN(1);
  @$pb.TagNumber(2)
  set paginateQuery($0.PaginateQuery value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPaginateQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginateQuery() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PaginateQuery ensurePaginateQuery() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get reversed => $_getBF(2);
  @$pb.TagNumber(3)
  set reversed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReversed() => $_has(2);
  @$pb.TagNumber(3)
  void clearReversed() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
