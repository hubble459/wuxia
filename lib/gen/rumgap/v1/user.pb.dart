// This is a generated file - do not edit.
//
// Generated from rumgap/v1/user.proto.

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

class UserRegisterRequest extends $pb.GeneratedMessage {
  factory UserRegisterRequest({
    $core.String? username,
    $core.String? password,
    $core.String? email,
  }) {
    final result = create();
    if (username != null) result.username = username;
    if (password != null) result.password = password;
    if (email != null) result.email = email;
    return result;
  }

  UserRegisterRequest._();

  factory UserRegisterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRegisterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRegisterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRegisterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRegisterRequest copyWith(void Function(UserRegisterRequest) updates) =>
      super.copyWith((message) => updates(message as UserRegisterRequest))
          as UserRegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRegisterRequest create() => UserRegisterRequest._();
  @$core.override
  UserRegisterRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserRegisterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRegisterRequest>(create);
  static UserRegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
}

class DeviceTokenRequest extends $pb.GeneratedMessage {
  factory DeviceTokenRequest({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  DeviceTokenRequest._();

  factory DeviceTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeviceTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeviceTokenRequest copyWith(void Function(DeviceTokenRequest) updates) =>
      super.copyWith((message) => updates(message as DeviceTokenRequest))
          as DeviceTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceTokenRequest create() => DeviceTokenRequest._();
  @$core.override
  DeviceTokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeviceTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceTokenRequest>(create);
  static DeviceTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

enum UserRequest_Identifier { username, email, notSet }

class UserRequest extends $pb.GeneratedMessage {
  factory UserRequest({
    $core.String? password,
    $core.String? username,
    $core.String? email,
  }) {
    final result = create();
    if (password != null) result.password = password;
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    return result;
  }

  UserRequest._();

  factory UserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UserRequest_Identifier>
      _UserRequest_IdentifierByTag = {
    2: UserRequest_Identifier.username,
    3: UserRequest_Identifier.email,
    0: UserRequest_Identifier.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'password')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRequest copyWith(void Function(UserRequest) updates) =>
      super.copyWith((message) => updates(message as UserRequest))
          as UserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRequest create() => UserRequest._();
  @$core.override
  UserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRequest>(create);
  static UserRequest? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  UserRequest_Identifier whichIdentifier() =>
      _UserRequest_IdentifierByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearIdentifier() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get password => $_getSZ(0);
  @$pb.TagNumber(1)
  set password($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassword() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);
}

class UserUpdateRequest extends $pb.GeneratedMessage {
  factory UserUpdateRequest({
    $core.String? password,
    $core.String? username,
    $core.String? email,
    $core.Iterable<$core.String>? preferredHostnames,
    $core.Iterable<$core.String>? deviceIds,
  }) {
    final result = create();
    if (password != null) result.password = password;
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    if (preferredHostnames != null)
      result.preferredHostnames.addAll(preferredHostnames);
    if (deviceIds != null) result.deviceIds.addAll(deviceIds);
    return result;
  }

  UserUpdateRequest._();

  factory UserUpdateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserUpdateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'password')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..pPS(4, _omitFieldNames ? '' : 'preferredHostnames')
    ..pPS(5, _omitFieldNames ? '' : 'deviceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdateRequest copyWith(void Function(UserUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as UserUpdateRequest))
          as UserUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserUpdateRequest create() => UserUpdateRequest._();
  @$core.override
  UserUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserUpdateRequest>(create);
  static UserUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get password => $_getSZ(0);
  @$pb.TagNumber(1)
  set password($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassword() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get preferredHostnames => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get deviceIds => $_getList(4);
}

class UserReply extends $pb.GeneratedMessage {
  factory UserReply({
    $core.int? id,
    $core.String? username,
    $core.String? email,
    $core.int? permissions,
    $core.Iterable<$core.String>? preferredHostnames,
    $core.Iterable<$core.String>? deviceIds,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    if (permissions != null) result.permissions = permissions;
    if (preferredHostnames != null)
      result.preferredHostnames.addAll(preferredHostnames);
    if (deviceIds != null) result.deviceIds.addAll(deviceIds);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UserReply._();

  factory UserReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aI(4, _omitFieldNames ? '' : 'permissions')
    ..pPS(5, _omitFieldNames ? '' : 'preferredHostnames')
    ..pPS(6, _omitFieldNames ? '' : 'deviceIds')
    ..aInt64(7, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(8, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserReply copyWith(void Function(UserReply) updates) =>
      super.copyWith((message) => updates(message as UserReply)) as UserReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserReply create() => UserReply._();
  @$core.override
  UserReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserReply getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserReply>(create);
  static UserReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get permissions => $_getIZ(3);
  @$pb.TagNumber(4)
  set permissions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPermissions() => $_has(3);
  @$pb.TagNumber(4)
  void clearPermissions() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get preferredHostnames => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get deviceIds => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get updatedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set updatedAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => $_clearField(8);
}

class UserFullReply extends $pb.GeneratedMessage {
  factory UserFullReply({
    $core.int? id,
    $core.String? username,
    $core.String? email,
    $core.int? permissions,
    $core.Iterable<$core.String>? preferredHostnames,
    $core.Iterable<$core.String>? deviceIds,
    $fixnum.Int64? countFollowing,
    $fixnum.Int64? countFollowers,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (email != null) result.email = email;
    if (permissions != null) result.permissions = permissions;
    if (preferredHostnames != null)
      result.preferredHostnames.addAll(preferredHostnames);
    if (deviceIds != null) result.deviceIds.addAll(deviceIds);
    if (countFollowing != null) result.countFollowing = countFollowing;
    if (countFollowers != null) result.countFollowers = countFollowers;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UserFullReply._();

  factory UserFullReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFullReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFullReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aI(4, _omitFieldNames ? '' : 'permissions')
    ..pPS(5, _omitFieldNames ? '' : 'preferredHostnames')
    ..pPS(6, _omitFieldNames ? '' : 'deviceIds')
    ..aInt64(7, _omitFieldNames ? '' : 'countFollowing')
    ..aInt64(8, _omitFieldNames ? '' : 'countFollowers')
    ..aInt64(9, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFullReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFullReply copyWith(void Function(UserFullReply) updates) =>
      super.copyWith((message) => updates(message as UserFullReply))
          as UserFullReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFullReply create() => UserFullReply._();
  @$core.override
  UserFullReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserFullReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFullReply>(create);
  static UserFullReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get permissions => $_getIZ(3);
  @$pb.TagNumber(4)
  set permissions($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPermissions() => $_has(3);
  @$pb.TagNumber(4)
  void clearPermissions() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get preferredHostnames => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get deviceIds => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get countFollowing => $_getI64(6);
  @$pb.TagNumber(7)
  set countFollowing($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCountFollowing() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountFollowing() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get countFollowers => $_getI64(7);
  @$pb.TagNumber(8)
  set countFollowers($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCountFollowers() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountFollowers() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get createdAt => $_getI64(8);
  @$pb.TagNumber(9)
  set createdAt($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get updatedAt => $_getI64(9);
  @$pb.TagNumber(10)
  set updatedAt($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
}

class UserTokenReply extends $pb.GeneratedMessage {
  factory UserTokenReply({
    UserFullReply? user,
    $core.String? token,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (token != null) result.token = token;
    return result;
  }

  UserTokenReply._();

  factory UserTokenReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserTokenReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserTokenReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<UserFullReply>(1, _omitFieldNames ? '' : 'user',
        subBuilder: UserFullReply.create)
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTokenReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserTokenReply copyWith(void Function(UserTokenReply) updates) =>
      super.copyWith((message) => updates(message as UserTokenReply))
          as UserTokenReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserTokenReply create() => UserTokenReply._();
  @$core.override
  UserTokenReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserTokenReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserTokenReply>(create);
  static UserTokenReply? _defaultInstance;

  @$pb.TagNumber(1)
  UserFullReply get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(UserFullReply value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  UserFullReply ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);
}

class UsersReply extends $pb.GeneratedMessage {
  factory UsersReply({
    $0.PaginateReply? pagination,
    $core.Iterable<UserReply>? items,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (items != null) result.items.addAll(items);
    return result;
  }

  UsersReply._();

  factory UsersReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UsersReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UsersReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<$0.PaginateReply>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginateReply.create)
    ..pPM<UserReply>(2, _omitFieldNames ? '' : 'items',
        subBuilder: UserReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UsersReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UsersReply copyWith(void Function(UsersReply) updates) =>
      super.copyWith((message) => updates(message as UsersReply)) as UsersReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UsersReply create() => UsersReply._();
  @$core.override
  UsersReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UsersReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UsersReply>(create);
  static UsersReply? _defaultInstance;

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
  $pb.PbList<UserReply> get items => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
