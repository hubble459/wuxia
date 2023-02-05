///
//  Generated code. Do not modify.
//  source: rumgap.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $0;
import 'rumgap.pb.dart' as $1;
import 'paginate.pb.dart' as $2;
import 'friend.pb.dart' as $3;
import 'manga.pb.dart' as $4;
import 'chapter.pb.dart' as $5;
import 'reading.pb.dart' as $6;
import 'search.pb.dart' as $7;
import 'meta.pb.dart' as $8;
export 'rumgap.pb.dart';

class UserClient extends $grpc.Client {
  static final _$register =
      $grpc.ClientMethod<$0.UserRegisterRequest, $0.UserTokenReply>(
          '/rumgap.User/Register',
          ($0.UserRegisterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UserTokenReply.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$0.UserRequest, $0.UserTokenReply>(
      '/rumgap.User/Login',
      ($0.UserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserTokenReply.fromBuffer(value));
  static final _$get = $grpc.ClientMethod<$1.Id, $0.UserFullReply>(
      '/rumgap.User/Get',
      ($1.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserFullReply.fromBuffer(value));
  static final _$index = $grpc.ClientMethod<$2.PaginateQuery, $0.UsersReply>(
      '/rumgap.User/Index',
      ($2.PaginateQuery value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UsersReply.fromBuffer(value));
  static final _$me = $grpc.ClientMethod<$1.Empty, $0.UserFullReply>(
      '/rumgap.User/Me',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserFullReply.fromBuffer(value));
  static final _$update =
      $grpc.ClientMethod<$0.UserUpdateRequest, $0.UserFullReply>(
          '/rumgap.User/Update',
          ($0.UserUpdateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UserFullReply.fromBuffer(value));

  UserClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.UserTokenReply> register(
      $0.UserRegisterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserTokenReply> login($0.UserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> get($1.Id request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.UsersReply> index($2.PaginateQuery request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> me($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$me, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> update($0.UserUpdateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.User';

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
    $addMethod($grpc.ServiceMethod<$1.Id, $0.UserFullReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Id.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.PaginateQuery, $0.UsersReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.PaginateQuery.fromBuffer(value),
        ($0.UsersReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.UserFullReply>(
        'Me',
        me_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserUpdateRequest, $0.UserFullReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserUpdateRequest.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserTokenReply> register_Pre($grpc.ServiceCall call,
      $async.Future<$0.UserRegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$0.UserTokenReply> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$0.UserFullReply> get_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Id> request) async {
    return get(call, await request);
  }

  $async.Future<$0.UsersReply> index_Pre(
      $grpc.ServiceCall call, $async.Future<$2.PaginateQuery> request) async {
    return index(call, await request);
  }

  $async.Future<$0.UserFullReply> me_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return me(call, await request);
  }

  $async.Future<$0.UserFullReply> update_Pre($grpc.ServiceCall call,
      $async.Future<$0.UserUpdateRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$0.UserTokenReply> register(
      $grpc.ServiceCall call, $0.UserRegisterRequest request);
  $async.Future<$0.UserTokenReply> login(
      $grpc.ServiceCall call, $0.UserRequest request);
  $async.Future<$0.UserFullReply> get($grpc.ServiceCall call, $1.Id request);
  $async.Future<$0.UsersReply> index(
      $grpc.ServiceCall call, $2.PaginateQuery request);
  $async.Future<$0.UserFullReply> me($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$0.UserFullReply> update(
      $grpc.ServiceCall call, $0.UserUpdateRequest request);
}

class FriendClient extends $grpc.Client {
  static final _$follow =
      $grpc.ClientMethod<$3.FriendRequest, $0.UserFullReply>(
          '/rumgap.Friend/Follow',
          ($3.FriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UserFullReply.fromBuffer(value));
  static final _$unfollow =
      $grpc.ClientMethod<$3.FriendRequest, $0.UserFullReply>(
          '/rumgap.Friend/Unfollow',
          ($3.FriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UserFullReply.fromBuffer(value));
  static final _$following =
      $grpc.ClientMethod<$2.PaginateQuery, $0.UsersReply>(
          '/rumgap.Friend/Following',
          ($2.PaginateQuery value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UsersReply.fromBuffer(value));
  static final _$followers =
      $grpc.ClientMethod<$2.PaginateQuery, $0.UsersReply>(
          '/rumgap.Friend/Followers',
          ($2.PaginateQuery value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.UsersReply.fromBuffer(value));

  FriendClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.UserFullReply> follow($3.FriendRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$follow, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserFullReply> unfollow($3.FriendRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfollow, request, options: options);
  }

  $grpc.ResponseFuture<$0.UsersReply> following($2.PaginateQuery request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$following, request, options: options);
  }

  $grpc.ResponseFuture<$0.UsersReply> followers($2.PaginateQuery request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$followers, request, options: options);
  }
}

abstract class FriendServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Friend';

  FriendServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.FriendRequest, $0.UserFullReply>(
        'Follow',
        follow_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.FriendRequest.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.FriendRequest, $0.UserFullReply>(
        'Unfollow',
        unfollow_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.FriendRequest.fromBuffer(value),
        ($0.UserFullReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.PaginateQuery, $0.UsersReply>(
        'Following',
        following_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.PaginateQuery.fromBuffer(value),
        ($0.UsersReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.PaginateQuery, $0.UsersReply>(
        'Followers',
        followers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.PaginateQuery.fromBuffer(value),
        ($0.UsersReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserFullReply> follow_Pre(
      $grpc.ServiceCall call, $async.Future<$3.FriendRequest> request) async {
    return follow(call, await request);
  }

  $async.Future<$0.UserFullReply> unfollow_Pre(
      $grpc.ServiceCall call, $async.Future<$3.FriendRequest> request) async {
    return unfollow(call, await request);
  }

  $async.Future<$0.UsersReply> following_Pre(
      $grpc.ServiceCall call, $async.Future<$2.PaginateQuery> request) async {
    return following(call, await request);
  }

  $async.Future<$0.UsersReply> followers_Pre(
      $grpc.ServiceCall call, $async.Future<$2.PaginateQuery> request) async {
    return followers(call, await request);
  }

  $async.Future<$0.UserFullReply> follow(
      $grpc.ServiceCall call, $3.FriendRequest request);
  $async.Future<$0.UserFullReply> unfollow(
      $grpc.ServiceCall call, $3.FriendRequest request);
  $async.Future<$0.UsersReply> following(
      $grpc.ServiceCall call, $2.PaginateQuery request);
  $async.Future<$0.UsersReply> followers(
      $grpc.ServiceCall call, $2.PaginateQuery request);
}

class MangaClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$4.MangaRequest, $4.MangaReply>(
      '/rumgap.Manga/Create',
      ($4.MangaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$createMany =
      $grpc.ClientMethod<$4.MangasRequest, $4.MangaReply>(
          '/rumgap.Manga/CreateMany',
          ($4.MangasRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$get = $grpc.ClientMethod<$1.Id, $4.MangaReply>(
      '/rumgap.Manga/Get',
      ($1.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$1.Id, $4.MangaReply>(
      '/rumgap.Manga/Update',
      ($1.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$index =
      $grpc.ClientMethod<$2.PaginateSearchQuery, $4.MangasReply>(
          '/rumgap.Manga/Index',
          ($2.PaginateSearchQuery value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.MangasReply.fromBuffer(value));
  static final _$findOrCreate =
      $grpc.ClientMethod<$4.MangaRequest, $4.MangaReply>(
          '/rumgap.Manga/FindOrCreate',
          ($4.MangaRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));

  MangaClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.MangaReply> create($4.MangaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseStream<$4.MangaReply> createMany($4.MangasRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$createMany, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$4.MangaReply> get($1.Id request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$4.MangaReply> update($1.Id request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$4.MangasReply> index($2.PaginateSearchQuery request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$4.MangaReply> findOrCreate($4.MangaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findOrCreate, request, options: options);
  }
}

abstract class MangaServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Manga';

  MangaServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.MangaRequest, $4.MangaReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.MangaRequest.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.MangasRequest, $4.MangaReply>(
        'CreateMany',
        createMany_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.MangasRequest.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Id, $4.MangaReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Id.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Id, $4.MangaReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Id.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.PaginateSearchQuery, $4.MangasReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.PaginateSearchQuery.fromBuffer(value),
        ($4.MangasReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.MangaRequest, $4.MangaReply>(
        'FindOrCreate',
        findOrCreate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.MangaRequest.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
  }

  $async.Future<$4.MangaReply> create_Pre(
      $grpc.ServiceCall call, $async.Future<$4.MangaRequest> request) async {
    return create(call, await request);
  }

  $async.Stream<$4.MangaReply> createMany_Pre(
      $grpc.ServiceCall call, $async.Future<$4.MangasRequest> request) async* {
    yield* createMany(call, await request);
  }

  $async.Future<$4.MangaReply> get_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Id> request) async {
    return get(call, await request);
  }

  $async.Future<$4.MangaReply> update_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Id> request) async {
    return update(call, await request);
  }

  $async.Future<$4.MangasReply> index_Pre($grpc.ServiceCall call,
      $async.Future<$2.PaginateSearchQuery> request) async {
    return index(call, await request);
  }

  $async.Future<$4.MangaReply> findOrCreate_Pre(
      $grpc.ServiceCall call, $async.Future<$4.MangaRequest> request) async {
    return findOrCreate(call, await request);
  }

  $async.Future<$4.MangaReply> create(
      $grpc.ServiceCall call, $4.MangaRequest request);
  $async.Stream<$4.MangaReply> createMany(
      $grpc.ServiceCall call, $4.MangasRequest request);
  $async.Future<$4.MangaReply> get($grpc.ServiceCall call, $1.Id request);
  $async.Future<$4.MangaReply> update($grpc.ServiceCall call, $1.Id request);
  $async.Future<$4.MangasReply> index(
      $grpc.ServiceCall call, $2.PaginateSearchQuery request);
  $async.Future<$4.MangaReply> findOrCreate(
      $grpc.ServiceCall call, $4.MangaRequest request);
}

class ChapterClient extends $grpc.Client {
  static final _$get = $grpc.ClientMethod<$5.ChapterRequest, $5.ChapterReply>(
      '/rumgap.Chapter/Get',
      ($5.ChapterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ChapterReply.fromBuffer(value));
  static final _$index =
      $grpc.ClientMethod<$5.PaginateChapterQuery, $5.ChaptersReply>(
          '/rumgap.Chapter/Index',
          ($5.PaginateChapterQuery value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $5.ChaptersReply.fromBuffer(value));
  static final _$images = $grpc.ClientMethod<$1.Id, $5.ImagesReply>(
      '/rumgap.Chapter/Images',
      ($1.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ImagesReply.fromBuffer(value));

  ChapterClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.ChapterReply> get($5.ChapterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$5.ChaptersReply> index($5.PaginateChapterQuery request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$index, request, options: options);
  }

  $grpc.ResponseFuture<$5.ImagesReply> images($1.Id request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$images, request, options: options);
  }
}

abstract class ChapterServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Chapter';

  ChapterServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.ChapterRequest, $5.ChapterReply>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.ChapterRequest.fromBuffer(value),
        ($5.ChapterReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.PaginateChapterQuery, $5.ChaptersReply>(
        'Index',
        index_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $5.PaginateChapterQuery.fromBuffer(value),
        ($5.ChaptersReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Id, $5.ImagesReply>(
        'Images',
        images_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Id.fromBuffer(value),
        ($5.ImagesReply value) => value.writeToBuffer()));
  }

  $async.Future<$5.ChapterReply> get_Pre(
      $grpc.ServiceCall call, $async.Future<$5.ChapterRequest> request) async {
    return get(call, await request);
  }

  $async.Future<$5.ChaptersReply> index_Pre($grpc.ServiceCall call,
      $async.Future<$5.PaginateChapterQuery> request) async {
    return index(call, await request);
  }

  $async.Future<$5.ImagesReply> images_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Id> request) async {
    return images(call, await request);
  }

  $async.Future<$5.ChapterReply> get(
      $grpc.ServiceCall call, $5.ChapterRequest request);
  $async.Future<$5.ChaptersReply> index(
      $grpc.ServiceCall call, $5.PaginateChapterQuery request);
  $async.Future<$5.ImagesReply> images($grpc.ServiceCall call, $1.Id request);
}

class ReadingClient extends $grpc.Client {
  static final _$update =
      $grpc.ClientMethod<$6.ReadingPatchRequest, $4.MangaReply>(
          '/rumgap.Reading/Update',
          ($6.ReadingPatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$create =
      $grpc.ClientMethod<$6.ReadingPostRequest, $4.MangaReply>(
          '/rumgap.Reading/Create',
          ($6.ReadingPostRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.MangaReply.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.Id, $1.Empty>(
      '/rumgap.Reading/Delete',
      ($1.Id value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  ReadingClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.MangaReply> update($6.ReadingPatchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$4.MangaReply> create($6.ReadingPostRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete($1.Id request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class ReadingServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Reading';

  ReadingServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.ReadingPatchRequest, $4.MangaReply>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.ReadingPatchRequest.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.ReadingPostRequest, $4.MangaReply>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $6.ReadingPostRequest.fromBuffer(value),
        ($4.MangaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Id, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Id.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.MangaReply> update_Pre($grpc.ServiceCall call,
      $async.Future<$6.ReadingPatchRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$4.MangaReply> create_Pre($grpc.ServiceCall call,
      $async.Future<$6.ReadingPostRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Id> request) async {
    return delete(call, await request);
  }

  $async.Future<$4.MangaReply> update(
      $grpc.ServiceCall call, $6.ReadingPatchRequest request);
  $async.Future<$4.MangaReply> create(
      $grpc.ServiceCall call, $6.ReadingPostRequest request);
  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $1.Id request);
}

class SearchClient extends $grpc.Client {
  static final _$manga = $grpc.ClientMethod<$7.SearchRequest, $7.SearchReply>(
      '/rumgap.Search/Manga',
      ($7.SearchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.SearchReply.fromBuffer(value));

  SearchClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.SearchReply> manga($7.SearchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$manga, request, options: options);
  }
}

abstract class SearchServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Search';

  SearchServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.SearchRequest, $7.SearchReply>(
        'Manga',
        manga_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.SearchRequest.fromBuffer(value),
        ($7.SearchReply value) => value.writeToBuffer()));
  }

  $async.Future<$7.SearchReply> manga_Pre(
      $grpc.ServiceCall call, $async.Future<$7.SearchRequest> request) async {
    return manga(call, await request);
  }

  $async.Future<$7.SearchReply> manga(
      $grpc.ServiceCall call, $7.SearchRequest request);
}

class MetaClient extends $grpc.Client {
  static final _$hostnames =
      $grpc.ClientMethod<$8.MetaHostnamesRequest, $8.MetaReply>(
          '/rumgap.Meta/Hostnames',
          ($8.MetaHostnamesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.MetaReply.fromBuffer(value));
  static final _$genres =
      $grpc.ClientMethod<$8.MetaGenresRequest, $8.MetaReply>(
          '/rumgap.Meta/Genres',
          ($8.MetaGenresRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $8.MetaReply.fromBuffer(value));
  static final _$stats = $grpc.ClientMethod<$1.Empty, $8.StatsReply>(
      '/rumgap.Meta/Stats',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.StatsReply.fromBuffer(value));

  MetaClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$8.MetaReply> hostnames($8.MetaHostnamesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hostnames, request, options: options);
  }

  $grpc.ResponseFuture<$8.MetaReply> genres($8.MetaGenresRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$genres, request, options: options);
  }

  $grpc.ResponseFuture<$8.StatsReply> stats($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stats, request, options: options);
  }
}

abstract class MetaServiceBase extends $grpc.Service {
  $core.String get $name => 'rumgap.Meta';

  MetaServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.MetaHostnamesRequest, $8.MetaReply>(
        'Hostnames',
        hostnames_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $8.MetaHostnamesRequest.fromBuffer(value),
        ($8.MetaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$8.MetaGenresRequest, $8.MetaReply>(
        'Genres',
        genres_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.MetaGenresRequest.fromBuffer(value),
        ($8.MetaReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $8.StatsReply>(
        'Stats',
        stats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($8.StatsReply value) => value.writeToBuffer()));
  }

  $async.Future<$8.MetaReply> hostnames_Pre($grpc.ServiceCall call,
      $async.Future<$8.MetaHostnamesRequest> request) async {
    return hostnames(call, await request);
  }

  $async.Future<$8.MetaReply> genres_Pre($grpc.ServiceCall call,
      $async.Future<$8.MetaGenresRequest> request) async {
    return genres(call, await request);
  }

  $async.Future<$8.StatsReply> stats_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return stats(call, await request);
  }

  $async.Future<$8.MetaReply> hostnames(
      $grpc.ServiceCall call, $8.MetaHostnamesRequest request);
  $async.Future<$8.MetaReply> genres(
      $grpc.ServiceCall call, $8.MetaGenresRequest request);
  $async.Future<$8.StatsReply> stats($grpc.ServiceCall call, $1.Empty request);
}
