///
//  Generated code. Do not modify.
//  source: reading.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'manga.pb.dart' as $4;
import 'paginate.pb.dart' as $2;

class ReadingPostRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReadingPostRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReadingPostRequest._() : super();
  factory ReadingPostRequest({
    $core.int? mangaId,
  }) {
    final _result = create();
    if (mangaId != null) {
      _result.mangaId = mangaId;
    }
    return _result;
  }
  factory ReadingPostRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingPostRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingPostRequest clone() => ReadingPostRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingPostRequest copyWith(void Function(ReadingPostRequest) updates) => super.copyWith((message) => updates(message as ReadingPostRequest)) as ReadingPostRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReadingPostRequest create() => ReadingPostRequest._();
  ReadingPostRequest createEmptyInstance() => create();
  static $pb.PbList<ReadingPostRequest> createRepeated() => $pb.PbList<ReadingPostRequest>();
  @$core.pragma('dart2js:noInline')
  static ReadingPostRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadingPostRequest>(create);
  static ReadingPostRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => clearField(1);
}

class ReadingPatchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReadingPatchRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReadingPatchRequest._() : super();
  factory ReadingPatchRequest({
    $core.int? id,
    $core.int? progress,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (progress != null) {
      _result.progress = progress;
    }
    return _result;
  }
  factory ReadingPatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingPatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingPatchRequest clone() => ReadingPatchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingPatchRequest copyWith(void Function(ReadingPatchRequest) updates) => super.copyWith((message) => updates(message as ReadingPatchRequest)) as ReadingPatchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest create() => ReadingPatchRequest._();
  ReadingPatchRequest createEmptyInstance() => create();
  static $pb.PbList<ReadingPatchRequest> createRepeated() => $pb.PbList<ReadingPatchRequest>();
  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadingPatchRequest>(create);
  static ReadingPatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get progress => $_getIZ(1);
  @$pb.TagNumber(2)
  set progress($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => clearField(2);
}

class ReadingReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReadingReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cover')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countChapters', $pb.PbFieldType.O3)
    ..aOM<$4.MangaReply>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'manga', subBuilder: $4.MangaReply.create)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  ReadingReply._() : super();
  factory ReadingReply({
    $core.int? id,
    $core.String? title,
    $core.int? progress,
    $core.String? cover,
    $core.int? countChapters,
    $4.MangaReply? manga,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (progress != null) {
      _result.progress = progress;
    }
    if (cover != null) {
      _result.cover = cover;
    }
    if (countChapters != null) {
      _result.countChapters = countChapters;
    }
    if (manga != null) {
      _result.manga = manga;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory ReadingReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingReply clone() => ReadingReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingReply copyWith(void Function(ReadingReply) updates) => super.copyWith((message) => updates(message as ReadingReply)) as ReadingReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReadingReply create() => ReadingReply._();
  ReadingReply createEmptyInstance() => create();
  static $pb.PbList<ReadingReply> createRepeated() => $pb.PbList<ReadingReply>();
  @$core.pragma('dart2js:noInline')
  static ReadingReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadingReply>(create);
  static ReadingReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get progress => $_getIZ(2);
  @$pb.TagNumber(3)
  set progress($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cover => $_getSZ(3);
  @$pb.TagNumber(4)
  set cover($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCover() => $_has(3);
  @$pb.TagNumber(4)
  void clearCover() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get countChapters => $_getIZ(4);
  @$pb.TagNumber(5)
  set countChapters($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountChapters() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountChapters() => clearField(5);

  @$pb.TagNumber(6)
  $4.MangaReply get manga => $_getN(5);
  @$pb.TagNumber(6)
  set manga($4.MangaReply v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasManga() => $_has(5);
  @$pb.TagNumber(6)
  void clearManga() => clearField(6);
  @$pb.TagNumber(6)
  $4.MangaReply ensureManga() => $_ensure(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get updatedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set updatedAt($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => clearField(8);
}

class ReadingsReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReadingsReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..aOM<$2.PaginateReply>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginateReply.create)
    ..pc<ReadingReply>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: ReadingReply.create)
    ..hasRequiredFields = false
  ;

  ReadingsReply._() : super();
  factory ReadingsReply({
    $2.PaginateReply? pagination,
    $core.Iterable<ReadingReply>? items,
  }) {
    final _result = create();
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory ReadingsReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingsReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingsReply clone() => ReadingsReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingsReply copyWith(void Function(ReadingsReply) updates) => super.copyWith((message) => updates(message as ReadingsReply)) as ReadingsReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReadingsReply create() => ReadingsReply._();
  ReadingsReply createEmptyInstance() => create();
  static $pb.PbList<ReadingsReply> createRepeated() => $pb.PbList<ReadingsReply>();
  @$core.pragma('dart2js:noInline')
  static ReadingsReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadingsReply>(create);
  static ReadingsReply? _defaultInstance;

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
  $core.List<ReadingReply> get items => $_getList(1);
}

