// This is a generated file - do not edit.
//
// Generated from rumgap/v1/comment.proto.

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

class CommentReply extends $pb.GeneratedMessage {
  factory CommentReply({
    $core.int? id,
    $core.int? mangaId,
    $core.int? parentId,
    $core.int? userId,
    $core.String? username,
    $core.String? body,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? editedAt,
    $core.bool? deleted,
    $fixnum.Int64? replyCount,
    $core.bool? isMine,
    $core.bool? canDelete,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (mangaId != null) result.mangaId = mangaId;
    if (parentId != null) result.parentId = parentId;
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (body != null) result.body = body;
    if (createdAt != null) result.createdAt = createdAt;
    if (editedAt != null) result.editedAt = editedAt;
    if (deleted != null) result.deleted = deleted;
    if (replyCount != null) result.replyCount = replyCount;
    if (isMine != null) result.isMine = isMine;
    if (canDelete != null) result.canDelete = canDelete;
    return result;
  }

  CommentReply._();

  factory CommentReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommentReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommentReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'mangaId')
    ..aI(3, _omitFieldNames ? '' : 'parentId')
    ..aI(4, _omitFieldNames ? '' : 'userId')
    ..aOS(5, _omitFieldNames ? '' : 'username')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aInt64(7, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(8, _omitFieldNames ? '' : 'editedAt')
    ..aOB(9, _omitFieldNames ? '' : 'deleted')
    ..aInt64(10, _omitFieldNames ? '' : 'replyCount')
    ..aOB(11, _omitFieldNames ? '' : 'isMine')
    ..aOB(12, _omitFieldNames ? '' : 'canDelete')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentReply copyWith(void Function(CommentReply) updates) =>
      super.copyWith((message) => updates(message as CommentReply))
          as CommentReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommentReply create() => CommentReply._();
  @$core.override
  CommentReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommentReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommentReply>(create);
  static CommentReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get mangaId => $_getIZ(1);
  @$pb.TagNumber(2)
  set mangaId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMangaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMangaId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get parentId => $_getIZ(2);
  @$pb.TagNumber(3)
  set parentId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearParentId() => $_clearField(3);

  /// Unset once the author's account is gone.
  @$pb.TagNumber(4)
  $core.int get userId => $_getIZ(3);
  @$pb.TagNumber(4)
  set userId($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get username => $_getSZ(4);
  @$pb.TagNumber(5)
  set username($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUsername() => $_has(4);
  @$pb.TagNumber(5)
  void clearUsername() => $_clearField(5);

  /// Empty when deleted.
  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get editedAt => $_getI64(7);
  @$pb.TagNumber(8)
  set editedAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasEditedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearEditedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get deleted => $_getBF(8);
  @$pb.TagNumber(9)
  set deleted($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDeleted() => $_has(8);
  @$pb.TagNumber(9)
  void clearDeleted() => $_clearField(9);

  /// Direct replies only.
  @$pb.TagNumber(10)
  $fixnum.Int64 get replyCount => $_getI64(9);
  @$pb.TagNumber(10)
  set replyCount($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReplyCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearReplyCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isMine => $_getBF(10);
  @$pb.TagNumber(11)
  set isMine($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsMine() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsMine() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get canDelete => $_getBF(11);
  @$pb.TagNumber(12)
  set canDelete($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCanDelete() => $_has(11);
  @$pb.TagNumber(12)
  void clearCanDelete() => $_clearField(12);
}

class ListCommentsRequest extends $pb.GeneratedMessage {
  factory ListCommentsRequest({
    $core.int? mangaId,
    $core.int? parentId,
    $fixnum.Int64? page,
    $fixnum.Int64? perPage,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (parentId != null) result.parentId = parentId;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  ListCommentsRequest._();

  factory ListCommentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCommentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCommentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aI(2, _omitFieldNames ? '' : 'parentId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCommentsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCommentsRequest copyWith(void Function(ListCommentsRequest) updates) =>
      super.copyWith((message) => updates(message as ListCommentsRequest))
          as ListCommentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCommentsRequest create() => ListCommentsRequest._();
  @$core.override
  ListCommentsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListCommentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCommentsRequest>(create);
  static ListCommentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  /// Replies to this comment, oldest first; top-level comments (newest first) when unset.
  @$pb.TagNumber(2)
  $core.int get parentId => $_getIZ(1);
  @$pb.TagNumber(2)
  set parentId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get page => $_getI64(2);
  @$pb.TagNumber(3)
  set page($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get perPage => $_getI64(3);
  @$pb.TagNumber(4)
  set perPage($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => $_clearField(4);
}

class CommentsReply extends $pb.GeneratedMessage {
  factory CommentsReply({
    $0.PaginateReply? pagination,
    $core.Iterable<CommentReply>? items,
    $fixnum.Int64? totalComments,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (items != null) result.items.addAll(items);
    if (totalComments != null) result.totalComments = totalComments;
    return result;
  }

  CommentsReply._();

  factory CommentsReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommentsReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommentsReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<$0.PaginateReply>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginateReply.create)
    ..pPM<CommentReply>(2, _omitFieldNames ? '' : 'items',
        subBuilder: CommentReply.create)
    ..aInt64(3, _omitFieldNames ? '' : 'totalComments')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentsReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentsReply copyWith(void Function(CommentsReply) updates) =>
      super.copyWith((message) => updates(message as CommentsReply))
          as CommentsReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommentsReply create() => CommentsReply._();
  @$core.override
  CommentsReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommentsReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommentsReply>(create);
  static CommentsReply? _defaultInstance;

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
  $pb.PbList<CommentReply> get items => $_getList(1);

  /// Every comment on the manga, replies included.
  @$pb.TagNumber(3)
  $fixnum.Int64 get totalComments => $_getI64(2);
  @$pb.TagNumber(3)
  set totalComments($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalComments() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalComments() => $_clearField(3);
}

class GetCommentRequest extends $pb.GeneratedMessage {
  factory GetCommentRequest({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetCommentRequest._();

  factory GetCommentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCommentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCommentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommentRequest copyWith(void Function(GetCommentRequest) updates) =>
      super.copyWith((message) => updates(message as GetCommentRequest))
          as GetCommentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCommentRequest create() => GetCommentRequest._();
  @$core.override
  GetCommentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetCommentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCommentRequest>(create);
  static GetCommentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class CommentThreadReply extends $pb.GeneratedMessage {
  factory CommentThreadReply({
    CommentReply? comment,
    $core.Iterable<CommentReply>? ancestors,
  }) {
    final result = create();
    if (comment != null) result.comment = comment;
    if (ancestors != null) result.ancestors.addAll(ancestors);
    return result;
  }

  CommentThreadReply._();

  factory CommentThreadReply.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommentThreadReply.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommentThreadReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aOM<CommentReply>(1, _omitFieldNames ? '' : 'comment',
        subBuilder: CommentReply.create)
    ..pPM<CommentReply>(2, _omitFieldNames ? '' : 'ancestors',
        subBuilder: CommentReply.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentThreadReply clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommentThreadReply copyWith(void Function(CommentThreadReply) updates) =>
      super.copyWith((message) => updates(message as CommentThreadReply))
          as CommentThreadReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommentThreadReply create() => CommentThreadReply._();
  @$core.override
  CommentThreadReply createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CommentThreadReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommentThreadReply>(create);
  static CommentThreadReply? _defaultInstance;

  @$pb.TagNumber(1)
  CommentReply get comment => $_getN(0);
  @$pb.TagNumber(1)
  set comment(CommentReply value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasComment() => $_has(0);
  @$pb.TagNumber(1)
  void clearComment() => $_clearField(1);
  @$pb.TagNumber(1)
  CommentReply ensureComment() => $_ensure(0);

  /// From the top-level comment down to `comment`'s parent.
  @$pb.TagNumber(2)
  $pb.PbList<CommentReply> get ancestors => $_getList(1);
}

class CreateCommentRequest extends $pb.GeneratedMessage {
  factory CreateCommentRequest({
    $core.int? mangaId,
    $core.int? parentId,
    $core.String? body,
  }) {
    final result = create();
    if (mangaId != null) result.mangaId = mangaId;
    if (parentId != null) result.parentId = parentId;
    if (body != null) result.body = body;
    return result;
  }

  CreateCommentRequest._();

  factory CreateCommentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCommentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCommentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'mangaId')
    ..aI(2, _omitFieldNames ? '' : 'parentId')
    ..aOS(3, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCommentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCommentRequest copyWith(void Function(CreateCommentRequest) updates) =>
      super.copyWith((message) => updates(message as CreateCommentRequest))
          as CreateCommentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCommentRequest create() => CreateCommentRequest._();
  @$core.override
  CreateCommentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateCommentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCommentRequest>(create);
  static CreateCommentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get mangaId => $_getIZ(0);
  @$pb.TagNumber(1)
  set mangaId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMangaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMangaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get parentId => $_getIZ(1);
  @$pb.TagNumber(2)
  set parentId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => $_clearField(3);
}

class EditCommentRequest extends $pb.GeneratedMessage {
  factory EditCommentRequest({
    $core.int? id,
    $core.String? body,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (body != null) result.body = body;
    return result;
  }

  EditCommentRequest._();

  factory EditCommentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EditCommentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditCommentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditCommentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditCommentRequest copyWith(void Function(EditCommentRequest) updates) =>
      super.copyWith((message) => updates(message as EditCommentRequest))
          as EditCommentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EditCommentRequest create() => EditCommentRequest._();
  @$core.override
  EditCommentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EditCommentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditCommentRequest>(create);
  static EditCommentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);
}

class DeleteCommentRequest extends $pb.GeneratedMessage {
  factory DeleteCommentRequest({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteCommentRequest._();

  factory DeleteCommentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCommentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCommentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rumgap.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCommentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCommentRequest copyWith(void Function(DeleteCommentRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteCommentRequest))
          as DeleteCommentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCommentRequest create() => DeleteCommentRequest._();
  @$core.override
  DeleteCommentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteCommentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCommentRequest>(create);
  static DeleteCommentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
