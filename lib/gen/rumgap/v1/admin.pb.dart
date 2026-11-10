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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
