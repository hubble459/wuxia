// This is a generated file - do not edit.
//
// Generated from rumgap/v1/meta.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'meta.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'meta.pbenum.dart';

class MetaReply extends $pb.GeneratedMessage {
  factory MetaReply({
    $core.Iterable<$core.String>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  MetaReply._();

  factory MetaReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'items')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaReply copyWith(void Function(MetaReply) updates) =>
      super.copyWith((message) => updates(message as MetaReply)) as MetaReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaReply create() => MetaReply._();
  @$core.override
  MetaReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MetaReply>(create);
  static MetaReply? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get items => $_getList(0);
}

class MetaHostnamesRequest extends $pb.GeneratedMessage {
  factory MetaHostnamesRequest({
    MetaHostnamesOption? option,
  }) {
    final result = create();
    if (option != null) result.option = option;
    return result;
  }

  MetaHostnamesRequest._();

  factory MetaHostnamesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaHostnamesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaHostnamesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<MetaHostnamesOption>(1, _omitFieldNames ? '' : 'option',
        enumValues: MetaHostnamesOption.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaHostnamesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaHostnamesRequest copyWith(void Function(MetaHostnamesRequest) updates) =>
      super.copyWith((message) => updates(message as MetaHostnamesRequest))
          as MetaHostnamesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest create() => MetaHostnamesRequest._();
  @$core.override
  MetaHostnamesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaHostnamesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetaHostnamesRequest>(create);
  static MetaHostnamesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaHostnamesOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaHostnamesOption value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => $_clearField(1);
}

class MetaGenresRequest extends $pb.GeneratedMessage {
  factory MetaGenresRequest({
    MetaGenresOption? option,
  }) {
    final result = create();
    if (option != null) result.option = option;
    return result;
  }

  MetaGenresRequest._();

  factory MetaGenresRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MetaGenresRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetaGenresRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aE<MetaGenresOption>(1, _omitFieldNames ? '' : 'option',
        enumValues: MetaGenresOption.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaGenresRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MetaGenresRequest copyWith(void Function(MetaGenresRequest) updates) =>
      super.copyWith((message) => updates(message as MetaGenresRequest))
          as MetaGenresRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest create() => MetaGenresRequest._();
  @$core.override
  MetaGenresRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MetaGenresRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetaGenresRequest>(create);
  static MetaGenresRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MetaGenresOption get option => $_getN(0);
  @$pb.TagNumber(1)
  set option(MetaGenresOption value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOption() => $_has(0);
  @$pb.TagNumber(1)
  void clearOption() => $_clearField(1);
}

class StatsReply extends $pb.GeneratedMessage {
  factory StatsReply({
    $fixnum.Int64? countTotalReading,
    $fixnum.Int64? countTotalChapters,
    $fixnum.Int64? countReading,
    $fixnum.Int64? countChapters,
  }) {
    final result = create();
    if (countTotalReading != null) result.countTotalReading = countTotalReading;
    if (countTotalChapters != null)
      result.countTotalChapters = countTotalChapters;
    if (countReading != null) result.countReading = countReading;
    if (countChapters != null) result.countChapters = countChapters;
    return result;
  }

  StatsReply._();

  factory StatsReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'countTotalReading')
    ..aInt64(2, _omitFieldNames ? '' : 'countTotalChapters')
    ..aInt64(3, _omitFieldNames ? '' : 'countReading')
    ..aInt64(4, _omitFieldNames ? '' : 'countChapters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsReply copyWith(void Function(StatsReply) updates) =>
      super.copyWith((message) => updates(message as StatsReply)) as StatsReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsReply create() => StatsReply._();
  @$core.override
  StatsReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatsReply>(create);
  static StatsReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get countTotalReading => $_getI64(0);
  @$pb.TagNumber(1)
  set countTotalReading($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountTotalReading() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountTotalReading() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get countTotalChapters => $_getI64(1);
  @$pb.TagNumber(2)
  set countTotalChapters($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountTotalChapters() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountTotalChapters() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get countReading => $_getI64(2);
  @$pb.TagNumber(3)
  set countReading($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountReading() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountReading() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get countChapters => $_getI64(3);
  @$pb.TagNumber(4)
  set countChapters($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountChapters() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountChapters() => $_clearField(4);
}

class DetailedStatsRequest extends $pb.GeneratedMessage {
  factory DetailedStatsRequest({
    $core.int? utcOffsetMinutes,
  }) {
    final result = create();
    if (utcOffsetMinutes != null) result.utcOffsetMinutes = utcOffsetMinutes;
    return result;
  }

  DetailedStatsRequest._();

  factory DetailedStatsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DetailedStatsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DetailedStatsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'utcOffsetMinutes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetailedStatsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetailedStatsRequest copyWith(void Function(DetailedStatsRequest) updates) =>
      super.copyWith((message) => updates(message as DetailedStatsRequest))
          as DetailedStatsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetailedStatsRequest create() => DetailedStatsRequest._();
  @$core.override
  DetailedStatsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DetailedStatsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DetailedStatsRequest>(create);
  static DetailedStatsRequest? _defaultInstance;

  /// Minutes to add to UTC for the viewer's local time, so days, hours and streaks follow
  /// their own clock rather than the server's.
  @$pb.TagNumber(1)
  $core.int get utcOffsetMinutes => $_getIZ(0);
  @$pb.TagNumber(1)
  set utcOffsetMinutes($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUtcOffsetMinutes() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtcOffsetMinutes() => $_clearField(1);
}

class StatsDay extends $pb.GeneratedMessage {
  factory StatsDay({
    $core.int? day,
    $fixnum.Int64? chapters,
  }) {
    final result = create();
    if (day != null) result.day = day;
    if (chapters != null) result.chapters = chapters;
    return result;
  }

  StatsDay._();

  factory StatsDay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsDay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsDay',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'day')
    ..aInt64(2, _omitFieldNames ? '' : 'chapters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsDay clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsDay copyWith(void Function(StatsDay) updates) =>
      super.copyWith((message) => updates(message as StatsDay)) as StatsDay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsDay create() => StatsDay._();
  @$core.override
  StatsDay createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsDay getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatsDay>(create);
  static StatsDay? _defaultInstance;

  /// Days since 1970-01-01, in the viewer's local time.
  @$pb.TagNumber(1)
  $core.int get day => $_getIZ(0);
  @$pb.TagNumber(1)
  set day($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDay() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chapters => $_getI64(1);
  @$pb.TagNumber(2)
  set chapters($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChapters() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapters() => $_clearField(2);
}

class StatsCount extends $pb.GeneratedMessage {
  factory StatsCount({
    $core.String? name,
    $fixnum.Int64? series,
    $fixnum.Int64? chapters,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (series != null) result.series = series;
    if (chapters != null) result.chapters = chapters;
    return result;
  }

  StatsCount._();

  factory StatsCount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsCount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsCount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'series')
    ..aInt64(3, _omitFieldNames ? '' : 'chapters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsCount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsCount copyWith(void Function(StatsCount) updates) =>
      super.copyWith((message) => updates(message as StatsCount)) as StatsCount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsCount create() => StatsCount._();
  @$core.override
  StatsCount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsCount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatsCount>(create);
  static StatsCount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get series => $_getI64(1);
  @$pb.TagNumber(2)
  set series($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSeries() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeries() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get chapters => $_getI64(2);
  @$pb.TagNumber(3)
  set chapters($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChapters() => $_has(2);
  @$pb.TagNumber(3)
  void clearChapters() => $_clearField(3);
}

class StatsSeries extends $pb.GeneratedMessage {
  factory StatsSeries({
    $core.int? mangaId,
    $core.String? title,
    $core.String? cover,
    $fixnum.Int64? progress,
    $fixnum.Int64? total,
    $fixnum.Int64? amount,
    $fixnum.Int64? at,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (title != null) result.title = title;
    if (cover != null) result.cover = cover;
    if (progress != null) result.progress = progress;
    if (total != null) result.total = total;
    if (amount != null) result.amount = amount;
    if (at != null) result.at = at;
    return result;
  }

  StatsSeries._();

  factory StatsSeries.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsSeries.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsSeries',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'cover')
    ..aInt64(4, _omitFieldNames ? '' : 'progress')
    ..aInt64(5, _omitFieldNames ? '' : 'total')
    ..aInt64(6, _omitFieldNames ? '' : 'amount')
    ..aInt64(7, _omitFieldNames ? '' : 'at')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsSeries clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsSeries copyWith(void Function(StatsSeries) updates) =>
      super.copyWith((message) => updates(message as StatsSeries))
          as StatsSeries;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsSeries create() => StatsSeries._();
  @$core.override
  StatsSeries createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsSeries getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatsSeries>(create);
  static StatsSeries? _defaultInstance;

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
  $core.String get cover => $_getSZ(2);
  @$pb.TagNumber(3)
  set cover($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCover() => $_has(2);
  @$pb.TagNumber(3)
  void clearCover() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get progress => $_getI64(3);
  @$pb.TagNumber(4)
  set progress($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProgress() => $_has(3);
  @$pb.TagNumber(4)
  void clearProgress() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get total => $_getI64(4);
  @$pb.TagNumber(5)
  set total($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotal() => $_clearField(5);

  /// Days idle, days to finish, days together or chapters in one day - depends on the field.
  @$pb.TagNumber(6)
  $fixnum.Int64 get amount => $_getI64(5);
  @$pb.TagNumber(6)
  set amount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  /// Epoch millis of the moment the field is about (finished, last read...). For a day
  /// (`biggest_binge`) it's that local date's midnight as UTC.
  @$pb.TagNumber(7)
  $fixnum.Int64 get at => $_getI64(6);
  @$pb.TagNumber(7)
  set at($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearAt() => $_clearField(7);
}

class StatsFriend extends $pb.GeneratedMessage {
  factory StatsFriend({
    $core.int? userId,
    $core.String? username,
    $core.bool? isMe,
    $fixnum.Int64? chapters30d,
    $fixnum.Int64? chaptersTotal,
    $core.int? currentStreak,
    $core.int? longestStreak,
    $fixnum.Int64? sharedCount,
    $core.Iterable<$core.String>? sharedTitles,
    $core.bool? isPrivate,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (isMe != null) result.isMe = isMe;
    if (chapters30d != null) result.chapters30d = chapters30d;
    if (chaptersTotal != null) result.chaptersTotal = chaptersTotal;
    if (currentStreak != null) result.currentStreak = currentStreak;
    if (longestStreak != null) result.longestStreak = longestStreak;
    if (sharedCount != null) result.sharedCount = sharedCount;
    if (sharedTitles != null) result.sharedTitles.addAll(sharedTitles);
    if (isPrivate != null) result.isPrivate = isPrivate;
    return result;
  }

  StatsFriend._();

  factory StatsFriend.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsFriend.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsFriend',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOB(3, _omitFieldNames ? '' : 'isMe')
    ..aInt64(4, _omitFieldNames ? '' : 'chapters30d', protoName: 'chapters_30d')
    ..aInt64(5, _omitFieldNames ? '' : 'chaptersTotal')
    ..aI(6, _omitFieldNames ? '' : 'currentStreak')
    ..aI(7, _omitFieldNames ? '' : 'longestStreak')
    ..aInt64(8, _omitFieldNames ? '' : 'sharedCount')
    ..pPS(9, _omitFieldNames ? '' : 'sharedTitles')
    ..aOB(10, _omitFieldNames ? '' : 'isPrivate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsFriend clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsFriend copyWith(void Function(StatsFriend) updates) =>
      super.copyWith((message) => updates(message as StatsFriend))
          as StatsFriend;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsFriend create() => StatsFriend._();
  @$core.override
  StatsFriend createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsFriend getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatsFriend>(create);
  static StatsFriend? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isMe => $_getBF(2);
  @$pb.TagNumber(3)
  set isMe($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsMe() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsMe() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get chapters30d => $_getI64(3);
  @$pb.TagNumber(4)
  set chapters30d($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChapters30d() => $_has(3);
  @$pb.TagNumber(4)
  void clearChapters30d() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get chaptersTotal => $_getI64(4);
  @$pb.TagNumber(5)
  set chaptersTotal($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChaptersTotal() => $_has(4);
  @$pb.TagNumber(5)
  void clearChaptersTotal() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get currentStreak => $_getIZ(5);
  @$pb.TagNumber(6)
  set currentStreak($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentStreak() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentStreak() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get longestStreak => $_getIZ(6);
  @$pb.TagNumber(7)
  set longestStreak($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLongestStreak() => $_has(6);
  @$pb.TagNumber(7)
  void clearLongestStreak() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get sharedCount => $_getI64(7);
  @$pb.TagNumber(8)
  set sharedCount($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSharedCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearSharedCount() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get sharedTitles => $_getList(8);

  /// A private user: everything but the username is left empty.
  @$pb.TagNumber(10)
  $core.bool get isPrivate => $_getBF(9);
  @$pb.TagNumber(10)
  set isPrivate($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPrivate() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPrivate() => $_clearField(10);
}

class StatsYear extends $pb.GeneratedMessage {
  factory StatsYear({
    $core.int? year,
    $fixnum.Int64? chapters,
    $fixnum.Int64? minutes,
    $fixnum.Int64? newSeries,
    $fixnum.Int64? finishedSeries,
    $fixnum.Int64? activeDays,
    StatsSeries? topSeries,
    $core.String? topGenre,
    $core.int? topMonth,
    $fixnum.Int64? topMonthChapters,
    $core.Iterable<$fixnum.Int64>? months,
  }) {
    final result = create();
    if (year != null) result.year = year;
    if (chapters != null) result.chapters = chapters;
    if (minutes != null) result.minutes = minutes;
    if (newSeries != null) result.newSeries = newSeries;
    if (finishedSeries != null) result.finishedSeries = finishedSeries;
    if (activeDays != null) result.activeDays = activeDays;
    if (topSeries != null) result.topSeries = topSeries;
    if (topGenre != null) result.topGenre = topGenre;
    if (topMonth != null) result.topMonth = topMonth;
    if (topMonthChapters != null) result.topMonthChapters = topMonthChapters;
    if (months != null) result.months.addAll(months);
    return result;
  }

  StatsYear._();

  factory StatsYear.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatsYear.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatsYear',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'year')
    ..aInt64(2, _omitFieldNames ? '' : 'chapters')
    ..aInt64(3, _omitFieldNames ? '' : 'minutes')
    ..aInt64(4, _omitFieldNames ? '' : 'newSeries')
    ..aInt64(5, _omitFieldNames ? '' : 'finishedSeries')
    ..aInt64(6, _omitFieldNames ? '' : 'activeDays')
    ..aOM<StatsSeries>(7, _omitFieldNames ? '' : 'topSeries',
        subBuilder: StatsSeries.create)
    ..aOS(8, _omitFieldNames ? '' : 'topGenre')
    ..aI(9, _omitFieldNames ? '' : 'topMonth')
    ..aInt64(10, _omitFieldNames ? '' : 'topMonthChapters')
    ..p<$fixnum.Int64>(11, _omitFieldNames ? '' : 'months', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsYear clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatsYear copyWith(void Function(StatsYear) updates) =>
      super.copyWith((message) => updates(message as StatsYear)) as StatsYear;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatsYear create() => StatsYear._();
  @$core.override
  StatsYear createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatsYear getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatsYear>(create);
  static StatsYear? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chapters => $_getI64(1);
  @$pb.TagNumber(2)
  set chapters($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChapters() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapters() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get minutes => $_getI64(2);
  @$pb.TagNumber(3)
  set minutes($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinutes() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get newSeries => $_getI64(3);
  @$pb.TagNumber(4)
  set newSeries($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewSeries() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewSeries() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get finishedSeries => $_getI64(4);
  @$pb.TagNumber(5)
  set finishedSeries($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFinishedSeries() => $_has(4);
  @$pb.TagNumber(5)
  void clearFinishedSeries() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get activeDays => $_getI64(5);
  @$pb.TagNumber(6)
  set activeDays($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasActiveDays() => $_has(5);
  @$pb.TagNumber(6)
  void clearActiveDays() => $_clearField(6);

  @$pb.TagNumber(7)
  StatsSeries get topSeries => $_getN(6);
  @$pb.TagNumber(7)
  set topSeries(StatsSeries value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTopSeries() => $_has(6);
  @$pb.TagNumber(7)
  void clearTopSeries() => $_clearField(7);
  @$pb.TagNumber(7)
  StatsSeries ensureTopSeries() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get topGenre => $_getSZ(7);
  @$pb.TagNumber(8)
  set topGenre($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTopGenre() => $_has(7);
  @$pb.TagNumber(8)
  void clearTopGenre() => $_clearField(8);

  /// 1-12, 0 when nothing was read this year.
  @$pb.TagNumber(9)
  $core.int get topMonth => $_getIZ(8);
  @$pb.TagNumber(9)
  set topMonth($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTopMonth() => $_has(8);
  @$pb.TagNumber(9)
  void clearTopMonth() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get topMonthChapters => $_getI64(9);
  @$pb.TagNumber(10)
  set topMonthChapters($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTopMonthChapters() => $_has(9);
  @$pb.TagNumber(10)
  void clearTopMonthChapters() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$fixnum.Int64> get months => $_getList(10);
}

class DetailedStatsReply extends $pb.GeneratedMessage {
  factory DetailedStatsReply({
    $fixnum.Int64? chaptersRead,
    $fixnum.Int64? chaptersOpened,
    $fixnum.Int64? pagesRead,
    $core.double? screensScrolled,
    $fixnum.Int64? minutesRead,
    $fixnum.Int64? seriesTotal,
    $fixnum.Int64? seriesCompleted,
    $fixnum.Int64? seriesInProgress,
    $fixnum.Int64? seriesNotStarted,
    $fixnum.Int64? seriesDropped,
    $fixnum.Int64? seriesOngoing,
    $fixnum.Int64? backlogChapters,
    $fixnum.Int64? libraryChapters,
    $core.double? minutesPerChapter,
    $core.Iterable<StatsDay>? days,
    $core.Iterable<$fixnum.Int64>? hours,
    $core.Iterable<$fixnum.Int64>? weekdays,
    $core.int? currentStreak,
    $core.int? longestStreak,
    $fixnum.Int64? sessions,
    $fixnum.Int64? longestSessionMinutes,
    StatsSeries? biggestBinge,
    $fixnum.Int64? firstReadAt,
    $fixnum.Int64? memberSince,
    $fixnum.Int64? chapters30d,
    $core.Iterable<StatsCount>? genres,
    $core.Iterable<StatsCount>? authors,
    $core.Iterable<StatsCount>? hosts,
    $core.Iterable<StatsCount>? languages,
    $core.Iterable<StatsSeries>? mostRead,
    $core.Iterable<StatsSeries>? recentlyFinished,
    $core.Iterable<StatsSeries>? abandoned,
    StatsSeries? fastestFinish,
    StatsSeries? longestRelationship,
    $core.Iterable<StatsSeries>? currentlyReading,
    $core.Iterable<StatsFriend>? friends,
    StatsYear? year,
  }) {
    final result = create();
    if (chaptersRead != null) result.chaptersRead = chaptersRead;
    if (chaptersOpened != null) result.chaptersOpened = chaptersOpened;
    if (pagesRead != null) result.pagesRead = pagesRead;
    if (screensScrolled != null) result.screensScrolled = screensScrolled;
    if (minutesRead != null) result.minutesRead = minutesRead;
    if (seriesTotal != null) result.seriesTotal = seriesTotal;
    if (seriesCompleted != null) result.seriesCompleted = seriesCompleted;
    if (seriesInProgress != null) result.seriesInProgress = seriesInProgress;
    if (seriesNotStarted != null) result.seriesNotStarted = seriesNotStarted;
    if (seriesDropped != null) result.seriesDropped = seriesDropped;
    if (seriesOngoing != null) result.seriesOngoing = seriesOngoing;
    if (backlogChapters != null) result.backlogChapters = backlogChapters;
    if (libraryChapters != null) result.libraryChapters = libraryChapters;
    if (minutesPerChapter != null) result.minutesPerChapter = minutesPerChapter;
    if (days != null) result.days.addAll(days);
    if (hours != null) result.hours.addAll(hours);
    if (weekdays != null) result.weekdays.addAll(weekdays);
    if (currentStreak != null) result.currentStreak = currentStreak;
    if (longestStreak != null) result.longestStreak = longestStreak;
    if (sessions != null) result.sessions = sessions;
    if (longestSessionMinutes != null)
      result.longestSessionMinutes = longestSessionMinutes;
    if (biggestBinge != null) result.biggestBinge = biggestBinge;
    if (firstReadAt != null) result.firstReadAt = firstReadAt;
    if (memberSince != null) result.memberSince = memberSince;
    if (chapters30d != null) result.chapters30d = chapters30d;
    if (genres != null) result.genres.addAll(genres);
    if (authors != null) result.authors.addAll(authors);
    if (hosts != null) result.hosts.addAll(hosts);
    if (languages != null) result.languages.addAll(languages);
    if (mostRead != null) result.mostRead.addAll(mostRead);
    if (recentlyFinished != null)
      result.recentlyFinished.addAll(recentlyFinished);
    if (abandoned != null) result.abandoned.addAll(abandoned);
    if (fastestFinish != null) result.fastestFinish = fastestFinish;
    if (longestRelationship != null)
      result.longestRelationship = longestRelationship;
    if (currentlyReading != null)
      result.currentlyReading.addAll(currentlyReading);
    if (friends != null) result.friends.addAll(friends);
    if (year != null) result.year = year;
    return result;
  }

  DetailedStatsReply._();

  factory DetailedStatsReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DetailedStatsReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DetailedStatsReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'chaptersRead')
    ..aInt64(2, _omitFieldNames ? '' : 'chaptersOpened')
    ..aInt64(3, _omitFieldNames ? '' : 'pagesRead')
    ..aD(4, _omitFieldNames ? '' : 'screensScrolled')
    ..aInt64(5, _omitFieldNames ? '' : 'minutesRead')
    ..aInt64(6, _omitFieldNames ? '' : 'seriesTotal')
    ..aInt64(7, _omitFieldNames ? '' : 'seriesCompleted')
    ..aInt64(8, _omitFieldNames ? '' : 'seriesInProgress')
    ..aInt64(9, _omitFieldNames ? '' : 'seriesNotStarted')
    ..aInt64(10, _omitFieldNames ? '' : 'seriesDropped')
    ..aInt64(11, _omitFieldNames ? '' : 'seriesOngoing')
    ..aInt64(12, _omitFieldNames ? '' : 'backlogChapters')
    ..aInt64(13, _omitFieldNames ? '' : 'libraryChapters')
    ..aD(14, _omitFieldNames ? '' : 'minutesPerChapter')
    ..pPM<StatsDay>(20, _omitFieldNames ? '' : 'days',
        subBuilder: StatsDay.create)
    ..p<$fixnum.Int64>(21, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.K6)
    ..p<$fixnum.Int64>(
        22, _omitFieldNames ? '' : 'weekdays', $pb.PbFieldType.K6)
    ..aI(23, _omitFieldNames ? '' : 'currentStreak')
    ..aI(24, _omitFieldNames ? '' : 'longestStreak')
    ..aInt64(25, _omitFieldNames ? '' : 'sessions')
    ..aInt64(26, _omitFieldNames ? '' : 'longestSessionMinutes')
    ..aOM<StatsSeries>(27, _omitFieldNames ? '' : 'biggestBinge',
        subBuilder: StatsSeries.create)
    ..aInt64(28, _omitFieldNames ? '' : 'firstReadAt')
    ..aInt64(29, _omitFieldNames ? '' : 'memberSince')
    ..aInt64(30, _omitFieldNames ? '' : 'chapters30d',
        protoName: 'chapters_30d')
    ..pPM<StatsCount>(40, _omitFieldNames ? '' : 'genres',
        subBuilder: StatsCount.create)
    ..pPM<StatsCount>(41, _omitFieldNames ? '' : 'authors',
        subBuilder: StatsCount.create)
    ..pPM<StatsCount>(42, _omitFieldNames ? '' : 'hosts',
        subBuilder: StatsCount.create)
    ..pPM<StatsCount>(43, _omitFieldNames ? '' : 'languages',
        subBuilder: StatsCount.create)
    ..pPM<StatsSeries>(50, _omitFieldNames ? '' : 'mostRead',
        subBuilder: StatsSeries.create)
    ..pPM<StatsSeries>(51, _omitFieldNames ? '' : 'recentlyFinished',
        subBuilder: StatsSeries.create)
    ..pPM<StatsSeries>(52, _omitFieldNames ? '' : 'abandoned',
        subBuilder: StatsSeries.create)
    ..aOM<StatsSeries>(53, _omitFieldNames ? '' : 'fastestFinish',
        subBuilder: StatsSeries.create)
    ..aOM<StatsSeries>(54, _omitFieldNames ? '' : 'longestRelationship',
        subBuilder: StatsSeries.create)
    ..pPM<StatsSeries>(55, _omitFieldNames ? '' : 'currentlyReading',
        subBuilder: StatsSeries.create)
    ..pPM<StatsFriend>(60, _omitFieldNames ? '' : 'friends',
        subBuilder: StatsFriend.create)
    ..aOM<StatsYear>(70, _omitFieldNames ? '' : 'year',
        subBuilder: StatsYear.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetailedStatsReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DetailedStatsReply copyWith(void Function(DetailedStatsReply) updates) =>
      super.copyWith((message) => updates(message as DetailedStatsReply))
          as DetailedStatsReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DetailedStatsReply create() => DetailedStatsReply._();
  @$core.override
  DetailedStatsReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DetailedStatsReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DetailedStatsReply>(create);
  static DetailedStatsReply? _defaultInstance;

  /// Sum of reading progress.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chaptersRead => $_getI64(0);
  @$pb.TagNumber(1)
  set chaptersRead($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChaptersRead() => $_has(0);
  @$pb.TagNumber(1)
  void clearChaptersRead() => $_clearField(1);

  /// Chapters the reader actually opened (one per chapter, rereads included once).
  @$pb.TagNumber(2)
  $fixnum.Int64 get chaptersOpened => $_getI64(1);
  @$pb.TagNumber(2)
  set chaptersOpened($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChaptersOpened() => $_has(1);
  @$pb.TagNumber(2)
  void clearChaptersOpened() => $_clearField(2);

  /// `chapters_read` times each series' average pages per chapter.
  @$pb.TagNumber(3)
  $fixnum.Int64 get pagesRead => $_getI64(2);
  @$pb.TagNumber(3)
  set pagesRead($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPagesRead() => $_has(2);
  @$pb.TagNumber(3)
  void clearPagesRead() => $_clearField(3);

  /// Same, summing each page's height/width: multiply by a screen width for a distance.
  @$pb.TagNumber(4)
  $core.double get screensScrolled => $_getN(3);
  @$pb.TagNumber(4)
  set screensScrolled($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScreensScrolled() => $_has(3);
  @$pb.TagNumber(4)
  void clearScreensScrolled() => $_clearField(4);

  /// `chapters_read` at the pace measured from when chapters were opened and last scrolled.
  @$pb.TagNumber(5)
  $fixnum.Int64 get minutesRead => $_getI64(4);
  @$pb.TagNumber(5)
  set minutesRead($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMinutesRead() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinutesRead() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get seriesTotal => $_getI64(5);
  @$pb.TagNumber(6)
  set seriesTotal($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSeriesTotal() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeriesTotal() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get seriesCompleted => $_getI64(6);
  @$pb.TagNumber(7)
  set seriesCompleted($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSeriesCompleted() => $_has(6);
  @$pb.TagNumber(7)
  void clearSeriesCompleted() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get seriesInProgress => $_getI64(7);
  @$pb.TagNumber(8)
  set seriesInProgress($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSeriesInProgress() => $_has(7);
  @$pb.TagNumber(8)
  void clearSeriesInProgress() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get seriesNotStarted => $_getI64(8);
  @$pb.TagNumber(9)
  set seriesNotStarted($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSeriesNotStarted() => $_has(8);
  @$pb.TagNumber(9)
  void clearSeriesNotStarted() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get seriesDropped => $_getI64(9);
  @$pb.TagNumber(10)
  set seriesDropped($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSeriesDropped() => $_has(9);
  @$pb.TagNumber(10)
  void clearSeriesDropped() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get seriesOngoing => $_getI64(10);
  @$pb.TagNumber(11)
  set seriesOngoing($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSeriesOngoing() => $_has(10);
  @$pb.TagNumber(11)
  void clearSeriesOngoing() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get backlogChapters => $_getI64(11);
  @$pb.TagNumber(12)
  set backlogChapters($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBacklogChapters() => $_has(11);
  @$pb.TagNumber(12)
  void clearBacklogChapters() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get libraryChapters => $_getI64(12);
  @$pb.TagNumber(13)
  set libraryChapters($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLibraryChapters() => $_has(12);
  @$pb.TagNumber(13)
  void clearLibraryChapters() => $_clearField(13);

  /// The user's typical minutes per chapter that `minutes_read` is based on.
  @$pb.TagNumber(14)
  $core.double get minutesPerChapter => $_getN(13);
  @$pb.TagNumber(14)
  set minutesPerChapter($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasMinutesPerChapter() => $_has(13);
  @$pb.TagNumber(14)
  void clearMinutesPerChapter() => $_clearField(14);

  @$pb.TagNumber(20)
  $pb.PbList<StatsDay> get days => $_getList(14);

  /// 24 entries, local hour of day.
  @$pb.TagNumber(21)
  $pb.PbList<$fixnum.Int64> get hours => $_getList(15);

  /// 7 entries, Monday first.
  @$pb.TagNumber(22)
  $pb.PbList<$fixnum.Int64> get weekdays => $_getList(16);

  @$pb.TagNumber(23)
  $core.int get currentStreak => $_getIZ(17);
  @$pb.TagNumber(23)
  set currentStreak($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(23)
  $core.bool hasCurrentStreak() => $_has(17);
  @$pb.TagNumber(23)
  void clearCurrentStreak() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.int get longestStreak => $_getIZ(18);
  @$pb.TagNumber(24)
  set longestStreak($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(24)
  $core.bool hasLongestStreak() => $_has(18);
  @$pb.TagNumber(24)
  void clearLongestStreak() => $_clearField(24);

  @$pb.TagNumber(25)
  $fixnum.Int64 get sessions => $_getI64(19);
  @$pb.TagNumber(25)
  set sessions($fixnum.Int64 value) => $_setInt64(19, value);
  @$pb.TagNumber(25)
  $core.bool hasSessions() => $_has(19);
  @$pb.TagNumber(25)
  void clearSessions() => $_clearField(25);

  @$pb.TagNumber(26)
  $fixnum.Int64 get longestSessionMinutes => $_getI64(20);
  @$pb.TagNumber(26)
  set longestSessionMinutes($fixnum.Int64 value) => $_setInt64(20, value);
  @$pb.TagNumber(26)
  $core.bool hasLongestSessionMinutes() => $_has(20);
  @$pb.TagNumber(26)
  void clearLongestSessionMinutes() => $_clearField(26);

  /// The day with the most chapters opened: amount = chapters, at = that day.
  @$pb.TagNumber(27)
  StatsSeries get biggestBinge => $_getN(21);
  @$pb.TagNumber(27)
  set biggestBinge(StatsSeries value) => $_setField(27, value);
  @$pb.TagNumber(27)
  $core.bool hasBiggestBinge() => $_has(21);
  @$pb.TagNumber(27)
  void clearBiggestBinge() => $_clearField(27);
  @$pb.TagNumber(27)
  StatsSeries ensureBiggestBinge() => $_ensure(21);

  @$pb.TagNumber(28)
  $fixnum.Int64 get firstReadAt => $_getI64(22);
  @$pb.TagNumber(28)
  set firstReadAt($fixnum.Int64 value) => $_setInt64(22, value);
  @$pb.TagNumber(28)
  $core.bool hasFirstReadAt() => $_has(22);
  @$pb.TagNumber(28)
  void clearFirstReadAt() => $_clearField(28);

  @$pb.TagNumber(29)
  $fixnum.Int64 get memberSince => $_getI64(23);
  @$pb.TagNumber(29)
  set memberSince($fixnum.Int64 value) => $_setInt64(23, value);
  @$pb.TagNumber(29)
  $core.bool hasMemberSince() => $_has(23);
  @$pb.TagNumber(29)
  void clearMemberSince() => $_clearField(29);

  @$pb.TagNumber(30)
  $fixnum.Int64 get chapters30d => $_getI64(24);
  @$pb.TagNumber(30)
  set chapters30d($fixnum.Int64 value) => $_setInt64(24, value);
  @$pb.TagNumber(30)
  $core.bool hasChapters30d() => $_has(24);
  @$pb.TagNumber(30)
  void clearChapters30d() => $_clearField(30);

  @$pb.TagNumber(40)
  $pb.PbList<StatsCount> get genres => $_getList(25);

  @$pb.TagNumber(41)
  $pb.PbList<StatsCount> get authors => $_getList(26);

  @$pb.TagNumber(42)
  $pb.PbList<StatsCount> get hosts => $_getList(27);

  @$pb.TagNumber(43)
  $pb.PbList<StatsCount> get languages => $_getList(28);

  @$pb.TagNumber(50)
  $pb.PbList<StatsSeries> get mostRead => $_getList(29);

  @$pb.TagNumber(51)
  $pb.PbList<StatsSeries> get recentlyFinished => $_getList(30);

  @$pb.TagNumber(52)
  $pb.PbList<StatsSeries> get abandoned => $_getList(31);

  @$pb.TagNumber(53)
  StatsSeries get fastestFinish => $_getN(32);
  @$pb.TagNumber(53)
  set fastestFinish(StatsSeries value) => $_setField(53, value);
  @$pb.TagNumber(53)
  $core.bool hasFastestFinish() => $_has(32);
  @$pb.TagNumber(53)
  void clearFastestFinish() => $_clearField(53);
  @$pb.TagNumber(53)
  StatsSeries ensureFastestFinish() => $_ensure(32);

  @$pb.TagNumber(54)
  StatsSeries get longestRelationship => $_getN(33);
  @$pb.TagNumber(54)
  set longestRelationship(StatsSeries value) => $_setField(54, value);
  @$pb.TagNumber(54)
  $core.bool hasLongestRelationship() => $_has(33);
  @$pb.TagNumber(54)
  void clearLongestRelationship() => $_clearField(54);
  @$pb.TagNumber(54)
  StatsSeries ensureLongestRelationship() => $_ensure(33);

  /// Unfinished series with progress, most recently read first: amount = progress, at = last read.
  @$pb.TagNumber(55)
  $pb.PbList<StatsSeries> get currentlyReading => $_getList(34);

  @$pb.TagNumber(60)
  $pb.PbList<StatsFriend> get friends => $_getList(35);

  @$pb.TagNumber(70)
  StatsYear get year => $_getN(36);
  @$pb.TagNumber(70)
  set year(StatsYear value) => $_setField(70, value);
  @$pb.TagNumber(70)
  $core.bool hasYear() => $_has(36);
  @$pb.TagNumber(70)
  void clearYear() => $_clearField(70);
  @$pb.TagNumber(70)
  StatsYear ensureYear() => $_ensure(36);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
