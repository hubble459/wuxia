// This is a generated file - do not edit.
//
// Generated from rumgap/v1/manga.proto.

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

class MangaRequest extends $pb.GeneratedMessage {
  factory MangaRequest({
    $core.String? url,
  }) {
    final result = create();
    if (url != null) result.url = url;
    return result;
  }

  MangaRequest._();

  factory MangaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MangaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MangaRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangaRequest copyWith(void Function(MangaRequest) updates) =>
      super.copyWith((message) => updates(message as MangaRequest))
          as MangaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangaRequest create() => MangaRequest._();
  @$core.override
  MangaRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MangaRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MangaRequest>(create);
  static MangaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);
}

class MangasRequest extends $pb.GeneratedMessage {
  factory MangasRequest({
    $core.Iterable<$core.String>? urls,
  }) {
    final result = create();
    if (urls != null) result.urls.addAll(urls);
    return result;
  }

  MangasRequest._();

  factory MangasRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MangasRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MangasRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'urls')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangasRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangasRequest copyWith(void Function(MangasRequest) updates) =>
      super.copyWith((message) => updates(message as MangasRequest))
          as MangasRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangasRequest create() => MangasRequest._();
  @$core.override
  MangasRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MangasRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MangasRequest>(create);
  static MangasRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get urls => $_getList(0);
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
    final result = create();
    if (id != null) result.id = id;
    if (url != null) result.url = url;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (cover != null) result.cover = cover;
    if (isOngoing != null) result.isOngoing = isOngoing;
    if (genres != null) result.genres.addAll(genres);
    if (authors != null) result.authors.addAll(authors);
    if (altTitles != null) result.altTitles.addAll(altTitles);
    if (countChapters != null) result.countChapters = countChapters;
    if (next != null) result.next = next;
    if (last != null) result.last = last;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (readingProgress != null) result.readingProgress = readingProgress;
    if (status != null) result.status = status;
    return result;
  }

  MangaReply._();

  factory MangaReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MangaReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MangaReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
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
    ..aI(15, _omitFieldNames ? '' : 'readingProgress')
    ..aOS(16, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangaReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangaReply copyWith(void Function(MangaReply) updates) =>
      super.copyWith((message) => updates(message as MangaReply)) as MangaReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangaReply create() => MangaReply._();
  @$core.override
  MangaReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MangaReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MangaReply>(create);
  static MangaReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cover => $_getSZ(4);
  @$pb.TagNumber(5)
  set cover($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isOngoing => $_getBF(5);
  @$pb.TagNumber(6)
  set isOngoing($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsOngoing() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsOngoing() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get genres => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get authors => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get altTitles => $_getList(8);

  @$pb.TagNumber(10)
  $fixnum.Int64 get countChapters => $_getI64(9);
  @$pb.TagNumber(10)
  set countChapters($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCountChapters() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountChapters() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get next => $_getI64(10);
  @$pb.TagNumber(11)
  set next($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNext() => $_has(10);
  @$pb.TagNumber(11)
  void clearNext() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get last => $_getI64(11);
  @$pb.TagNumber(12)
  set last($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLast() => $_has(11);
  @$pb.TagNumber(12)
  void clearLast() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get createdAt => $_getI64(12);
  @$pb.TagNumber(13)
  set createdAt($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get updatedAt => $_getI64(13);
  @$pb.TagNumber(14)
  set updatedAt($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get readingProgress => $_getIZ(14);
  @$pb.TagNumber(15)
  set readingProgress($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReadingProgress() => $_has(14);
  @$pb.TagNumber(15)
  void clearReadingProgress() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get status => $_getSZ(15);
  @$pb.TagNumber(16)
  set status($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => $_clearField(16);
}

class MangasReply extends $pb.GeneratedMessage {
  factory MangasReply({
    $0.PaginateReply? pagination,
    $core.Iterable<MangaReply>? items,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (items != null) result.items.addAll(items);
    return result;
  }

  MangasReply._();

  factory MangasReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MangasReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MangasReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<$0.PaginateReply>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginateReply.create)
    ..pPM<MangaReply>(2, _omitFieldNames ? '' : 'items',
        subBuilder: MangaReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangasReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MangasReply copyWith(void Function(MangasReply) updates) =>
      super.copyWith((message) => updates(message as MangasReply))
          as MangasReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MangasReply create() => MangasReply._();
  @$core.override
  MangasReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MangasReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MangasReply>(create);
  static MangasReply? _defaultInstance;

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
  $pb.PbList<MangaReply> get items => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
