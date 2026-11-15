// This is a generated file - do not edit.
//
// Generated from rumgap/v1/anilist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'anilist.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'anilist.pbenum.dart';

class AnilistInfo extends $pb.GeneratedMessage {
  factory AnilistInfo({
    $core.int? id,
    $core.String? url,
    $core.String? title,
    $core.String? description,
    $core.String? cover,
    $core.String? banner,
    $core.int? score,
    $core.Iterable<$core.String>? genres,
    $core.String? status,
    $core.bool? matchManual,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (url != null) result.url = url;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (cover != null) result.cover = cover;
    if (banner != null) result.banner = banner;
    if (score != null) result.score = score;
    if (genres != null) result.genres.addAll(genres);
    if (status != null) result.status = status;
    if (matchManual != null) result.matchManual = matchManual;
    return result;
  }

  AnilistInfo._();

  factory AnilistInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'cover')
    ..aOS(6, _omitFieldNames ? '' : 'banner')
    ..aI(7, _omitFieldNames ? '' : 'score')
    ..pPS(8, _omitFieldNames ? '' : 'genres')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOB(10, _omitFieldNames ? '' : 'matchManual')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistInfo copyWith(void Function(AnilistInfo) updates) =>
      super.copyWith((message) => updates(message as AnilistInfo))
          as AnilistInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistInfo create() => AnilistInfo._();
  @$core.override
  AnilistInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistInfo>(create);
  static AnilistInfo? _defaultInstance;

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
  $core.String get banner => $_getSZ(5);
  @$pb.TagNumber(6)
  set banner($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBanner() => $_has(5);
  @$pb.TagNumber(6)
  void clearBanner() => $_clearField(6);

  /// 0-100
  @$pb.TagNumber(7)
  $core.int get score => $_getIZ(6);
  @$pb.TagNumber(7)
  set score($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasScore() => $_has(6);
  @$pb.TagNumber(7)
  void clearScore() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get genres => $_getList(7);

  /// FINISHED, RELEASING, NOT_YET_RELEASED, CANCELLED or HIATUS
  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  /// Picked by a user instead of matched by title; title matching leaves it alone.
  @$pb.TagNumber(10)
  $core.bool get matchManual => $_getBF(9);
  @$pb.TagNumber(10)
  set matchManual($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMatchManual() => $_has(9);
  @$pb.TagNumber(10)
  void clearMatchManual() => $_clearField(10);
}

class AnilistConnectUrlRequest extends $pb.GeneratedMessage {
  factory AnilistConnectUrlRequest({
    AnilistReturnTarget? returnTarget,
  }) {
    final result = create();
    if (returnTarget != null) result.returnTarget = returnTarget;
    return result;
  }

  AnilistConnectUrlRequest._();

  factory AnilistConnectUrlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistConnectUrlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistConnectUrlRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<AnilistReturnTarget>(1, _omitFieldNames ? '' : 'returnTarget',
        enumValues: AnilistReturnTarget.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistConnectUrlRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistConnectUrlRequest copyWith(
          void Function(AnilistConnectUrlRequest) updates) =>
      super.copyWith((message) => updates(message as AnilistConnectUrlRequest))
          as AnilistConnectUrlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistConnectUrlRequest create() => AnilistConnectUrlRequest._();
  @$core.override
  AnilistConnectUrlRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistConnectUrlRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistConnectUrlRequest>(create);
  static AnilistConnectUrlRequest? _defaultInstance;

  @$pb.TagNumber(1)
  AnilistReturnTarget get returnTarget => $_getN(0);
  @$pb.TagNumber(1)
  set returnTarget(AnilistReturnTarget value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReturnTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearReturnTarget() => $_clearField(1);
}

class AnilistConnectUrlReply extends $pb.GeneratedMessage {
  factory AnilistConnectUrlReply({
    $core.String? url,
  }) {
    final result = create();
    if (url != null) result.url = url;
    return result;
  }

  AnilistConnectUrlReply._();

  factory AnilistConnectUrlReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistConnectUrlReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistConnectUrlReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistConnectUrlReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistConnectUrlReply copyWith(
          void Function(AnilistConnectUrlReply) updates) =>
      super.copyWith((message) => updates(message as AnilistConnectUrlReply))
          as AnilistConnectUrlReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistConnectUrlReply create() => AnilistConnectUrlReply._();
  @$core.override
  AnilistConnectUrlReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistConnectUrlReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistConnectUrlReply>(create);
  static AnilistConnectUrlReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);
}

class AnilistStatusReply extends $pb.GeneratedMessage {
  factory AnilistStatusReply({
    $core.bool? connected,
    $core.int? userId,
    $core.String? userName,
    $fixnum.Int64? expiresAt,
    $core.bool? expiresSoon,
  }) {
    final result = create();
    if (connected != null) result.connected = connected;
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (expiresSoon != null) result.expiresSoon = expiresSoon;
    return result;
  }

  AnilistStatusReply._();

  factory AnilistStatusReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistStatusReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistStatusReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'connected')
    ..aI(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'userName')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresAt')
    ..aOB(5, _omitFieldNames ? '' : 'expiresSoon')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistStatusReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistStatusReply copyWith(void Function(AnilistStatusReply) updates) =>
      super.copyWith((message) => updates(message as AnilistStatusReply))
          as AnilistStatusReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistStatusReply create() => AnilistStatusReply._();
  @$core.override
  AnilistStatusReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistStatusReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistStatusReply>(create);
  static AnilistStatusReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get connected => $_getBF(0);
  @$pb.TagNumber(1)
  set connected($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasConnected() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnected() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get userId => $_getIZ(1);
  @$pb.TagNumber(2)
  set userId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userName => $_getSZ(2);
  @$pb.TagNumber(3)
  set userName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserName() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserName() => $_clearField(3);

  /// Epoch millis. Tokens last a year and can't be refreshed; connect again to renew.
  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);

  /// Less than ANILIST_EXPIRY_WARN_DAYS left.
  @$pb.TagNumber(5)
  $core.bool get expiresSoon => $_getBF(4);
  @$pb.TagNumber(5)
  set expiresSoon($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresSoon() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresSoon() => $_clearField(5);
}

class AnilistSearchRequest extends $pb.GeneratedMessage {
  factory AnilistSearchRequest({
    $core.String? query,
  }) {
    final result = create();
    if (query != null) result.query = query;
    return result;
  }

  AnilistSearchRequest._();

  factory AnilistSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistSearchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistSearchRequest copyWith(void Function(AnilistSearchRequest) updates) =>
      super.copyWith((message) => updates(message as AnilistSearchRequest))
          as AnilistSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistSearchRequest create() => AnilistSearchRequest._();
  @$core.override
  AnilistSearchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistSearchRequest>(create);
  static AnilistSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);
}

class AnilistMedia extends $pb.GeneratedMessage {
  factory AnilistMedia({
    $core.int? id,
    $core.String? url,
    $core.String? titleRomaji,
    $core.String? titleEnglish,
    $core.String? titleNative,
    $core.Iterable<$core.String>? synonyms,
    $core.String? cover,
    $core.int? chapters,
    $core.String? status,
    $core.String? format,
    $core.int? startYear,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (url != null) result.url = url;
    if (titleRomaji != null) result.titleRomaji = titleRomaji;
    if (titleEnglish != null) result.titleEnglish = titleEnglish;
    if (titleNative != null) result.titleNative = titleNative;
    if (synonyms != null) result.synonyms.addAll(synonyms);
    if (cover != null) result.cover = cover;
    if (chapters != null) result.chapters = chapters;
    if (status != null) result.status = status;
    if (format != null) result.format = format;
    if (startYear != null) result.startYear = startYear;
    return result;
  }

  AnilistMedia._();

  factory AnilistMedia.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistMedia.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistMedia',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'titleRomaji')
    ..aOS(4, _omitFieldNames ? '' : 'titleEnglish')
    ..aOS(5, _omitFieldNames ? '' : 'titleNative')
    ..pPS(6, _omitFieldNames ? '' : 'synonyms')
    ..aOS(7, _omitFieldNames ? '' : 'cover')
    ..aI(8, _omitFieldNames ? '' : 'chapters')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOS(10, _omitFieldNames ? '' : 'format')
    ..aI(11, _omitFieldNames ? '' : 'startYear')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistMedia clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistMedia copyWith(void Function(AnilistMedia) updates) =>
      super.copyWith((message) => updates(message as AnilistMedia))
          as AnilistMedia;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistMedia create() => AnilistMedia._();
  @$core.override
  AnilistMedia createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistMedia getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistMedia>(create);
  static AnilistMedia? _defaultInstance;

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
  $core.String get titleRomaji => $_getSZ(2);
  @$pb.TagNumber(3)
  set titleRomaji($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitleRomaji() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitleRomaji() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get titleEnglish => $_getSZ(3);
  @$pb.TagNumber(4)
  set titleEnglish($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTitleEnglish() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitleEnglish() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get titleNative => $_getSZ(4);
  @$pb.TagNumber(5)
  set titleNative($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitleNative() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitleNative() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get synonyms => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get cover => $_getSZ(6);
  @$pb.TagNumber(7)
  set cover($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCover() => $_has(6);
  @$pb.TagNumber(7)
  void clearCover() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get chapters => $_getIZ(7);
  @$pb.TagNumber(8)
  set chapters($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasChapters() => $_has(7);
  @$pb.TagNumber(8)
  void clearChapters() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get format => $_getSZ(9);
  @$pb.TagNumber(10)
  set format($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFormat() => $_has(9);
  @$pb.TagNumber(10)
  void clearFormat() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get startYear => $_getIZ(10);
  @$pb.TagNumber(11)
  set startYear($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStartYear() => $_has(10);
  @$pb.TagNumber(11)
  void clearStartYear() => $_clearField(11);
}

class AnilistSearchReply extends $pb.GeneratedMessage {
  factory AnilistSearchReply({
    $core.Iterable<AnilistMedia>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  AnilistSearchReply._();

  factory AnilistSearchReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AnilistSearchReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AnilistSearchReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPM<AnilistMedia>(1, _omitFieldNames ? '' : 'items',
        subBuilder: AnilistMedia.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistSearchReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AnilistSearchReply copyWith(void Function(AnilistSearchReply) updates) =>
      super.copyWith((message) => updates(message as AnilistSearchReply))
          as AnilistSearchReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnilistSearchReply create() => AnilistSearchReply._();
  @$core.override
  AnilistSearchReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AnilistSearchReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AnilistSearchReply>(create);
  static AnilistSearchReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AnilistMedia> get items => $_getList(0);
}

class SetAnilistMatchRequest extends $pb.GeneratedMessage {
  factory SetAnilistMatchRequest({
    $core.int? mangaId,
    $core.int? anilistId,
    $core.bool? rematch,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (anilistId != null) result.anilistId = anilistId;
    if (rematch != null) result.rematch = rematch;
    return result;
  }

  SetAnilistMatchRequest._();

  factory SetAnilistMatchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetAnilistMatchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetAnilistMatchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aI(2, _omitFieldNames ? '' : 'anilistId')
    ..aOB(3, _omitFieldNames ? '' : 'rematch')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetAnilistMatchRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetAnilistMatchRequest copyWith(
          void Function(SetAnilistMatchRequest) updates) =>
      super.copyWith((message) => updates(message as SetAnilistMatchRequest))
          as SetAnilistMatchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetAnilistMatchRequest create() => SetAnilistMatchRequest._();
  @$core.override
  SetAnilistMatchRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SetAnilistMatchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetAnilistMatchRequest>(create);
  static SetAnilistMatchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  /// Unset: this manga has no AniList entry (title matching won't set one either).
  @$pb.TagNumber(2)
  $core.int get anilistId => $_getIZ(1);
  @$pb.TagNumber(2)
  set anilistId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAnilistId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnilistId() => $_clearField(2);

  /// Clear a manual pick and let title matching find the entry again.
  @$pb.TagNumber(3)
  $core.bool get rematch => $_getBF(2);
  @$pb.TagNumber(3)
  set rematch($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRematch() => $_has(2);
  @$pb.TagNumber(3)
  void clearRematch() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
