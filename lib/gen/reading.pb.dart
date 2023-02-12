///
//  Generated code. Do not modify.
//  source: reading.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mangaId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReadingPatchRequest._() : super();
  factory ReadingPatchRequest({
    $core.int? mangaId,
    $core.int? progress,
  }) {
    final _result = create();
    if (mangaId != null) {
      _result.mangaId = mangaId;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateChapterOffsetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rumgap'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chapterId', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pixels', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  UpdateChapterOffsetRequest._() : super();
  factory UpdateChapterOffsetRequest({
    $core.int? chapterId,
    $core.int? pixels,
    $core.int? page,
  }) {
    final _result = create();
    if (chapterId != null) {
      _result.chapterId = chapterId;
    }
    if (pixels != null) {
      _result.pixels = pixels;
    }
    if (page != null) {
      _result.page = page;
    }
    return _result;
  }
  factory UpdateChapterOffsetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChapterOffsetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChapterOffsetRequest clone() => UpdateChapterOffsetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChapterOffsetRequest copyWith(void Function(UpdateChapterOffsetRequest) updates) => super.copyWith((message) => updates(message as UpdateChapterOffsetRequest)) as UpdateChapterOffsetRequest; // ignore: deprecated_member_use
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

