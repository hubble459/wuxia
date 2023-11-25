//
//  Generated code. Do not modify.
//  source: rumgap/v1/manga.proto
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

class MangaRequest extends $pb.GeneratedMessage {
  factory MangaRequest({
    $core.String? url,
  }) {
    final $result = create();
    if (url != null) {
      $result.url = url;
    }
    return $result;
  }
  MangaRequest._() : super();
  factory MangaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MangaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MangaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MangaRequest clone() => MangaRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MangaRequest copyWith(void Function(MangaRequest) updates) => super.copyWith((message) => updates(message as MangaRequest)) as MangaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangaRequest create() => MangaRequest._();
  MangaRequest createEmptyInstance() => create();
  static $pb.PbList<MangaRequest> createRepeated() => $pb.PbList<MangaRequest>();
  @$core.pragma('dart2js:noInline')
  static MangaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MangaRequest>(create);
  static MangaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);
}

class MangasRequest extends $pb.GeneratedMessage {
  factory MangasRequest({
    $core.Iterable<$core.String>? urls,
  }) {
    final $result = create();
    if (urls != null) {
      $result.urls.addAll(urls);
    }
    return $result;
  }
  MangasRequest._() : super();
  factory MangasRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MangasRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MangasRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'urls')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MangasRequest clone() => MangasRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MangasRequest copyWith(void Function(MangasRequest) updates) => super.copyWith((message) => updates(message as MangasRequest)) as MangasRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangasRequest create() => MangasRequest._();
  MangasRequest createEmptyInstance() => create();
  static $pb.PbList<MangasRequest> createRepeated() => $pb.PbList<MangasRequest>();
  @$core.pragma('dart2js:noInline')
  static MangasRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MangasRequest>(create);
  static MangasRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get urls => $_getList(0);
}

class MangaReply extends $pb.GeneratedMessage {
  factory MangaReply({
    $core.int? id,
    $core.String? url,
    $core.String? title,
    $core.String? description,
    $core.String? cover,
    $core.bool? isOngoing,
    $core.Iterable<$core.String>? genres,
    $core.Iterable<$core.String>? authors,
    $core.Iterable<$core.String>? altTitles,
    $fixnum.Int64? countChapters,
    $fixnum.Int64? next,
    $fixnum.Int64? last,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
    $core.int? readingProgress,
    $core.String? status,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (url != null) {
      $result.url = url;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (cover != null) {
      $result.cover = cover;
    }
    if (isOngoing != null) {
      $result.isOngoing = isOngoing;
    }
    if (genres != null) {
      $result.genres.addAll(genres);
    }
    if (authors != null) {
      $result.authors.addAll(authors);
    }
    if (altTitles != null) {
      $result.altTitles.addAll(altTitles);
    }
    if (countChapters != null) {
      $result.countChapters = countChapters;
    }
    if (next != null) {
      $result.next = next;
    }
    if (last != null) {
      $result.last = last;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (readingProgress != null) {
      $result.readingProgress = readingProgress;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  MangaReply._() : super();
  factory MangaReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MangaReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MangaReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'cover')
    ..aOB(6, _omitFieldNames ? '' : 'isOngoing')
    ..pPS(7, _omitFieldNames ? '' : 'genres')
    ..pPS(8, _omitFieldNames ? '' : 'authors')
    ..pPS(9, _omitFieldNames ? '' : 'altTitles')
    ..aInt64(10, _omitFieldNames ? '' : 'countChapters')
    ..aInt64(11, _omitFieldNames ? '' : 'next')
    ..aInt64(12, _omitFieldNames ? '' : 'last')
    ..aInt64(13, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(14, _omitFieldNames ? '' : 'updatedAt')
    ..a<$core.int>(15, _omitFieldNames ? '' : 'readingProgress', $pb.PbFieldType.O3)
    ..aOS(16, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MangaReply clone() => MangaReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MangaReply copyWith(void Function(MangaReply) updates) => super.copyWith((message) => updates(message as MangaReply)) as MangaReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangaReply create() => MangaReply._();
  MangaReply createEmptyInstance() => create();
  static $pb.PbList<MangaReply> createRepeated() => $pb.PbList<MangaReply>();
  @$core.pragma('dart2js:noInline')
  static MangaReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MangaReply>(create);
  static MangaReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cover => $_getSZ(4);
  @$pb.TagNumber(5)
  set cover($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isOngoing => $_getBF(5);
  @$pb.TagNumber(6)
  set isOngoing($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsOngoing() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsOngoing() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get genres => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.String> get authors => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<$core.String> get altTitles => $_getList(8);

  @$pb.TagNumber(10)
  $fixnum.Int64 get countChapters => $_getI64(9);
  @$pb.TagNumber(10)
  set countChapters($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCountChapters() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountChapters() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get next => $_getI64(10);
  @$pb.TagNumber(11)
  set next($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNext() => $_has(10);
  @$pb.TagNumber(11)
  void clearNext() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get last => $_getI64(11);
  @$pb.TagNumber(12)
  set last($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLast() => $_has(11);
  @$pb.TagNumber(12)
  void clearLast() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get createdAt => $_getI64(12);
  @$pb.TagNumber(13)
  set createdAt($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get updatedAt => $_getI64(13);
  @$pb.TagNumber(14)
  set updatedAt($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get readingProgress => $_getIZ(14);
  @$pb.TagNumber(15)
  set readingProgress($core.int v) { $_setSignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReadingProgress() => $_has(14);
  @$pb.TagNumber(15)
  void clearReadingProgress() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get status => $_getSZ(15);
  @$pb.TagNumber(16)
  set status($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => clearField(16);
}

class MangasReply extends $pb.GeneratedMessage {
  factory MangasReply({
    $2.PaginateReply? pagination,
    $core.Iterable<MangaReply>? items,
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
  MangasReply._() : super();
  factory MangasReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MangasReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MangasReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..aOM<$2.PaginateReply>(1, _omitFieldNames ? '' : 'pagination', subBuilder: $2.PaginateReply.create)
    ..pc<MangaReply>(2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: MangaReply.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MangasReply clone() => MangasReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MangasReply copyWith(void Function(MangasReply) updates) => super.copyWith((message) => updates(message as MangasReply)) as MangasReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangasReply create() => MangasReply._();
  MangasReply createEmptyInstance() => create();
  static $pb.PbList<MangasReply> createRepeated() => $pb.PbList<MangasReply>();
  @$core.pragma('dart2js:noInline')
  static MangasReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MangasReply>(create);
  static MangasReply? _defaultInstance;

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
  $core.List<MangaReply> get items => $_getList(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
