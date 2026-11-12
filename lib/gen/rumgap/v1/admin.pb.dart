// This is a generated file - do not edit.
//
// Generated from rumgap/v1/admin.proto.

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

class AdminCreateUserRequest extends $pb.GeneratedMessage {
  factory AdminCreateUserRequest({
    $core.String? username,
    $core.String? email,
    $core.String? password,
    $core.bool? admin,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    if (admin != null) result.admin = admin;
    return result;
  }

  AdminCreateUserRequest._();

  factory AdminCreateUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminCreateUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminCreateUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..aOB(4, _omitFieldNames ? '' : 'admin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateUserRequest copyWith(
          void Function(AdminCreateUserRequest) updates) =>
      super.copyWith((message) => updates(message as AdminCreateUserRequest))
          as AdminCreateUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCreateUserRequest create() => AdminCreateUserRequest._();
  @$core.override
  AdminCreateUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminCreateUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminCreateUserRequest>(create);
  static AdminCreateUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => $_clearField(3);

  /// Also grant ADMIN on top of USER.
  @$pb.TagNumber(4)
  $core.bool get admin => $_getBF(3);
  @$pb.TagNumber(4)
  set admin($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdmin() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdmin() => $_clearField(4);
}

class AdminDeleteUserRequest extends $pb.GeneratedMessage {
  factory AdminDeleteUserRequest({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  AdminDeleteUserRequest._();

  factory AdminDeleteUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminDeleteUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminDeleteUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteUserRequest copyWith(
          void Function(AdminDeleteUserRequest) updates) =>
      super.copyWith((message) => updates(message as AdminDeleteUserRequest))
          as AdminDeleteUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminDeleteUserRequest create() => AdminDeleteUserRequest._();
  @$core.override
  AdminDeleteUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminDeleteUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminDeleteUserRequest>(create);
  static AdminDeleteUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class AdminSetPasswordRequest extends $pb.GeneratedMessage {
  factory AdminSetPasswordRequest({
    $core.int? id,
    $core.String? password,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (password != null) result.password = password;
    return result;
  }

  AdminSetPasswordRequest._();

  factory AdminSetPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminSetPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminSetPasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetPasswordRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminSetPasswordRequest copyWith(
          void Function(AdminSetPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as AdminSetPasswordRequest))
          as AdminSetPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminSetPasswordRequest create() => AdminSetPasswordRequest._();
  @$core.override
  AdminSetPasswordRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminSetPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminSetPasswordRequest>(create);
  static AdminSetPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class StorageBucket extends $pb.GeneratedMessage {
  factory StorageBucket({
    $core.String? name,
    $fixnum.Int64? bytes,
    $fixnum.Int64? files,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (bytes != null) result.bytes = bytes;
    if (files != null) result.files = files;
    return result;
  }

  StorageBucket._();

  factory StorageBucket.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StorageBucket.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StorageBucket',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'bytes')
    ..aInt64(3, _omitFieldNames ? '' : 'files')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageBucket clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageBucket copyWith(void Function(StorageBucket) updates) =>
      super.copyWith((message) => updates(message as StorageBucket))
          as StorageBucket;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageBucket create() => StorageBucket._();
  @$core.override
  StorageBucket createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StorageBucket getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StorageBucket>(create);
  static StorageBucket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get bytes => $_getI64(1);
  @$pb.TagNumber(2)
  set bytes($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBytes() => $_has(1);
  @$pb.TagNumber(2)
  void clearBytes() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get files => $_getI64(2);
  @$pb.TagNumber(3)
  set files($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFiles() => $_has(2);
  @$pb.TagNumber(3)
  void clearFiles() => $_clearField(3);
}

class StorageGroup extends $pb.GeneratedMessage {
  factory StorageGroup({
    $core.String? key,
    $core.String? title,
    $core.String? cover,
    $fixnum.Int64? bytes,
    $fixnum.Int64? pages,
    $fixnum.Int64? chapters,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (title != null) result.title = title;
    if (cover != null) result.cover = cover;
    if (bytes != null) result.bytes = bytes;
    if (pages != null) result.pages = pages;
    if (chapters != null) result.chapters = chapters;
    return result;
  }

  StorageGroup._();

  factory StorageGroup.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StorageGroup.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StorageGroup',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'cover')
    ..aInt64(4, _omitFieldNames ? '' : 'bytes')
    ..aInt64(5, _omitFieldNames ? '' : 'pages')
    ..aInt64(6, _omitFieldNames ? '' : 'chapters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageGroup clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageGroup copyWith(void Function(StorageGroup) updates) =>
      super.copyWith((message) => updates(message as StorageGroup))
          as StorageGroup;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageGroup create() => StorageGroup._();
  @$core.override
  StorageGroup createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StorageGroup getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StorageGroup>(create);
  static StorageGroup? _defaultInstance;

  /// Hostname, or the manga's id as text.
  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

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
  $fixnum.Int64 get bytes => $_getI64(3);
  @$pb.TagNumber(4)
  set bytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearBytes() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get pages => $_getI64(4);
  @$pb.TagNumber(5)
  set pages($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearPages() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get chapters => $_getI64(5);
  @$pb.TagNumber(6)
  set chapters($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasChapters() => $_has(5);
  @$pb.TagNumber(6)
  void clearChapters() => $_clearField(6);
}

class StorageReply extends $pb.GeneratedMessage {
  factory StorageReply({
    $fixnum.Int64? diskBytes,
    $fixnum.Int64? diskFiles,
    $core.Iterable<StorageBucket>? disk,
    $fixnum.Int64? databaseBytes,
    $core.Iterable<StorageBucket>? tables,
    $fixnum.Int64? volumeTotalBytes,
    $fixnum.Int64? volumeFreeBytes,
    $core.Iterable<StorageGroup>? hosts,
    $core.Iterable<StorageGroup>? manga,
    $fixnum.Int64? pagesStored,
    $fixnum.Int64? pagesPending,
    $fixnum.Int64? pagesFailed,
    $fixnum.Int64? measuredAt,
    $fixnum.Int64? scanMillis,
  }) {
    final result = create();
    if (diskBytes != null) result.diskBytes = diskBytes;
    if (diskFiles != null) result.diskFiles = diskFiles;
    if (disk != null) result.disk.addAll(disk);
    if (databaseBytes != null) result.databaseBytes = databaseBytes;
    if (tables != null) result.tables.addAll(tables);
    if (volumeTotalBytes != null) result.volumeTotalBytes = volumeTotalBytes;
    if (volumeFreeBytes != null) result.volumeFreeBytes = volumeFreeBytes;
    if (hosts != null) result.hosts.addAll(hosts);
    if (manga != null) result.manga.addAll(manga);
    if (pagesStored != null) result.pagesStored = pagesStored;
    if (pagesPending != null) result.pagesPending = pagesPending;
    if (pagesFailed != null) result.pagesFailed = pagesFailed;
    if (measuredAt != null) result.measuredAt = measuredAt;
    if (scanMillis != null) result.scanMillis = scanMillis;
    return result;
  }

  StorageReply._();

  factory StorageReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StorageReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StorageReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'diskBytes')
    ..aInt64(2, _omitFieldNames ? '' : 'diskFiles')
    ..pPM<StorageBucket>(3, _omitFieldNames ? '' : 'disk',
        subBuilder: StorageBucket.create)
    ..aInt64(4, _omitFieldNames ? '' : 'databaseBytes')
    ..pPM<StorageBucket>(5, _omitFieldNames ? '' : 'tables',
        subBuilder: StorageBucket.create)
    ..aInt64(6, _omitFieldNames ? '' : 'volumeTotalBytes')
    ..aInt64(7, _omitFieldNames ? '' : 'volumeFreeBytes')
    ..pPM<StorageGroup>(8, _omitFieldNames ? '' : 'hosts',
        subBuilder: StorageGroup.create)
    ..pPM<StorageGroup>(9, _omitFieldNames ? '' : 'manga',
        subBuilder: StorageGroup.create)
    ..aInt64(10, _omitFieldNames ? '' : 'pagesStored')
    ..aInt64(11, _omitFieldNames ? '' : 'pagesPending')
    ..aInt64(12, _omitFieldNames ? '' : 'pagesFailed')
    ..aInt64(13, _omitFieldNames ? '' : 'measuredAt')
    ..aInt64(14, _omitFieldNames ? '' : 'scanMillis')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageReply copyWith(void Function(StorageReply) updates) =>
      super.copyWith((message) => updates(message as StorageReply))
          as StorageReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageReply create() => StorageReply._();
  @$core.override
  StorageReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StorageReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StorageReply>(create);
  static StorageReply? _defaultInstance;

  /// Everything under IMAGE_STORAGE_PATH, split into pages, resized copies, covers and other.
  @$pb.TagNumber(1)
  $fixnum.Int64 get diskBytes => $_getI64(0);
  @$pb.TagNumber(1)
  set diskBytes($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDiskBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearDiskBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get diskFiles => $_getI64(1);
  @$pb.TagNumber(2)
  set diskFiles($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDiskFiles() => $_has(1);
  @$pb.TagNumber(2)
  void clearDiskFiles() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<StorageBucket> get disk => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get databaseBytes => $_getI64(3);
  @$pb.TagNumber(4)
  set databaseBytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDatabaseBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearDatabaseBytes() => $_clearField(4);

  /// Biggest tables, indexes included.
  @$pb.TagNumber(5)
  $pb.PbList<StorageBucket> get tables => $_getList(4);

  /// The volume IMAGE_STORAGE_PATH lives on, when the platform can tell.
  @$pb.TagNumber(6)
  $fixnum.Int64 get volumeTotalBytes => $_getI64(5);
  @$pb.TagNumber(6)
  set volumeTotalBytes($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVolumeTotalBytes() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolumeTotalBytes() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get volumeFreeBytes => $_getI64(6);
  @$pb.TagNumber(7)
  set volumeFreeBytes($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVolumeFreeBytes() => $_has(6);
  @$pb.TagNumber(7)
  void clearVolumeFreeBytes() => $_clearField(7);

  /// Stored page images per source site and the manga taking the most, from chapter_image.
  @$pb.TagNumber(8)
  $pb.PbList<StorageGroup> get hosts => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<StorageGroup> get manga => $_getList(8);

  @$pb.TagNumber(10)
  $fixnum.Int64 get pagesStored => $_getI64(9);
  @$pb.TagNumber(10)
  set pagesStored($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPagesStored() => $_has(9);
  @$pb.TagNumber(10)
  void clearPagesStored() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get pagesPending => $_getI64(10);
  @$pb.TagNumber(11)
  set pagesPending($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPagesPending() => $_has(10);
  @$pb.TagNumber(11)
  void clearPagesPending() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get pagesFailed => $_getI64(11);
  @$pb.TagNumber(12)
  set pagesFailed($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPagesFailed() => $_has(11);
  @$pb.TagNumber(12)
  void clearPagesFailed() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get measuredAt => $_getI64(12);
  @$pb.TagNumber(13)
  set measuredAt($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasMeasuredAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearMeasuredAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get scanMillis => $_getI64(13);
  @$pb.TagNumber(14)
  set scanMillis($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasScanMillis() => $_has(13);
  @$pb.TagNumber(14)
  void clearScanMillis() => $_clearField(14);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
