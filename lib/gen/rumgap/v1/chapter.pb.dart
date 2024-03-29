//
//  Generated code. Do not modify.
//  source: rumgap/v1/chapter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'paginate.pb.dart' as $2;

class ChapterRequest extends $pb.GeneratedMessage {
  factory ChapterRequest({
    $core.int? mangaId,
    $core.int? index,
  }) {
    final $result = create();
    if (mangaId != null) {
      $result.mangaId = mangaId;
    }
    if (index != null) {
      $result.index = index;
    }
    return $result;
  }
  ChapterRequest._() : super();
  factory ChapterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChapterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChapterRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'index', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChapterRequest clone() => ChapterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChapterRequest copyWith(void Function(ChapterRequest) updates) => super.copyWith((message) => updates(message as ChapterRequest)) as ChapterRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterRequest create() => ChapterRequest._();
  ChapterRequest createEmptyInstance() => create();
  static $pb.PbList<ChapterRequest> createRepeated() => $pb.PbList<ChapterRequest>();
  @$core.pragma('dart2js:noInline')
  static ChapterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChapterRequest>(create);
  static ChapterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => clearField(2);
}

class ChapterOffset extends $pb.GeneratedMessage {
  factory ChapterOffset({
    $core.int? pixels,
    $core.int? page,
  }) {
    final $result = create();
    if (pixels != null) {
      $result.pixels = pixels;
    }
    if (page != null) {
      $result.page = page;
    }
    return $result;
  }
  ChapterOffset._() : super();
  factory ChapterOffset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChapterOffset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChapterOffset', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pixels', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChapterOffset clone() => ChapterOffset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChapterOffset copyWith(void Function(ChapterOffset) updates) => super.copyWith((message) => updates(message as ChapterOffset)) as ChapterOffset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterOffset create() => ChapterOffset._();
  ChapterOffset createEmptyInstance() => create();
  static $pb.PbList<ChapterOffset> createRepeated() => $pb.PbList<ChapterOffset>();
  @$core.pragma('dart2js:noInline')
  static ChapterOffset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChapterOffset>(create);
  static ChapterOffset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pixels => $_getIZ(0);
  @$pb.TagNumber(1)
  set pixels($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPixels() => $_has(0);
  @$pb.TagNumber(1)
  void clearPixels() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (mangaId != null) {
      $result.mangaId = mangaId;
    }
    if (url != null) {
      $result.url = url;
    }
    if (title != null) {
      $result.title = title;
    }
    if (number != null) {
      $result.number = number;
    }
    if (index != null) {
      $result.index = index;
    }
    if (posted != null) {
      $result.posted = posted;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  ChapterReply._() : super();
  factory ChapterReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChapterReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChapterReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'number', $pb.PbFieldType.OF)
    ..aInt64(6, _omitFieldNames ? '' : 'index')
    ..aInt64(7, _omitFieldNames ? '' : 'posted')
    ..aOM<ChapterOffset>(8, _omitFieldNames ? '' : 'offset', subBuilder: ChapterOffset.create)
    ..aInt64(9, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChapterReply clone() => ChapterReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChapterReply copyWith(void Function(ChapterReply) updates) => super.copyWith((message) => updates(message as ChapterReply)) as ChapterReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChapterReply create() => ChapterReply._();
  ChapterReply createEmptyInstance() => create();
  static $pb.PbList<ChapterReply> createRepeated() => $pb.PbList<ChapterReply>();
  @$core.pragma('dart2js:noInline')
  static ChapterReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChapterReply>(create);
  static ChapterReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get mangaId => $_getIZ(1);
  @$pb.TagNumber(2)
  set mangaId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMangaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMangaId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get number => $_getN(4);
  @$pb.TagNumber(5)
  set number($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumber() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get index => $_getI64(5);
  @$pb.TagNumber(6)
  set index($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIndex() => $_has(5);
  @$pb.TagNumber(6)
  void clearIndex() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get posted => $_getI64(6);
  @$pb.TagNumber(7)
  set posted($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPosted() => $_has(6);
  @$pb.TagNumber(7)
  void clearPosted() => clearField(7);

  @$pb.TagNumber(8)
  ChapterOffset get offset => $_getN(7);
  @$pb.TagNumber(8)
  set offset(ChapterOffset v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasOffset() => $_has(7);
  @$pb.TagNumber(8)
  void clearOffset() => clearField(8);
  @$pb.TagNumber(8)
  ChapterOffset ensureOffset() => $_ensure(7);

  @$pb.TagNumber(9)
  $fixnum.Int64 get createdAt => $_getI64(8);
  @$pb.TagNumber(9)
  set createdAt($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get updatedAt => $_getI64(9);
  @$pb.TagNumber(10)
  set updatedAt($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => clearField(10);
}

class ChaptersReply extends $pb.GeneratedMessage {
  factory ChaptersReply({
    $2.PaginateReply? pagination,
    $core.Iterable<ChapterReply>? items,
  }) {
    final $result = create();
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  ChaptersReply._() : super();
  factory ChaptersReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChaptersReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChaptersReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..aOM<$2.PaginateReply>(1, _omitFieldNames ? '' : 'pagination', subBuilder: $2.PaginateReply.create)
    ..pc<ChapterReply>(2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: ChapterReply.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChaptersReply clone() => ChaptersReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChaptersReply copyWith(void Function(ChaptersReply) updates) => super.copyWith((message) => updates(message as ChaptersReply)) as ChaptersReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChaptersReply create() => ChaptersReply._();
  ChaptersReply createEmptyInstance() => create();
  static $pb.PbList<ChaptersReply> createRepeated() => $pb.PbList<ChaptersReply>();
  @$core.pragma('dart2js:noInline')
  static ChaptersReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChaptersReply>(create);
  static ChaptersReply? _defaultInstance;

  @$pb.TagNumber(1)
  $2.PaginateReply get pagination => $_getN(0);
  @$pb.TagNumber(1)
  set pagination($2.PaginateReply v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagination() => clearField(1);
  @$pb.TagNumber(1)
  $2.PaginateReply ensurePagination() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<ChapterReply> get items => $_getList(1);
}

class ImagesReply extends $pb.GeneratedMessage {
  factory ImagesReply({
    $core.Iterable<$core.String>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  ImagesReply._() : super();
  factory ImagesReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImagesReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ImagesReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'items')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImagesReply clone() => ImagesReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImagesReply copyWith(void Function(ImagesReply) updates) => super.copyWith((message) => updates(message as ImagesReply)) as ImagesReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImagesReply create() => ImagesReply._();
  ImagesReply createEmptyInstance() => create();
  static $pb.PbList<ImagesReply> createRepeated() => $pb.PbList<ImagesReply>();
  @$core.pragma('dart2js:noInline')
  static ImagesReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImagesReply>(create);
  static ImagesReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get items => $_getList(0);
}

class PaginateChapterQuery extends $pb.GeneratedMessage {
  factory PaginateChapterQuery({
    $core.int? id,
    $2.PaginateQuery? paginateQuery,
    $core.bool? reversed,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (paginateQuery != null) {
      $result.paginateQuery = paginateQuery;
    }
    if (reversed != null) {
      $result.reversed = reversed;
    }
    return $result;
  }
  PaginateChapterQuery._() : super();
  factory PaginateChapterQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginateChapterQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginateChapterQuery', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOM<$2.PaginateQuery>(2, _omitFieldNames ? '' : 'paginateQuery', subBuilder: $2.PaginateQuery.create)
    ..aOB(3, _omitFieldNames ? '' : 'reversed')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginateChapterQuery clone() => PaginateChapterQuery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginateChapterQuery copyWith(void Function(PaginateChapterQuery) updates) => super.copyWith((message) => updates(message as PaginateChapterQuery)) as PaginateChapterQuery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaginateChapterQuery create() => PaginateChapterQuery._();
  PaginateChapterQuery createEmptyInstance() => create();
  static $pb.PbList<PaginateChapterQuery> createRepeated() => $pb.PbList<PaginateChapterQuery>();
  @$core.pragma('dart2js:noInline')
  static PaginateChapterQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginateChapterQuery>(create);
  static PaginateChapterQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $2.PaginateQuery get paginateQuery => $_getN(1);
  @$pb.TagNumber(2)
  set paginateQuery($2.PaginateQuery v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaginateQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaginateQuery() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginateQuery ensurePaginateQuery() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get reversed => $_getBF(2);
  @$pb.TagNumber(3)
  set reversed($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReversed() => $_has(2);
  @$pb.TagNumber(3)
  void clearReversed() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
