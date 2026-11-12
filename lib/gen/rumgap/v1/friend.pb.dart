// This is a generated file - do not edit.
//
// Generated from rumgap/v1/friend.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'meta.pb.dart' as $1;
import 'paginate.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FriendRequest extends $pb.GeneratedMessage {
  factory FriendRequest({
    $core.int? userId,
    $core.String? username,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    return result;
  }

  FriendRequest._();

  factory FriendRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FriendRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FriendRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendRequest copyWith(void Function(FriendRequest) updates) =>
      super.copyWith((message) => updates(message as FriendRequest))
          as FriendRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendRequest create() => FriendRequest._();
  @$core.override
  FriendRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FriendRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FriendRequest>(create);
  static FriendRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get userId => $_getIZ(0);
  @$pb.TagNumber(1)
  set userId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  /// Takes precedence over `user_id`: users are found by their exact username only.
  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);
}

/// What any user may know about another user.
class UserSummary extends $pb.GeneratedMessage {
  factory UserSummary({
    $core.int? id,
    $core.String? username,
    $core.bool? isPrivate,
    $core.bool? followedByMe,
    $core.bool? followsMe,
    $fixnum.Int64? since,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (isPrivate != null) result.isPrivate = isPrivate;
    if (followedByMe != null) result.followedByMe = followedByMe;
    if (followsMe != null) result.followsMe = followsMe;
    if (since != null) result.since = since;
    return result;
  }

  UserSummary._();

  factory UserSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOB(3, _omitFieldNames ? '' : 'isPrivate')
    ..aOB(4, _omitFieldNames ? '' : 'followedByMe')
    ..aOB(5, _omitFieldNames ? '' : 'followsMe')
    ..aInt64(6, _omitFieldNames ? '' : 'since')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummary copyWith(void Function(UserSummary) updates) =>
      super.copyWith((message) => updates(message as UserSummary))
          as UserSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSummary create() => UserSummary._();
  @$core.override
  UserSummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSummary>(create);
  static UserSummary? _defaultInstance;

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
  $core.bool get isPrivate => $_getBF(2);
  @$pb.TagNumber(3)
  set isPrivate($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsPrivate() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsPrivate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get followedByMe => $_getBF(3);
  @$pb.TagNumber(4)
  set followedByMe($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFollowedByMe() => $_has(3);
  @$pb.TagNumber(4)
  void clearFollowedByMe() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get followsMe => $_getBF(4);
  @$pb.TagNumber(5)
  set followsMe($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFollowsMe() => $_has(4);
  @$pb.TagNumber(5)
  void clearFollowsMe() => $_clearField(5);

  /// Epoch millis the listed follow started, 0 outside a following/followers list.
  @$pb.TagNumber(6)
  $fixnum.Int64 get since => $_getI64(5);
  @$pb.TagNumber(6)
  set since($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSince() => $_has(5);
  @$pb.TagNumber(6)
  void clearSince() => $_clearField(6);
}

class UserSummariesReply extends $pb.GeneratedMessage {
  factory UserSummariesReply({
    $0.PaginateReply? pagination,
    $core.Iterable<UserSummary>? items,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (items != null) result.items.addAll(items);
    return result;
  }

  UserSummariesReply._();

  factory UserSummariesReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSummariesReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSummariesReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<$0.PaginateReply>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginateReply.create)
    ..pPM<UserSummary>(2, _omitFieldNames ? '' : 'items',
        subBuilder: UserSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummariesReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummariesReply copyWith(void Function(UserSummariesReply) updates) =>
      super.copyWith((message) => updates(message as UserSummariesReply))
          as UserSummariesReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSummariesReply create() => UserSummariesReply._();
  @$core.override
  UserSummariesReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserSummariesReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSummariesReply>(create);
  static UserSummariesReply? _defaultInstance;

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
  $pb.PbList<UserSummary> get items => $_getList(1);
}

enum ProfileRequest_User { userId, username, notSet }

class ProfileRequest extends $pb.GeneratedMessage {
  factory ProfileRequest({
    $core.int? userId,
    $core.String? username,
    $core.int? utcOffsetMinutes,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (utcOffsetMinutes != null) result.utcOffsetMinutes = utcOffsetMinutes;
    return result;
  }

  ProfileRequest._();

  factory ProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ProfileRequest_User>
      _ProfileRequest_UserByTag = {
    1: ProfileRequest_User.userId,
    2: ProfileRequest_User.username,
    0: ProfileRequest_User.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aI(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aI(3, _omitFieldNames ? '' : 'utcOffsetMinutes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileRequest copyWith(void Function(ProfileRequest) updates) =>
      super.copyWith((message) => updates(message as ProfileRequest))
          as ProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileRequest create() => ProfileRequest._();
  @$core.override
  ProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileRequest>(create);
  static ProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  ProfileRequest_User whichUser() =>
      _ProfileRequest_UserByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearUser() => $_clearField($_whichOneof(0));

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

  /// Minutes to add to UTC for the viewer's local time, as in `DetailedStatsRequest`.
  @$pb.TagNumber(3)
  $core.int get utcOffsetMinutes => $_getIZ(2);
  @$pb.TagNumber(3)
  set utcOffsetMinutes($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUtcOffsetMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearUtcOffsetMinutes() => $_clearField(3);
}

class ProfileReply extends $pb.GeneratedMessage {
  factory ProfileReply({
    UserSummary? user,
    $fixnum.Int64? countFollowing,
    $fixnum.Int64? countFollowers,
    $fixnum.Int64? memberSince,
    $core.bool? isMe,
    $core.bool? visible,
    $1.DetailedStatsReply? stats,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (countFollowing != null) result.countFollowing = countFollowing;
    if (countFollowers != null) result.countFollowers = countFollowers;
    if (memberSince != null) result.memberSince = memberSince;
    if (isMe != null) result.isMe = isMe;
    if (visible != null) result.visible = visible;
    if (stats != null) result.stats = stats;
    return result;
  }

  ProfileReply._();

  factory ProfileReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProfileReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProfileReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<UserSummary>(1, _omitFieldNames ? '' : 'user',
        subBuilder: UserSummary.create)
    ..aInt64(2, _omitFieldNames ? '' : 'countFollowing')
    ..aInt64(3, _omitFieldNames ? '' : 'countFollowers')
    ..aInt64(4, _omitFieldNames ? '' : 'memberSince')
    ..aOB(5, _omitFieldNames ? '' : 'isMe')
    ..aOB(6, _omitFieldNames ? '' : 'visible')
    ..aOM<$1.DetailedStatsReply>(7, _omitFieldNames ? '' : 'stats',
        subBuilder: $1.DetailedStatsReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProfileReply copyWith(void Function(ProfileReply) updates) =>
      super.copyWith((message) => updates(message as ProfileReply))
          as ProfileReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProfileReply create() => ProfileReply._();
  @$core.override
  ProfileReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProfileReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProfileReply>(create);
  static ProfileReply? _defaultInstance;

  @$pb.TagNumber(1)
  UserSummary get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(UserSummary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  UserSummary ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get countFollowing => $_getI64(1);
  @$pb.TagNumber(2)
  set countFollowing($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountFollowing() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountFollowing() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get countFollowers => $_getI64(2);
  @$pb.TagNumber(3)
  set countFollowers($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountFollowers() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountFollowers() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get memberSince => $_getI64(3);
  @$pb.TagNumber(4)
  set memberSince($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMemberSince() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemberSince() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isMe => $_getBF(4);
  @$pb.TagNumber(5)
  set isMe($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsMe() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsMe() => $_clearField(5);

  /// Whether `stats` is filled in: the user is public, or it's the viewer.
  @$pb.TagNumber(6)
  $core.bool get visible => $_getBF(5);
  @$pb.TagNumber(6)
  set visible($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVisible() => $_has(5);
  @$pb.TagNumber(6)
  void clearVisible() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.DetailedStatsReply get stats => $_getN(6);
  @$pb.TagNumber(7)
  set stats($1.DetailedStatsReply value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStats() => $_has(6);
  @$pb.TagNumber(7)
  void clearStats() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.DetailedStatsReply ensureStats() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
