// This is a generated file - do not edit.
//
// Generated from rumgap/v1/search.proto.

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

class SearchRequest extends $pb.GeneratedMessage {
  factory SearchRequest({
    $core.String? keyword,
    $core.Iterable<$core.String>? hostnames,
  }) {
    final result = create();
    if (keyword != null) result.keyword = keyword;
    if (hostnames != null) result.hostnames.addAll(hostnames);
    return result;
  }

  SearchRequest._();

  factory SearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyword')
    ..pPS(2, _omitFieldNames ? '' : 'hostnames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRequest copyWith(void Function(SearchRequest) updates) =>
      super.copyWith((message) => updates(message as SearchRequest))
          as SearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRequest create() => SearchRequest._();
  @$core.override
  SearchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRequest>(create);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get keyword => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyword($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKeyword() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyword() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get hostnames => $_getList(1);
}

class SearchManga extends $pb.GeneratedMessage {
  factory SearchManga({
    $core.int? mangaId,
    $core.String? title,
    $core.String? url,
    $fixnum.Int64? posted,
    $core.String? cover,
    $core.bool? isReading,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (title != null) result.title = title;
    if (url != null) result.url = url;
    if (posted != null) result.posted = posted;
    if (cover != null) result.cover = cover;
    if (isReading != null) result.isReading = isReading;
    return result;
  }

  SearchManga._();

  factory SearchManga.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchManga.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchManga',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aInt64(4, _omitFieldNames ? '' : 'posted')
    ..aOS(5, _omitFieldNames ? '' : 'cover')
    ..aOB(6, _omitFieldNames ? '' : 'isReading')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchManga clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchManga copyWith(void Function(SearchManga) updates) =>
      super.copyWith((message) => updates(message as SearchManga))
          as SearchManga;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchManga create() => SearchManga._();
  @$core.override
  SearchManga createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchManga getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchManga>(create);
  static SearchManga? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get posted => $_getI64(3);
  @$pb.TagNumber(4)
  set posted($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPosted() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosted() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cover => $_getSZ(4);
  @$pb.TagNumber(5)
  set cover($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCover() => $_has(4);
  @$pb.TagNumber(5)
  void clearCover() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isReading => $_getBF(5);
  @$pb.TagNumber(6)
  set isReading($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsReading() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsReading() => $_clearField(6);
}

class SearchReply extends $pb.GeneratedMessage {
  factory SearchReply({
    $core.Iterable<SearchManga>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  SearchReply._();

  factory SearchReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPM<SearchManga>(1, _omitFieldNames ? '' : 'items',
        subBuilder: SearchManga.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchReply copyWith(void Function(SearchReply) updates) =>
      super.copyWith((message) => updates(message as SearchReply))
          as SearchReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchReply create() => SearchReply._();
  @$core.override
  SearchReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchReply>(create);
  static SearchReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SearchManga> get items => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
