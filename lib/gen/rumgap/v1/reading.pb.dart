// This is a generated file - do not edit.
//
// Generated from rumgap/v1/reading.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ReadingPostRequest extends $pb.GeneratedMessage {
  factory ReadingPostRequest({
    $core.int? mangaId,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    return result;
  }

  ReadingPostRequest._();

  factory ReadingPostRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReadingPostRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadingPostRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadingPostRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadingPostRequest copyWith(void Function(ReadingPostRequest) updates) =>
      super.copyWith((message) => updates(message as ReadingPostRequest))
          as ReadingPostRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadingPostRequest create() => ReadingPostRequest._();
  @$core.override
  ReadingPostRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReadingPostRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadingPostRequest>(create);
  static ReadingPostRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);
}

class ReadingPatchRequest extends $pb.GeneratedMessage {
  factory ReadingPatchRequest({
    $core.int? mangaId,
    $core.int? progress,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (progress != null) result.progress = progress;
    return result;
  }

  ReadingPatchRequest._();

  factory ReadingPatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReadingPatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadingPatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aI(2, _omitFieldNames ? '' : 'progress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadingPatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadingPatchRequest copyWith(void Function(ReadingPatchRequest) updates) =>
      super.copyWith((message) => updates(message as ReadingPatchRequest))
          as ReadingPatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest create() => ReadingPatchRequest._();
  @$core.override
  ReadingPatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadingPatchRequest>(create);
  static ReadingPatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get progress => $_getIZ(1);
  @$pb.TagNumber(2)
  set progress($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => $_clearField(2);
}

class UpdateChapterOffsetRequest extends $pb.GeneratedMessage {
  factory UpdateChapterOffsetRequest({
    $core.int? chapterId,
    $core.int? pixels,
    $core.int? page,
  }) {
    final result = create();
    if (chapterId != null) result.chapterId = chapterId;
    if (pixels != null) result.pixels = pixels;
    if (page != null) result.page = page;
    return result;
  }

  UpdateChapterOffsetRequest._();

  factory UpdateChapterOffsetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateChapterOffsetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateChapterOffsetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'chapterId')
    ..aI(2, _omitFieldNames ? '' : 'pixels')
    ..aI(3, _omitFieldNames ? '' : 'page')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChapterOffsetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChapterOffsetRequest copyWith(
          void Function(UpdateChapterOffsetRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateChapterOffsetRequest))
          as UpdateChapterOffsetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChapterOffsetRequest create() => UpdateChapterOffsetRequest._();
  @$core.override
  UpdateChapterOffsetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateChapterOffsetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateChapterOffsetRequest>(create);
  static UpdateChapterOffsetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get chapterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set chapterId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pixels => $_getIZ(1);
  @$pb.TagNumber(2)
  set pixels($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPixels() => $_has(1);
  @$pb.TagNumber(2)
  void clearPixels() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
