//
//  Generated code. Do not modify.
//  source: rumgap/v1/reading.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReadingPostRequest extends $pb.GeneratedMessage {
  factory ReadingPostRequest({
    $core.int? mangaId,
  }) {
    final $result = create();
    if (mangaId != null) {
      $result.mangaId = mangaId;
    }
    return $result;
  }
  ReadingPostRequest._() : super();
  factory ReadingPostRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingPostRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadingPostRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingPostRequest clone() => ReadingPostRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingPostRequest copyWith(void Function(ReadingPostRequest) updates) => super.copyWith((message) => updates(message as ReadingPostRequest)) as ReadingPostRequest;

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
  factory ReadingPatchRequest({
    $core.int? mangaId,
    $core.int? progress,
  }) {
    final $result = create();
    if (mangaId != null) {
      $result.mangaId = mangaId;
    }
    if (progress != null) {
      $result.progress = progress;
    }
    return $result;
  }
  ReadingPatchRequest._() : super();
  factory ReadingPatchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadingPatchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadingPatchRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'progress', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadingPatchRequest clone() => ReadingPatchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadingPatchRequest copyWith(void Function(ReadingPatchRequest) updates) => super.copyWith((message) => updates(message as ReadingPatchRequest)) as ReadingPatchRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest create() => ReadingPatchRequest._();
  ReadingPatchRequest createEmptyInstance() => create();
  static $pb.PbList<ReadingPatchRequest> createRepeated() => $pb.PbList<ReadingPatchRequest>();
  @$core.pragma('dart2js:noInline')
  static ReadingPatchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadingPatchRequest>(create);
  static ReadingPatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get progress => $_getIZ(1);
  @$pb.TagNumber(2)
  set progress($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProgress() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgress() => clearField(2);
}

class UpdateChapterOffsetRequest extends $pb.GeneratedMessage {
  factory UpdateChapterOffsetRequest({
    $core.int? chapterId,
    $core.int? pixels,
    $core.int? page,
  }) {
    final $result = create();
    if (chapterId != null) {
      $result.chapterId = chapterId;
    }
    if (pixels != null) {
      $result.pixels = pixels;
    }
    if (page != null) {
      $result.page = page;
    }
    return $result;
  }
  UpdateChapterOffsetRequest._() : super();
  factory UpdateChapterOffsetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChapterOffsetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateChapterOffsetRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'chapterId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pixels', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChapterOffsetRequest clone() => UpdateChapterOffsetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChapterOffsetRequest copyWith(void Function(UpdateChapterOffsetRequest) updates) => super.copyWith((message) => updates(message as UpdateChapterOffsetRequest)) as UpdateChapterOffsetRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChapterOffsetRequest create() => UpdateChapterOffsetRequest._();
  UpdateChapterOffsetRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateChapterOffsetRequest> createRepeated() => $pb.PbList<UpdateChapterOffsetRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateChapterOffsetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateChapterOffsetRequest>(create);
  static UpdateChapterOffsetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get chapterId => $_getIZ(0);
  @$pb.TagNumber(1)
  set chapterId($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChapterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChapterId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pixels => $_getIZ(1);
  @$pb.TagNumber(2)
  set pixels($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPixels() => $_has(1);
  @$pb.TagNumber(2)
  void clearPixels() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
