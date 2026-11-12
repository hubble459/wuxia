// This is a generated file - do not edit.
//
// Generated from rumgap/v1/comment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use commentReplyDescriptor instead')
const CommentReply$json = {
  '1': 'CommentReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'manga_id', '3': 2, '4': 1, '5': 5, '10': 'mangaId'},
    {
      '1': 'parent_id',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'parentId',
      '17': true
    },
    {
      '1': 'user_id',
      '3': 4,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'userId',
      '17': true
    },
    {'1': 'username', '3': 5, '4': 1, '5': 9, '10': 'username'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    {
      '1': 'edited_at',
      '3': 8,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'editedAt',
      '17': true
    },
    {'1': 'deleted', '3': 9, '4': 1, '5': 8, '10': 'deleted'},
    {'1': 'reply_count', '3': 10, '4': 1, '5': 3, '10': 'replyCount'},
    {'1': 'is_mine', '3': 11, '4': 1, '5': 8, '10': 'isMine'},
    {'1': 'can_delete', '3': 12, '4': 1, '5': 8, '10': 'canDelete'},
  ],
  '8': [
    {'1': '_parent_id'},
    {'1': '_user_id'},
    {'1': '_edited_at'},
  ],
};

/// Descriptor for `CommentReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentReplyDescriptor = $convert.base64Decode(
    'CgxDb21tZW50UmVwbHkSDgoCaWQYASABKAVSAmlkEhkKCG1hbmdhX2lkGAIgASgFUgdtYW5nYU'
    'lkEiAKCXBhcmVudF9pZBgDIAEoBUgAUghwYXJlbnRJZIgBARIcCgd1c2VyX2lkGAQgASgFSAFS'
    'BnVzZXJJZIgBARIaCgh1c2VybmFtZRgFIAEoCVIIdXNlcm5hbWUSEgoEYm9keRgGIAEoCVIEYm'
    '9keRIdCgpjcmVhdGVkX2F0GAcgASgDUgljcmVhdGVkQXQSIAoJZWRpdGVkX2F0GAggASgDSAJS'
    'CGVkaXRlZEF0iAEBEhgKB2RlbGV0ZWQYCSABKAhSB2RlbGV0ZWQSHwoLcmVwbHlfY291bnQYCi'
    'ABKANSCnJlcGx5Q291bnQSFwoHaXNfbWluZRgLIAEoCFIGaXNNaW5lEh0KCmNhbl9kZWxldGUY'
    'DCABKAhSCWNhbkRlbGV0ZUIMCgpfcGFyZW50X2lkQgoKCF91c2VyX2lkQgwKCl9lZGl0ZWRfYX'
    'Q=');

@$core.Deprecated('Use listCommentsRequestDescriptor instead')
const ListCommentsRequest$json = {
  '1': 'ListCommentsRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {
      '1': 'parent_id',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'parentId',
      '17': true
    },
    {'1': 'page', '3': 3, '4': 1, '5': 4, '9': 1, '10': 'page', '17': true},
    {
      '1': 'per_page',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'perPage',
      '17': true
    },
  ],
  '8': [
    {'1': '_parent_id'},
    {'1': '_page'},
    {'1': '_per_page'},
  ],
};

/// Descriptor for `ListCommentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCommentsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0Q29tbWVudHNSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEiAKCXBhcm'
    'VudF9pZBgCIAEoBUgAUghwYXJlbnRJZIgBARIXCgRwYWdlGAMgASgESAFSBHBhZ2WIAQESHgoI'
    'cGVyX3BhZ2UYBCABKARIAlIHcGVyUGFnZYgBAUIMCgpfcGFyZW50X2lkQgcKBV9wYWdlQgsKCV'
    '9wZXJfcGFnZQ==');

@$core.Deprecated('Use commentsReplyDescriptor instead')
const CommentsReply$json = {
  '1': 'CommentsReply',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.PaginateReply',
      '10': 'pagination'
    },
    {
      '1': 'items',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.CommentReply',
      '10': 'items'
    },
    {'1': 'total_comments', '3': 3, '4': 1, '5': 3, '10': 'totalComments'},
  ],
};

/// Descriptor for `CommentsReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentsReplyDescriptor = $convert.base64Decode(
    'Cg1Db21tZW50c1JlcGx5EjgKCnBhZ2luYXRpb24YASABKAsyGC5ydW1nYXAudjEuUGFnaW5hdG'
    'VSZXBseVIKcGFnaW5hdGlvbhItCgVpdGVtcxgCIAMoCzIXLnJ1bWdhcC52MS5Db21tZW50UmVw'
    'bHlSBWl0ZW1zEiUKDnRvdGFsX2NvbW1lbnRzGAMgASgDUg10b3RhbENvbW1lbnRz');

@$core.Deprecated('Use getCommentRequestDescriptor instead')
const GetCommentRequest$json = {
  '1': 'GetCommentRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `GetCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCommentRequestDescriptor =
    $convert.base64Decode('ChFHZXRDb21tZW50UmVxdWVzdBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use commentThreadReplyDescriptor instead')
const CommentThreadReply$json = {
  '1': 'CommentThreadReply',
  '2': [
    {
      '1': 'comment',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.CommentReply',
      '10': 'comment'
    },
    {
      '1': 'ancestors',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.CommentReply',
      '10': 'ancestors'
    },
  ],
};

/// Descriptor for `CommentThreadReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commentThreadReplyDescriptor = $convert.base64Decode(
    'ChJDb21tZW50VGhyZWFkUmVwbHkSMQoHY29tbWVudBgBIAEoCzIXLnJ1bWdhcC52MS5Db21tZW'
    '50UmVwbHlSB2NvbW1lbnQSNQoJYW5jZXN0b3JzGAIgAygLMhcucnVtZ2FwLnYxLkNvbW1lbnRS'
    'ZXBseVIJYW5jZXN0b3Jz');

@$core.Deprecated('Use createCommentRequestDescriptor instead')
const CreateCommentRequest$json = {
  '1': 'CreateCommentRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {
      '1': 'parent_id',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'parentId',
      '17': true
    },
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
  ],
  '8': [
    {'1': '_parent_id'},
  ],
};

/// Descriptor for `CreateCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCommentRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVDb21tZW50UmVxdWVzdBIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZBIgCglwYX'
    'JlbnRfaWQYAiABKAVIAFIIcGFyZW50SWSIAQESEgoEYm9keRgDIAEoCVIEYm9keUIMCgpfcGFy'
    'ZW50X2lk');

@$core.Deprecated('Use editCommentRequestDescriptor instead')
const EditCommentRequest$json = {
  '1': 'EditCommentRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `EditCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editCommentRequestDescriptor = $convert.base64Decode(
    'ChJFZGl0Q29tbWVudFJlcXVlc3QSDgoCaWQYASABKAVSAmlkEhIKBGJvZHkYAiABKAlSBGJvZH'
    'k=');

@$core.Deprecated('Use deleteCommentRequestDescriptor instead')
const DeleteCommentRequest$json = {
  '1': 'DeleteCommentRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `DeleteCommentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCommentRequestDescriptor = $convert
    .base64Decode('ChREZWxldGVDb21tZW50UmVxdWVzdBIOCgJpZBgBIAEoBVICaWQ=');
