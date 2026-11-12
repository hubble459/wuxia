// This is a generated file - do not edit.
//
// Generated from rumgap/v1/v1.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'admin.pb.dart' as $11;
import 'chapter.pb.dart' as $6;
import 'comment.pb.dart' as $4;
import 'friend.pb.dart' as $3;
import 'manga.pb.dart' as $5;
import 'meta.pb.dart' as $9;
import 'paginate.pb.dart' as $1;
import 'reading.pb.dart' as $7;
import 'scraper.pb.dart' as $10;
import 'search.pb.dart' as $8;
import 'user.pb.dart' as $0;
import 'v1.pb.dart' as $2;

export 'v1.pb.dart';

@$pb.GrpcServiceName('rumgap.v1.User')
class UserClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserClient(super.channel, {super.options, super.interceptors});

  /// Always denied; accounts are created through Admin.CreateUser.
  $grpc.ResponseFuture<$0.UserTokenReply> register(
    $0.UserRegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserTokenReply> login(
    $0.UserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> get(
    $0.GetUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.UsersReply> index(
    $1.PaginateQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> me(
    $2.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$me, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> update(
    $0.UserUpdateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> addDeviceToken(
    $0.DeviceTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addDeviceToken, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> removeDeviceToken(
    $0.DeviceTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeDeviceToken, request, options: options);
  }

  /// Revoke the session this request was made with
  $grpc.ResponseFuture<$2.Empty> logout(
    $2.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$logout, request, options: options);
  }

  $grpc.ResponseFuture<$0.SessionsReply> sessions(
    $2.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sessions, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> revokeSession(
    $0.RevokeSessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$revokeSession, request, options: options);
  }

  // method descriptors

  static final _$register =
      $grpc.ClientMethod<$0.UserRegisterRequest, $0.UserTokenReply>(
          '/rumgap.v1.User/Register',
          ($0.UserRegisterRequest value) => value.writeToBuffer(),
          $0.UserTokenReply.fromBuffer);
  static final _$login = $grpc.ClientMethod<$0.UserRequest, $0.UserTokenReply>(
      '/rumgap.v1.User/Login',
      ($0.UserRequest value) => value.writeToBuffer(),
      $0.UserTokenReply.fromBuffer);
  static final _$get = $grpc.ClientMethod<$0.GetUserRequest, $0.UserFullReply>(
      '/rumgap.v1.User/Get',
      ($0.GetUserRequest value) => value.writeToBuffer(),
      $0.UserFullReply.fromBuffer);
  static final _$index = $grpc.ClientMethod<$1.PaginateQuery, $0.UsersReply>(
      '/rumgap.v1.User/Index',
      ($1.PaginateQuery value) => value.writeToBuffer(),
      $0.UsersReply.fromBuffer);
  static final _$me = $grpc.ClientMethod<$2.Empty, $0.UserFullReply>(
      '/rumgap.v1.User/Me',
      ($2.Empty value) => value.writeToBuffer(),
      $0.UserFullReply.fromBuffer);
  static final _$update =
      $grpc.ClientMethod<$0.UserUpdateRequest, $0.UserFullReply>(
          '/rumgap.v1.User/Update',
          ($0.UserUpdateRequest value) => value.writeToBuffer(),
          $0.UserFullReply.fromBuffer);
  static final _$addDeviceToken =
      $grpc.ClientMethod<$0.DeviceTokenRequest, $2.Empty>(
          '/rumgap.v1.User/AddDeviceToken',
          ($0.DeviceTokenRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$removeDeviceToken =
      $grpc.ClientMethod<$0.DeviceTokenRequest, $2.Empty>(
          '/rumgap.v1.User/RemoveDeviceToken',
          ($0.DeviceTokenRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$logout = $grpc.ClientMethod<$2.Empty, $2.Empty>(
      '/rumgap.v1.User/Logout',
      ($2.Empty value) => value.writeToBuffer(),
      $2.Empty.fromBuffer);
  static final _$sessions = $grpc.ClientMethod<$2.Empty, $0.SessionsReply>(
      '/rumgap.v1.User/Sessions',
      ($2.Empty value) => value.writeToBuffer(),
      $0.SessionsReply.fromBuffer);
  static final _$revokeSession =
      $grpc.ClientMethod<$0.RevokeSessionRequest, $2.Empty>(
          '/rumgap.v1.User/RevokeSession',
          ($0.RevokeSessionRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.User')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.User';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UserRegisterRequest, $0.UserTokenReply>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UserRegisterRequest.fromBuffer(value),
        ($0.UserTokenReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserRequest, $0.UserTokenReply>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserRequest.fromBuffer(value),
        ($0.UserTokenReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserRequest, $0.UserFullReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserRequest.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PaginateQuery, $0.UsersReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PaginateQuery.fromBuffer(value),
        ($0.UsersReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $0.UserFullReply>(
        'Me',
        me_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserUpdateRequest, $0.UserFullReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserUpdateRequest.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeviceTokenRequest, $2.Empty>(
        'AddDeviceToken',
        addDeviceToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeviceTokenRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeviceTokenRequest, $2.Empty>(
        'RemoveDeviceToken',
        removeDeviceToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeviceTokenRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $2.Empty>(
        'Logout',
        logout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $0.SessionsReply>(
        'Sessions',
        sessions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($0.SessionsReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RevokeSessionRequest, $2.Empty>(
        'RevokeSession',
        revokeSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RevokeSessionRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserTokenReply> register_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UserRegisterRequest> $request) async {
    return register($call, await $request);
  }

  $async.Future<$0.UserTokenReply> register(
      $grpc.ServiceCall call, $0.UserRegisterRequest request);

  $async.Future<$0.UserTokenReply> login_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.UserRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.UserTokenReply> login(
      $grpc.ServiceCall call, $0.UserRequest request);

  $async.Future<$0.UserFullReply> get_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserRequest> $request) async {
    return get($call, await $request);
  }

  $async.Future<$0.UserFullReply> get(
      $grpc.ServiceCall call, $0.GetUserRequest request);

  $async.Future<$0.UsersReply> index_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.PaginateQuery> $request) async {
    return index($call, await $request);
  }

  $async.Future<$0.UsersReply> index(
      $grpc.ServiceCall call, $1.PaginateQuery request);

  $async.Future<$0.UserFullReply> me_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.Empty> $request) async {
    return me($call, await $request);
  }

  $async.Future<$0.UserFullReply> me($grpc.ServiceCall call, $2.Empty request);

  $async.Future<$0.UserFullReply> update_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UserUpdateRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$0.UserFullReply> update(
      $grpc.ServiceCall call, $0.UserUpdateRequest request);

  $async.Future<$2.Empty> addDeviceToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeviceTokenRequest> $request) async {
    return addDeviceToken($call, await $request);
  }

  $async.Future<$2.Empty> addDeviceToken(
      $grpc.ServiceCall call, $0.DeviceTokenRequest request);

  $async.Future<$2.Empty> removeDeviceToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeviceTokenRequest> $request) async {
    return removeDeviceToken($call, await $request);
  }

  $async.Future<$2.Empty> removeDeviceToken(
      $grpc.ServiceCall call, $0.DeviceTokenRequest request);

  $async.Future<$2.Empty> logout_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.Empty> $request) async {
    return logout($call, await $request);
  }

  $async.Future<$2.Empty> logout($grpc.ServiceCall call, $2.Empty request);

  $async.Future<$0.SessionsReply> sessions_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.Empty> $request) async {
    return sessions($call, await $request);
  }

  $async.Future<$0.SessionsReply> sessions(
      $grpc.ServiceCall call, $2.Empty request);

  $async.Future<$2.Empty> revokeSession_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RevokeSessionRequest> $request) async {
    return revokeSession($call, await $request);
  }

  $async.Future<$2.Empty> revokeSession(
      $grpc.ServiceCall call, $0.RevokeSessionRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Friend')
class FriendClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FriendClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$3.UserSummary> follow(
    $3.FriendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$follow, request, options: options);
  }

  $grpc.ResponseFuture<$3.UserSummary> unfollow(
    $3.FriendRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unfollow, request, options: options);
  }

  $grpc.ResponseFuture<$3.UserSummariesReply> following(
    $1.PaginateQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$following, request, options: options);
  }

  $grpc.ResponseFuture<$3.UserSummariesReply> followers(
    $1.PaginateQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$followers, request, options: options);
  }

  /// A user's profile; stats only when they're public or it's the viewer.
  $grpc.ResponseFuture<$3.ProfileReply> profile(
    $3.ProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$profile, request, options: options);
  }

  // method descriptors

  static final _$follow = $grpc.ClientMethod<$3.FriendRequest, $3.UserSummary>(
      '/rumgap.v1.Friend/Follow',
      ($3.FriendRequest value) => value.writeToBuffer(),
      $3.UserSummary.fromBuffer);
  static final _$unfollow =
      $grpc.ClientMethod<$3.FriendRequest, $3.UserSummary>(
          '/rumgap.v1.Friend/Unfollow',
          ($3.FriendRequest value) => value.writeToBuffer(),
          $3.UserSummary.fromBuffer);
  static final _$following =
      $grpc.ClientMethod<$1.PaginateQuery, $3.UserSummariesReply>(
          '/rumgap.v1.Friend/Following',
          ($1.PaginateQuery value) => value.writeToBuffer(),
          $3.UserSummariesReply.fromBuffer);
  static final _$followers =
      $grpc.ClientMethod<$1.PaginateQuery, $3.UserSummariesReply>(
          '/rumgap.v1.Friend/Followers',
          ($1.PaginateQuery value) => value.writeToBuffer(),
          $3.UserSummariesReply.fromBuffer);
  static final _$profile =
      $grpc.ClientMethod<$3.ProfileRequest, $3.ProfileReply>(
          '/rumgap.v1.Friend/Profile',
          ($3.ProfileRequest value) => value.writeToBuffer(),
          $3.ProfileReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Friend')
abstract class FriendServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Friend';

  FriendServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.FriendRequest, $3.UserSummary>(
        'Follow',
        follow_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.FriendRequest.fromBuffer(value),
        ($3.UserSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.FriendRequest, $3.UserSummary>(
        'Unfollow',
        unfollow_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.FriendRequest.fromBuffer(value),
        ($3.UserSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PaginateQuery, $3.UserSummariesReply>(
        'Following',
        following_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PaginateQuery.fromBuffer(value),
        ($3.UserSummariesReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PaginateQuery, $3.UserSummariesReply>(
        'Followers',
        followers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PaginateQuery.fromBuffer(value),
        ($3.UserSummariesReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ProfileRequest, $3.ProfileReply>(
        'Profile',
        profile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.ProfileRequest.fromBuffer(value),
        ($3.ProfileReply value) => value.writeToBuffer()));
  }

  $async.Future<$3.UserSummary> follow_Pre(
      $grpc.ServiceCall $call, $async.Future<$3.FriendRequest> $request) async {
    return follow($call, await $request);
  }

  $async.Future<$3.UserSummary> follow(
      $grpc.ServiceCall call, $3.FriendRequest request);

  $async.Future<$3.UserSummary> unfollow_Pre(
      $grpc.ServiceCall $call, $async.Future<$3.FriendRequest> $request) async {
    return unfollow($call, await $request);
  }

  $async.Future<$3.UserSummary> unfollow(
      $grpc.ServiceCall call, $3.FriendRequest request);

  $async.Future<$3.UserSummariesReply> following_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.PaginateQuery> $request) async {
    return following($call, await $request);
  }

  $async.Future<$3.UserSummariesReply> following(
      $grpc.ServiceCall call, $1.PaginateQuery request);

  $async.Future<$3.UserSummariesReply> followers_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.PaginateQuery> $request) async {
    return followers($call, await $request);
  }

  $async.Future<$3.UserSummariesReply> followers(
      $grpc.ServiceCall call, $1.PaginateQuery request);

  $async.Future<$3.ProfileReply> profile_Pre($grpc.ServiceCall $call,
      $async.Future<$3.ProfileRequest> $request) async {
    return profile($call, await $request);
  }

  $async.Future<$3.ProfileReply> profile(
      $grpc.ServiceCall call, $3.ProfileRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Comment')
class CommentClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CommentClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$4.CommentsReply> list(
    $4.ListCommentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$list, request, options: options);
  }

  /// One comment with the comments above it, for opening a deep reply on its own.
  $grpc.ResponseFuture<$4.CommentThreadReply> thread(
    $4.GetCommentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$thread, request, options: options);
  }

  $grpc.ResponseFuture<$4.CommentReply> create(
    $4.CreateCommentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  /// Author only.
  $grpc.ResponseFuture<$4.CommentReply> edit(
    $4.EditCommentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$edit, request, options: options);
  }

  /// Author or admin. A comment with replies stays as "[deleted]".
  $grpc.ResponseFuture<$2.Empty> delete(
    $4.DeleteCommentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  // method descriptors

  static final _$list =
      $grpc.ClientMethod<$4.ListCommentsRequest, $4.CommentsReply>(
          '/rumgap.v1.Comment/List',
          ($4.ListCommentsRequest value) => value.writeToBuffer(),
          $4.CommentsReply.fromBuffer);
  static final _$thread =
      $grpc.ClientMethod<$4.GetCommentRequest, $4.CommentThreadReply>(
          '/rumgap.v1.Comment/Thread',
          ($4.GetCommentRequest value) => value.writeToBuffer(),
          $4.CommentThreadReply.fromBuffer);
  static final _$create =
      $grpc.ClientMethod<$4.CreateCommentRequest, $4.CommentReply>(
          '/rumgap.v1.Comment/Create',
          ($4.CreateCommentRequest value) => value.writeToBuffer(),
          $4.CommentReply.fromBuffer);
  static final _$edit =
      $grpc.ClientMethod<$4.EditCommentRequest, $4.CommentReply>(
          '/rumgap.v1.Comment/Edit',
          ($4.EditCommentRequest value) => value.writeToBuffer(),
          $4.CommentReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$4.DeleteCommentRequest, $2.Empty>(
      '/rumgap.v1.Comment/Delete',
      ($4.DeleteCommentRequest value) => value.writeToBuffer(),
      $2.Empty.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Comment')
abstract class CommentServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Comment';

  CommentServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.ListCommentsRequest, $4.CommentsReply>(
        'List',
        list_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.ListCommentsRequest.fromBuffer(value),
        ($4.CommentsReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetCommentRequest, $4.CommentThreadReply>(
        'Thread',
        thread_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetCommentRequest.fromBuffer(value),
        ($4.CommentThreadReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CreateCommentRequest, $4.CommentReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CreateCommentRequest.fromBuffer(value),
        ($4.CommentReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.EditCommentRequest, $4.CommentReply>(
        'Edit',
        edit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.EditCommentRequest.fromBuffer(value),
        ($4.CommentReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.DeleteCommentRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.DeleteCommentRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.CommentsReply> list_Pre($grpc.ServiceCall $call,
      $async.Future<$4.ListCommentsRequest> $request) async {
    return list($call, await $request);
  }

  $async.Future<$4.CommentsReply> list(
      $grpc.ServiceCall call, $4.ListCommentsRequest request);

  $async.Future<$4.CommentThreadReply> thread_Pre($grpc.ServiceCall $call,
      $async.Future<$4.GetCommentRequest> $request) async {
    return thread($call, await $request);
  }

  $async.Future<$4.CommentThreadReply> thread(
      $grpc.ServiceCall call, $4.GetCommentRequest request);

  $async.Future<$4.CommentReply> create_Pre($grpc.ServiceCall $call,
      $async.Future<$4.CreateCommentRequest> $request) async {
    return create($call, await $request);
  }

  $async.Future<$4.CommentReply> create(
      $grpc.ServiceCall call, $4.CreateCommentRequest request);

  $async.Future<$4.CommentReply> edit_Pre($grpc.ServiceCall $call,
      $async.Future<$4.EditCommentRequest> $request) async {
    return edit($call, await $request);
  }

  $async.Future<$4.CommentReply> edit(
      $grpc.ServiceCall call, $4.EditCommentRequest request);

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall $call,
      $async.Future<$4.DeleteCommentRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$2.Empty> delete(
      $grpc.ServiceCall call, $4.DeleteCommentRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Manga')
class MangaClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MangaClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$5.MangaReply> create(
    $5.MangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseStream<$5.MangaReply> createMany(
    $5.MangasRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$createMany, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> get(
    $5.GetMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$get, request, options: options);
  }

  /// Refreshes this manga's primary source (only a primary-source refresh updates
  /// canonical manga title/description/cover/etc).
  $grpc.ResponseFuture<$5.MangaReply> update(
    $2.UpdateMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangasReply> index(
    $1.PaginateSearchQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> findOrCreate(
    $5.MangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$findOrCreate, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangasReply> similar(
    $5.SimilarMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$similar, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> addSource(
    $5.AddSourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addSource, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> removeSource(
    $5.RemoveSourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeSource, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> setPrimarySource(
    $5.SetPrimarySourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPrimarySource, request, options: options);
  }

  /// Remember this source as the one the user sees for its manga (if it's in their
  /// reading list) and refresh its details when they're stale.
  $grpc.ResponseFuture<$5.MangaReply> selectSource(
    $5.SelectSourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$selectSource, request, options: options);
  }

  /// Admin-only. Folds every source of source_manga_id into target_manga_id (reading
  /// progress reconciled, canonical chapters relinked), then deletes source_manga_id.
  $grpc.ResponseFuture<$5.MangaReply> mergeManga(
    $5.MergeMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$mergeManga, request, options: options);
  }

  /// Admin-only. Moves a single source onto a different manga. If that empties out its
  /// old manga, behaves like MergeManga for that one manga (reading progress folded in,
  /// old manga deleted).
  $grpc.ResponseFuture<$5.MangaReply> moveSource(
    $5.MoveSourceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$moveSource, request, options: options);
  }

  /// Mod/admin-only. Deletes a manga outright, cascading away its sources, chapters
  /// and everyone's reading progress on it.
  $grpc.ResponseFuture<$2.Empty> delete(
    $5.DeleteMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  /// Kicks off (or resumes) a throttled background walk that downloads every
  /// not-yet-`done` page of every chapter of that source.
  $grpc.ResponseFuture<$2.Empty> backfillImages(
    $5.BackfillImagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$backfillImages, request, options: options);
  }

  /// See BackfillImages. Cheap `GROUP BY status` count, meant to be polled on
  /// the client's own schedule -- no long-lived streaming RPC for a job that
  /// can run for hours.
  $grpc.ResponseFuture<$5.BackfillStatusReply> getBackfillStatus(
    $5.GetBackfillStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getBackfillStatus, request, options: options);
  }

  /// Manga the user isn't reading and hasn't dismissed lately, best match to their reading
  /// first (genres and description keywords). Ranked fresh on every call.
  $grpc.ResponseFuture<$5.MangasReply> forYou(
    $5.ForYouRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$forYou, request, options: options);
  }

  /// "Not interested": hides the manga from ForYou for a while (FOR_YOU_DISMISS_DAYS) and
  /// ranks similar manga lower until then. Dismissing again restarts the cooldown.
  $grpc.ResponseFuture<$2.Empty> dismiss(
    $5.DismissMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$dismiss, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> undismiss(
    $5.DismissMangaRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$undismiss, request, options: options);
  }

  /// Mod/admin-only. Marks a manga 18+ or not. A source scraped as nsfw (an adult-only
  /// site, `nsfw: true` in its manga_parser config, or a mangadex adult rating) marks
  /// its manga 18+ by itself.
  $grpc.ResponseFuture<$5.MangaReply> setNsfw(
    $5.SetNsfwRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setNsfw, request, options: options);
  }

  // method descriptors

  static final _$create = $grpc.ClientMethod<$5.MangaRequest, $5.MangaReply>(
      '/rumgap.v1.Manga/Create',
      ($5.MangaRequest value) => value.writeToBuffer(),
      $5.MangaReply.fromBuffer);
  static final _$createMany =
      $grpc.ClientMethod<$5.MangasRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/CreateMany',
          ($5.MangasRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$get = $grpc.ClientMethod<$5.GetMangaRequest, $5.MangaReply>(
      '/rumgap.v1.Manga/Get',
      ($5.GetMangaRequest value) => value.writeToBuffer(),
      $5.MangaReply.fromBuffer);
  static final _$update =
      $grpc.ClientMethod<$2.UpdateMangaRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/Update',
          ($2.UpdateMangaRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$index =
      $grpc.ClientMethod<$1.PaginateSearchQuery, $5.MangasReply>(
          '/rumgap.v1.Manga/Index',
          ($1.PaginateSearchQuery value) => value.writeToBuffer(),
          $5.MangasReply.fromBuffer);
  static final _$findOrCreate =
      $grpc.ClientMethod<$5.MangaRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/FindOrCreate',
          ($5.MangaRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$similar =
      $grpc.ClientMethod<$5.SimilarMangaRequest, $5.MangasReply>(
          '/rumgap.v1.Manga/Similar',
          ($5.SimilarMangaRequest value) => value.writeToBuffer(),
          $5.MangasReply.fromBuffer);
  static final _$addSource =
      $grpc.ClientMethod<$5.AddSourceRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/AddSource',
          ($5.AddSourceRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$removeSource =
      $grpc.ClientMethod<$5.RemoveSourceRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/RemoveSource',
          ($5.RemoveSourceRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$setPrimarySource =
      $grpc.ClientMethod<$5.SetPrimarySourceRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/SetPrimarySource',
          ($5.SetPrimarySourceRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$selectSource =
      $grpc.ClientMethod<$5.SelectSourceRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/SelectSource',
          ($5.SelectSourceRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$mergeManga =
      $grpc.ClientMethod<$5.MergeMangaRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/MergeManga',
          ($5.MergeMangaRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$moveSource =
      $grpc.ClientMethod<$5.MoveSourceRequest, $5.MangaReply>(
          '/rumgap.v1.Manga/MoveSource',
          ($5.MoveSourceRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$5.DeleteMangaRequest, $2.Empty>(
      '/rumgap.v1.Manga/Delete',
      ($5.DeleteMangaRequest value) => value.writeToBuffer(),
      $2.Empty.fromBuffer);
  static final _$backfillImages =
      $grpc.ClientMethod<$5.BackfillImagesRequest, $2.Empty>(
          '/rumgap.v1.Manga/BackfillImages',
          ($5.BackfillImagesRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$getBackfillStatus =
      $grpc.ClientMethod<$5.GetBackfillStatusRequest, $5.BackfillStatusReply>(
          '/rumgap.v1.Manga/GetBackfillStatus',
          ($5.GetBackfillStatusRequest value) => value.writeToBuffer(),
          $5.BackfillStatusReply.fromBuffer);
  static final _$forYou = $grpc.ClientMethod<$5.ForYouRequest, $5.MangasReply>(
      '/rumgap.v1.Manga/ForYou',
      ($5.ForYouRequest value) => value.writeToBuffer(),
      $5.MangasReply.fromBuffer);
  static final _$dismiss = $grpc.ClientMethod<$5.DismissMangaRequest, $2.Empty>(
      '/rumgap.v1.Manga/Dismiss',
      ($5.DismissMangaRequest value) => value.writeToBuffer(),
      $2.Empty.fromBuffer);
  static final _$undismiss =
      $grpc.ClientMethod<$5.DismissMangaRequest, $2.Empty>(
          '/rumgap.v1.Manga/Undismiss',
          ($5.DismissMangaRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$setNsfw = $grpc.ClientMethod<$5.SetNsfwRequest, $5.MangaReply>(
      '/rumgap.v1.Manga/SetNsfw',
      ($5.SetNsfwRequest value) => value.writeToBuffer(),
      $5.MangaReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Manga')
abstract class MangaServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Manga';

  MangaServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.MangaRequest, $5.MangaReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MangaRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MangasRequest, $5.MangaReply>(
        'CreateMany',
        createMany_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.MangasRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetMangaRequest, $5.MangaReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.GetMangaRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateMangaRequest, $5.MangaReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateMangaRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PaginateSearchQuery, $5.MangasReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PaginateSearchQuery.fromBuffer(value),
        ($5.MangasReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MangaRequest, $5.MangaReply>(
        'FindOrCreate',
        findOrCreate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MangaRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SimilarMangaRequest, $5.MangasReply>(
        'Similar',
        similar_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.SimilarMangaRequest.fromBuffer(value),
        ($5.MangasReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.AddSourceRequest, $5.MangaReply>(
        'AddSource',
        addSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.AddSourceRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.RemoveSourceRequest, $5.MangaReply>(
        'RemoveSource',
        removeSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.RemoveSourceRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SetPrimarySourceRequest, $5.MangaReply>(
        'SetPrimarySource',
        setPrimarySource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.SetPrimarySourceRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SelectSourceRequest, $5.MangaReply>(
        'SelectSource',
        selectSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.SelectSourceRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MergeMangaRequest, $5.MangaReply>(
        'MergeManga',
        mergeManga_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MergeMangaRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MoveSourceRequest, $5.MangaReply>(
        'MoveSource',
        moveSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MoveSourceRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.DeleteMangaRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.DeleteMangaRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.BackfillImagesRequest, $2.Empty>(
        'BackfillImages',
        backfillImages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.BackfillImagesRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.GetBackfillStatusRequest,
            $5.BackfillStatusReply>(
        'GetBackfillStatus',
        getBackfillStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.GetBackfillStatusRequest.fromBuffer(value),
        ($5.BackfillStatusReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ForYouRequest, $5.MangasReply>(
        'ForYou',
        forYou_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ForYouRequest.fromBuffer(value),
        ($5.MangasReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.DismissMangaRequest, $2.Empty>(
        'Dismiss',
        dismiss_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.DismissMangaRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.DismissMangaRequest, $2.Empty>(
        'Undismiss',
        undismiss_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.DismissMangaRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SetNsfwRequest, $5.MangaReply>(
        'SetNsfw',
        setNsfw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SetNsfwRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
  }

  $async.Future<$5.MangaReply> create_Pre(
      $grpc.ServiceCall $call, $async.Future<$5.MangaRequest> $request) async {
    return create($call, await $request);
  }

  $async.Future<$5.MangaReply> create(
      $grpc.ServiceCall call, $5.MangaRequest request);

  $async.Stream<$5.MangaReply> createMany_Pre($grpc.ServiceCall $call,
      $async.Future<$5.MangasRequest> $request) async* {
    yield* createMany($call, await $request);
  }

  $async.Stream<$5.MangaReply> createMany(
      $grpc.ServiceCall call, $5.MangasRequest request);

  $async.Future<$5.MangaReply> get_Pre($grpc.ServiceCall $call,
      $async.Future<$5.GetMangaRequest> $request) async {
    return get($call, await $request);
  }

  $async.Future<$5.MangaReply> get(
      $grpc.ServiceCall call, $5.GetMangaRequest request);

  $async.Future<$5.MangaReply> update_Pre($grpc.ServiceCall $call,
      $async.Future<$2.UpdateMangaRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$5.MangaReply> update(
      $grpc.ServiceCall call, $2.UpdateMangaRequest request);

  $async.Future<$5.MangasReply> index_Pre($grpc.ServiceCall $call,
      $async.Future<$1.PaginateSearchQuery> $request) async {
    return index($call, await $request);
  }

  $async.Future<$5.MangasReply> index(
      $grpc.ServiceCall call, $1.PaginateSearchQuery request);

  $async.Future<$5.MangaReply> findOrCreate_Pre(
      $grpc.ServiceCall $call, $async.Future<$5.MangaRequest> $request) async {
    return findOrCreate($call, await $request);
  }

  $async.Future<$5.MangaReply> findOrCreate(
      $grpc.ServiceCall call, $5.MangaRequest request);

  $async.Future<$5.MangasReply> similar_Pre($grpc.ServiceCall $call,
      $async.Future<$5.SimilarMangaRequest> $request) async {
    return similar($call, await $request);
  }

  $async.Future<$5.MangasReply> similar(
      $grpc.ServiceCall call, $5.SimilarMangaRequest request);

  $async.Future<$5.MangaReply> addSource_Pre($grpc.ServiceCall $call,
      $async.Future<$5.AddSourceRequest> $request) async {
    return addSource($call, await $request);
  }

  $async.Future<$5.MangaReply> addSource(
      $grpc.ServiceCall call, $5.AddSourceRequest request);

  $async.Future<$5.MangaReply> removeSource_Pre($grpc.ServiceCall $call,
      $async.Future<$5.RemoveSourceRequest> $request) async {
    return removeSource($call, await $request);
  }

  $async.Future<$5.MangaReply> removeSource(
      $grpc.ServiceCall call, $5.RemoveSourceRequest request);

  $async.Future<$5.MangaReply> setPrimarySource_Pre($grpc.ServiceCall $call,
      $async.Future<$5.SetPrimarySourceRequest> $request) async {
    return setPrimarySource($call, await $request);
  }

  $async.Future<$5.MangaReply> setPrimarySource(
      $grpc.ServiceCall call, $5.SetPrimarySourceRequest request);

  $async.Future<$5.MangaReply> selectSource_Pre($grpc.ServiceCall $call,
      $async.Future<$5.SelectSourceRequest> $request) async {
    return selectSource($call, await $request);
  }

  $async.Future<$5.MangaReply> selectSource(
      $grpc.ServiceCall call, $5.SelectSourceRequest request);

  $async.Future<$5.MangaReply> mergeManga_Pre($grpc.ServiceCall $call,
      $async.Future<$5.MergeMangaRequest> $request) async {
    return mergeManga($call, await $request);
  }

  $async.Future<$5.MangaReply> mergeManga(
      $grpc.ServiceCall call, $5.MergeMangaRequest request);

  $async.Future<$5.MangaReply> moveSource_Pre($grpc.ServiceCall $call,
      $async.Future<$5.MoveSourceRequest> $request) async {
    return moveSource($call, await $request);
  }

  $async.Future<$5.MangaReply> moveSource(
      $grpc.ServiceCall call, $5.MoveSourceRequest request);

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall $call,
      $async.Future<$5.DeleteMangaRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$2.Empty> delete(
      $grpc.ServiceCall call, $5.DeleteMangaRequest request);

  $async.Future<$2.Empty> backfillImages_Pre($grpc.ServiceCall $call,
      $async.Future<$5.BackfillImagesRequest> $request) async {
    return backfillImages($call, await $request);
  }

  $async.Future<$2.Empty> backfillImages(
      $grpc.ServiceCall call, $5.BackfillImagesRequest request);

  $async.Future<$5.BackfillStatusReply> getBackfillStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$5.GetBackfillStatusRequest> $request) async {
    return getBackfillStatus($call, await $request);
  }

  $async.Future<$5.BackfillStatusReply> getBackfillStatus(
      $grpc.ServiceCall call, $5.GetBackfillStatusRequest request);

  $async.Future<$5.MangasReply> forYou_Pre(
      $grpc.ServiceCall $call, $async.Future<$5.ForYouRequest> $request) async {
    return forYou($call, await $request);
  }

  $async.Future<$5.MangasReply> forYou(
      $grpc.ServiceCall call, $5.ForYouRequest request);

  $async.Future<$2.Empty> dismiss_Pre($grpc.ServiceCall $call,
      $async.Future<$5.DismissMangaRequest> $request) async {
    return dismiss($call, await $request);
  }

  $async.Future<$2.Empty> dismiss(
      $grpc.ServiceCall call, $5.DismissMangaRequest request);

  $async.Future<$2.Empty> undismiss_Pre($grpc.ServiceCall $call,
      $async.Future<$5.DismissMangaRequest> $request) async {
    return undismiss($call, await $request);
  }

  $async.Future<$2.Empty> undismiss(
      $grpc.ServiceCall call, $5.DismissMangaRequest request);

  $async.Future<$5.MangaReply> setNsfw_Pre($grpc.ServiceCall $call,
      $async.Future<$5.SetNsfwRequest> $request) async {
    return setNsfw($call, await $request);
  }

  $async.Future<$5.MangaReply> setNsfw(
      $grpc.ServiceCall call, $5.SetNsfwRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Chapter')
class ChapterClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ChapterClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$6.ChapterReply> get(
    $6.ChapterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$6.ChaptersReply> index(
    $6.PaginateChapterQuery request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$index, request, options: options);
  }

  /// Never blocks on downloads -- ensures `chapter_image` rows exist and returns
  /// deterministic local image-server URLs; the actual download happens lazily
  /// on first real request to that URL.
  $grpc.ResponseFuture<$6.ImagesReply> images(
    $6.ChapterImagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$images, request, options: options);
  }

  $grpc.ResponseFuture<$6.ChapterReply> linkChapter(
    $6.LinkChapterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$linkChapter, request, options: options);
  }

  $grpc.ResponseFuture<$6.ChapterReply> unlinkChapter(
    $6.UnlinkChapterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unlinkChapter, request, options: options);
  }

  $grpc.ResponseFuture<$6.ChapterReply> findEquivalent(
    $6.FindEquivalentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$findEquivalent, request, options: options);
  }

  /// Manual-only force-refresh: deletes this chapter's existing `chapter_image`
  /// rows (and their stored bytes) and re-scrapes from scratch. For the handful
  /// of sites that briefly serve a placeholder/troll image right after a
  /// chapter is scraped.
  $grpc.ResponseFuture<$6.ImagesReply> refreshImages(
    $6.RefreshImagesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshImages, request, options: options);
  }

  // method descriptors

  static final _$get = $grpc.ClientMethod<$6.ChapterRequest, $6.ChapterReply>(
      '/rumgap.v1.Chapter/Get',
      ($6.ChapterRequest value) => value.writeToBuffer(),
      $6.ChapterReply.fromBuffer);
  static final _$index =
      $grpc.ClientMethod<$6.PaginateChapterQuery, $6.ChaptersReply>(
          '/rumgap.v1.Chapter/Index',
          ($6.PaginateChapterQuery value) => value.writeToBuffer(),
          $6.ChaptersReply.fromBuffer);
  static final _$images =
      $grpc.ClientMethod<$6.ChapterImagesRequest, $6.ImagesReply>(
          '/rumgap.v1.Chapter/Images',
          ($6.ChapterImagesRequest value) => value.writeToBuffer(),
          $6.ImagesReply.fromBuffer);
  static final _$linkChapter =
      $grpc.ClientMethod<$6.LinkChapterRequest, $6.ChapterReply>(
          '/rumgap.v1.Chapter/LinkChapter',
          ($6.LinkChapterRequest value) => value.writeToBuffer(),
          $6.ChapterReply.fromBuffer);
  static final _$unlinkChapter =
      $grpc.ClientMethod<$6.UnlinkChapterRequest, $6.ChapterReply>(
          '/rumgap.v1.Chapter/UnlinkChapter',
          ($6.UnlinkChapterRequest value) => value.writeToBuffer(),
          $6.ChapterReply.fromBuffer);
  static final _$findEquivalent =
      $grpc.ClientMethod<$6.FindEquivalentRequest, $6.ChapterReply>(
          '/rumgap.v1.Chapter/FindEquivalent',
          ($6.FindEquivalentRequest value) => value.writeToBuffer(),
          $6.ChapterReply.fromBuffer);
  static final _$refreshImages =
      $grpc.ClientMethod<$6.RefreshImagesRequest, $6.ImagesReply>(
          '/rumgap.v1.Chapter/RefreshImages',
          ($6.RefreshImagesRequest value) => value.writeToBuffer(),
          $6.ImagesReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Chapter')
abstract class ChapterServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Chapter';

  ChapterServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.ChapterRequest, $6.ChapterReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.ChapterRequest.fromBuffer(value),
        ($6.ChapterReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.PaginateChapterQuery, $6.ChaptersReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.PaginateChapterQuery.fromBuffer(value),
        ($6.ChaptersReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.ChapterImagesRequest, $6.ImagesReply>(
        'Images',
        images_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.ChapterImagesRequest.fromBuffer(value),
        ($6.ImagesReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.LinkChapterRequest, $6.ChapterReply>(
        'LinkChapter',
        linkChapter_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.LinkChapterRequest.fromBuffer(value),
        ($6.ChapterReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.UnlinkChapterRequest, $6.ChapterReply>(
        'UnlinkChapter',
        unlinkChapter_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.UnlinkChapterRequest.fromBuffer(value),
        ($6.ChapterReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.FindEquivalentRequest, $6.ChapterReply>(
        'FindEquivalent',
        findEquivalent_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.FindEquivalentRequest.fromBuffer(value),
        ($6.ChapterReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.RefreshImagesRequest, $6.ImagesReply>(
        'RefreshImages',
        refreshImages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.RefreshImagesRequest.fromBuffer(value),
        ($6.ImagesReply value) => value.writeToBuffer()));
  }

  $async.Future<$6.ChapterReply> get_Pre($grpc.ServiceCall $call,
      $async.Future<$6.ChapterRequest> $request) async {
    return get($call, await $request);
  }

  $async.Future<$6.ChapterReply> get(
      $grpc.ServiceCall call, $6.ChapterRequest request);

  $async.Future<$6.ChaptersReply> index_Pre($grpc.ServiceCall $call,
      $async.Future<$6.PaginateChapterQuery> $request) async {
    return index($call, await $request);
  }

  $async.Future<$6.ChaptersReply> index(
      $grpc.ServiceCall call, $6.PaginateChapterQuery request);

  $async.Future<$6.ImagesReply> images_Pre($grpc.ServiceCall $call,
      $async.Future<$6.ChapterImagesRequest> $request) async {
    return images($call, await $request);
  }

  $async.Future<$6.ImagesReply> images(
      $grpc.ServiceCall call, $6.ChapterImagesRequest request);

  $async.Future<$6.ChapterReply> linkChapter_Pre($grpc.ServiceCall $call,
      $async.Future<$6.LinkChapterRequest> $request) async {
    return linkChapter($call, await $request);
  }

  $async.Future<$6.ChapterReply> linkChapter(
      $grpc.ServiceCall call, $6.LinkChapterRequest request);

  $async.Future<$6.ChapterReply> unlinkChapter_Pre($grpc.ServiceCall $call,
      $async.Future<$6.UnlinkChapterRequest> $request) async {
    return unlinkChapter($call, await $request);
  }

  $async.Future<$6.ChapterReply> unlinkChapter(
      $grpc.ServiceCall call, $6.UnlinkChapterRequest request);

  $async.Future<$6.ChapterReply> findEquivalent_Pre($grpc.ServiceCall $call,
      $async.Future<$6.FindEquivalentRequest> $request) async {
    return findEquivalent($call, await $request);
  }

  $async.Future<$6.ChapterReply> findEquivalent(
      $grpc.ServiceCall call, $6.FindEquivalentRequest request);

  $async.Future<$6.ImagesReply> refreshImages_Pre($grpc.ServiceCall $call,
      $async.Future<$6.RefreshImagesRequest> $request) async {
    return refreshImages($call, await $request);
  }

  $async.Future<$6.ImagesReply> refreshImages(
      $grpc.ServiceCall call, $6.RefreshImagesRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Reading')
class ReadingClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ReadingClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$5.MangaReply> update(
    $7.ReadingPatchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$5.MangaReply> create(
    $7.ReadingPostRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> delete(
    $7.DeleteReadingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> updateChapterOffset(
    $7.UpdateChapterOffsetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateChapterOffset, request, options: options);
  }

  $grpc.ResponseFuture<$7.CrossSourceOffsetReply> getCrossSourceOffset(
    $7.GetCrossSourceOffsetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCrossSourceOffset, request, options: options);
  }

  // method descriptors

  static final _$update =
      $grpc.ClientMethod<$7.ReadingPatchRequest, $5.MangaReply>(
          '/rumgap.v1.Reading/Update',
          ($7.ReadingPatchRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$create =
      $grpc.ClientMethod<$7.ReadingPostRequest, $5.MangaReply>(
          '/rumgap.v1.Reading/Create',
          ($7.ReadingPostRequest value) => value.writeToBuffer(),
          $5.MangaReply.fromBuffer);
  static final _$delete = $grpc.ClientMethod<$7.DeleteReadingRequest, $2.Empty>(
      '/rumgap.v1.Reading/Delete',
      ($7.DeleteReadingRequest value) => value.writeToBuffer(),
      $2.Empty.fromBuffer);
  static final _$updateChapterOffset =
      $grpc.ClientMethod<$7.UpdateChapterOffsetRequest, $2.Empty>(
          '/rumgap.v1.Reading/UpdateChapterOffset',
          ($7.UpdateChapterOffsetRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$getCrossSourceOffset = $grpc.ClientMethod<
          $7.GetCrossSourceOffsetRequest, $7.CrossSourceOffsetReply>(
      '/rumgap.v1.Reading/GetCrossSourceOffset',
      ($7.GetCrossSourceOffsetRequest value) => value.writeToBuffer(),
      $7.CrossSourceOffsetReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Reading')
abstract class ReadingServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Reading';

  ReadingServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.ReadingPatchRequest, $5.MangaReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.ReadingPatchRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.ReadingPostRequest, $5.MangaReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.ReadingPostRequest.fromBuffer(value),
        ($5.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.DeleteReadingRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.DeleteReadingRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UpdateChapterOffsetRequest, $2.Empty>(
        'UpdateChapterOffset',
        updateChapterOffset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.UpdateChapterOffsetRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetCrossSourceOffsetRequest,
            $7.CrossSourceOffsetReply>(
        'GetCrossSourceOffset',
        getCrossSourceOffset_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $7.GetCrossSourceOffsetRequest.fromBuffer(value),
        ($7.CrossSourceOffsetReply value) => value.writeToBuffer()));
  }

  $async.Future<$5.MangaReply> update_Pre($grpc.ServiceCall $call,
      $async.Future<$7.ReadingPatchRequest> $request) async {
    return update($call, await $request);
  }

  $async.Future<$5.MangaReply> update(
      $grpc.ServiceCall call, $7.ReadingPatchRequest request);

  $async.Future<$5.MangaReply> create_Pre($grpc.ServiceCall $call,
      $async.Future<$7.ReadingPostRequest> $request) async {
    return create($call, await $request);
  }

  $async.Future<$5.MangaReply> create(
      $grpc.ServiceCall call, $7.ReadingPostRequest request);

  $async.Future<$2.Empty> delete_Pre($grpc.ServiceCall $call,
      $async.Future<$7.DeleteReadingRequest> $request) async {
    return delete($call, await $request);
  }

  $async.Future<$2.Empty> delete(
      $grpc.ServiceCall call, $7.DeleteReadingRequest request);

  $async.Future<$2.Empty> updateChapterOffset_Pre($grpc.ServiceCall $call,
      $async.Future<$7.UpdateChapterOffsetRequest> $request) async {
    return updateChapterOffset($call, await $request);
  }

  $async.Future<$2.Empty> updateChapterOffset(
      $grpc.ServiceCall call, $7.UpdateChapterOffsetRequest request);

  $async.Future<$7.CrossSourceOffsetReply> getCrossSourceOffset_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$7.GetCrossSourceOffsetRequest> $request) async {
    return getCrossSourceOffset($call, await $request);
  }

  $async.Future<$7.CrossSourceOffsetReply> getCrossSourceOffset(
      $grpc.ServiceCall call, $7.GetCrossSourceOffsetRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Search')
class SearchClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SearchClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$8.SearchReply> manga(
    $8.SearchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$manga, request, options: options);
  }

  // method descriptors

  static final _$manga = $grpc.ClientMethod<$8.SearchRequest, $8.SearchReply>(
      '/rumgap.v1.Search/Manga',
      ($8.SearchRequest value) => value.writeToBuffer(),
      $8.SearchReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Search')
abstract class SearchServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Search';

  SearchServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.SearchRequest, $8.SearchReply>(
        'Manga',
        manga_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.SearchRequest.fromBuffer(value),
        ($8.SearchReply value) => value.writeToBuffer()));
  }

  $async.Future<$8.SearchReply> manga_Pre(
      $grpc.ServiceCall $call, $async.Future<$8.SearchRequest> $request) async {
    return manga($call, await $request);
  }

  $async.Future<$8.SearchReply> manga(
      $grpc.ServiceCall call, $8.SearchRequest request);
}

@$pb.GrpcServiceName('rumgap.v1.Meta')
class MetaClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MetaClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$9.MetaReply> hostnames(
    $9.MetaHostnamesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$hostnames, request, options: options);
  }

  $grpc.ResponseFuture<$9.MetaReply> genres(
    $9.MetaGenresRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$genres, request, options: options);
  }

  $grpc.ResponseFuture<$9.StatsReply> stats(
    $2.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$stats, request, options: options);
  }

  $grpc.ResponseFuture<$9.DetailedStatsReply> detailedStats(
    $9.DetailedStatsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$detailedStats, request, options: options);
  }

  // method descriptors

  static final _$hostnames =
      $grpc.ClientMethod<$9.MetaHostnamesRequest, $9.MetaReply>(
          '/rumgap.v1.Meta/Hostnames',
          ($9.MetaHostnamesRequest value) => value.writeToBuffer(),
          $9.MetaReply.fromBuffer);
  static final _$genres =
      $grpc.ClientMethod<$9.MetaGenresRequest, $9.MetaReply>(
          '/rumgap.v1.Meta/Genres',
          ($9.MetaGenresRequest value) => value.writeToBuffer(),
          $9.MetaReply.fromBuffer);
  static final _$stats = $grpc.ClientMethod<$2.Empty, $9.StatsReply>(
      '/rumgap.v1.Meta/Stats',
      ($2.Empty value) => value.writeToBuffer(),
      $9.StatsReply.fromBuffer);
  static final _$detailedStats =
      $grpc.ClientMethod<$9.DetailedStatsRequest, $9.DetailedStatsReply>(
          '/rumgap.v1.Meta/DetailedStats',
          ($9.DetailedStatsRequest value) => value.writeToBuffer(),
          $9.DetailedStatsReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Meta')
abstract class MetaServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Meta';

  MetaServiceBase() {
    $addMethod($grpc.ServiceMethod<$9.MetaHostnamesRequest, $9.MetaReply>(
        'Hostnames',
        hostnames_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $9.MetaHostnamesRequest.fromBuffer(value),
        ($9.MetaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$9.MetaGenresRequest, $9.MetaReply>(
        'Genres',
        genres_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $9.MetaGenresRequest.fromBuffer(value),
        ($9.MetaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $9.StatsReply>(
        'Stats',
        stats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($9.StatsReply value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$9.DetailedStatsRequest, $9.DetailedStatsReply>(
            'DetailedStats',
            detailedStats_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $9.DetailedStatsRequest.fromBuffer(value),
            ($9.DetailedStatsReply value) => value.writeToBuffer()));
  }

  $async.Future<$9.MetaReply> hostnames_Pre($grpc.ServiceCall $call,
      $async.Future<$9.MetaHostnamesRequest> $request) async {
    return hostnames($call, await $request);
  }

  $async.Future<$9.MetaReply> hostnames(
      $grpc.ServiceCall call, $9.MetaHostnamesRequest request);

  $async.Future<$9.MetaReply> genres_Pre($grpc.ServiceCall $call,
      $async.Future<$9.MetaGenresRequest> $request) async {
    return genres($call, await $request);
  }

  $async.Future<$9.MetaReply> genres(
      $grpc.ServiceCall call, $9.MetaGenresRequest request);

  $async.Future<$9.StatsReply> stats_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.Empty> $request) async {
    return stats($call, await $request);
  }

  $async.Future<$9.StatsReply> stats($grpc.ServiceCall call, $2.Empty request);

  $async.Future<$9.DetailedStatsReply> detailedStats_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$9.DetailedStatsRequest> $request) async {
    return detailedStats($call, await $request);
  }

  $async.Future<$9.DetailedStatsReply> detailedStats(
      $grpc.ServiceCall call, $9.DetailedStatsRequest request);
}

/// Admin-only: per-hostname scraper health, backing an admin status page for keeping track of
/// which sites' scrapers are currently broken.
@$pb.GrpcServiceName('rumgap.v1.Scraper')
class ScraperClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ScraperClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$10.ScraperStatusReply> status(
    $10.ScraperStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$status, request, options: options);
  }

  // method descriptors

  static final _$status =
      $grpc.ClientMethod<$10.ScraperStatusRequest, $10.ScraperStatusReply>(
          '/rumgap.v1.Scraper/Status',
          ($10.ScraperStatusRequest value) => value.writeToBuffer(),
          $10.ScraperStatusReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Scraper')
abstract class ScraperServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Scraper';

  ScraperServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$10.ScraperStatusRequest, $10.ScraperStatusReply>(
            'Status',
            status_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $10.ScraperStatusRequest.fromBuffer(value),
            ($10.ScraperStatusReply value) => value.writeToBuffer()));
  }

  $async.Future<$10.ScraperStatusReply> status_Pre($grpc.ServiceCall $call,
      $async.Future<$10.ScraperStatusRequest> $request) async {
    return status($call, await $request);
  }

  $async.Future<$10.ScraperStatusReply> status(
      $grpc.ServiceCall call, $10.ScraperStatusRequest request);
}

/// Admin-only: user management.
@$pb.GrpcServiceName('rumgap.v1.Admin')
class AdminClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AdminClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.UserReply> createUser(
    $11.AdminCreateUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> deleteUser(
    $11.AdminDeleteUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> setPassword(
    $11.AdminSetPasswordRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setPassword, request, options: options);
  }

  /// How much disk and database space rumgap takes up.
  $grpc.ResponseFuture<$11.StorageReply> storage(
    $2.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$storage, request, options: options);
  }

  // method descriptors

  static final _$createUser =
      $grpc.ClientMethod<$11.AdminCreateUserRequest, $0.UserReply>(
          '/rumgap.v1.Admin/CreateUser',
          ($11.AdminCreateUserRequest value) => value.writeToBuffer(),
          $0.UserReply.fromBuffer);
  static final _$deleteUser =
      $grpc.ClientMethod<$11.AdminDeleteUserRequest, $2.Empty>(
          '/rumgap.v1.Admin/DeleteUser',
          ($11.AdminDeleteUserRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$setPassword =
      $grpc.ClientMethod<$11.AdminSetPasswordRequest, $2.Empty>(
          '/rumgap.v1.Admin/SetPassword',
          ($11.AdminSetPasswordRequest value) => value.writeToBuffer(),
          $2.Empty.fromBuffer);
  static final _$storage = $grpc.ClientMethod<$2.Empty, $11.StorageReply>(
      '/rumgap.v1.Admin/Storage',
      ($2.Empty value) => value.writeToBuffer(),
      $11.StorageReply.fromBuffer);
}

@$pb.GrpcServiceName('rumgap.v1.Admin')
abstract class AdminServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.v1.Admin';

  AdminServiceBase() {
    $addMethod($grpc.ServiceMethod<$11.AdminCreateUserRequest, $0.UserReply>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.AdminCreateUserRequest.fromBuffer(value),
        ($0.UserReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.AdminDeleteUserRequest, $2.Empty>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.AdminDeleteUserRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$11.AdminSetPasswordRequest, $2.Empty>(
        'SetPassword',
        setPassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $11.AdminSetPasswordRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $11.StorageReply>(
        'Storage',
        storage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($11.StorageReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserReply> createUser_Pre($grpc.ServiceCall $call,
      $async.Future<$11.AdminCreateUserRequest> $request) async {
    return createUser($call, await $request);
  }

  $async.Future<$0.UserReply> createUser(
      $grpc.ServiceCall call, $11.AdminCreateUserRequest request);

  $async.Future<$2.Empty> deleteUser_Pre($grpc.ServiceCall $call,
      $async.Future<$11.AdminDeleteUserRequest> $request) async {
    return deleteUser($call, await $request);
  }

  $async.Future<$2.Empty> deleteUser(
      $grpc.ServiceCall call, $11.AdminDeleteUserRequest request);

  $async.Future<$2.Empty> setPassword_Pre($grpc.ServiceCall $call,
      $async.Future<$11.AdminSetPasswordRequest> $request) async {
    return setPassword($call, await $request);
  }

  $async.Future<$2.Empty> setPassword(
      $grpc.ServiceCall call, $11.AdminSetPasswordRequest request);

  $async.Future<$11.StorageReply> storage_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.Empty> $request) async {
    return storage($call, await $request);
  }

  $async.Future<$11.StorageReply> storage(
      $grpc.ServiceCall call, $2.Empty request);
}
