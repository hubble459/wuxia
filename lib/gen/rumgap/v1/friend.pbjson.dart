// This is a generated file - do not edit.
//
// Generated from rumgap/v1/friend.proto.

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

@$core.Deprecated('Use friendRequestDescriptor instead')
const FriendRequest$json = {
  '1': 'FriendRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    {
      '1': 'username',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'username',
      '17': true
    },
  ],
  '8': [
    {'1': '_username'},
  ],
};

/// Descriptor for `FriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendRequestDescriptor = $convert.base64Decode(
    'Cg1GcmllbmRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAVSBnVzZXJJZBIfCgh1c2VybmFtZRgCIA'
    'EoCUgAUgh1c2VybmFtZYgBAUILCglfdXNlcm5hbWU=');

@$core.Deprecated('Use userSummaryDescriptor instead')
const UserSummary$json = {
  '1': 'UserSummary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'is_private', '3': 3, '4': 1, '5': 8, '10': 'isPrivate'},
    {'1': 'followed_by_me', '3': 4, '4': 1, '5': 8, '10': 'followedByMe'},
    {'1': 'follows_me', '3': 5, '4': 1, '5': 8, '10': 'followsMe'},
    {'1': 'since', '3': 6, '4': 1, '5': 3, '10': 'since'},
  ],
};

/// Descriptor for `UserSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSummaryDescriptor = $convert.base64Decode(
    'CgtVc2VyU3VtbWFyeRIOCgJpZBgBIAEoBVICaWQSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW'
    '1lEh0KCmlzX3ByaXZhdGUYAyABKAhSCWlzUHJpdmF0ZRIkCg5mb2xsb3dlZF9ieV9tZRgEIAEo'
    'CFIMZm9sbG93ZWRCeU1lEh0KCmZvbGxvd3NfbWUYBSABKAhSCWZvbGxvd3NNZRIUCgVzaW5jZR'
    'gGIAEoA1IFc2luY2U=');

@$core.Deprecated('Use userSummariesReplyDescriptor instead')
const UserSummariesReply$json = {
  '1': 'UserSummariesReply',
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
      '6': '.rumgap.v1.UserSummary',
      '10': 'items'
    },
  ],
};

/// Descriptor for `UserSummariesReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSummariesReplyDescriptor = $convert.base64Decode(
    'ChJVc2VyU3VtbWFyaWVzUmVwbHkSOAoKcGFnaW5hdGlvbhgBIAEoCzIYLnJ1bWdhcC52MS5QYW'
    'dpbmF0ZVJlcGx5UgpwYWdpbmF0aW9uEiwKBWl0ZW1zGAIgAygLMhYucnVtZ2FwLnYxLlVzZXJT'
    'dW1tYXJ5UgVpdGVtcw==');

@$core.Deprecated('Use profileRequestDescriptor instead')
const ProfileRequest$json = {
  '1': 'ProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'username'},
    {
      '1': 'utc_offset_minutes',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'utcOffsetMinutes'
    },
  ],
  '8': [
    {'1': 'user'},
  ],
};

/// Descriptor for `ProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileRequestDescriptor = $convert.base64Decode(
    'Cg5Qcm9maWxlUmVxdWVzdBIZCgd1c2VyX2lkGAEgASgFSABSBnVzZXJJZBIcCgh1c2VybmFtZR'
    'gCIAEoCUgAUgh1c2VybmFtZRIsChJ1dGNfb2Zmc2V0X21pbnV0ZXMYAyABKAVSEHV0Y09mZnNl'
    'dE1pbnV0ZXNCBgoEdXNlcg==');

@$core.Deprecated('Use profileReplyDescriptor instead')
const ProfileReply$json = {
  '1': 'ProfileReply',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.UserSummary',
      '10': 'user'
    },
    {'1': 'count_following', '3': 2, '4': 1, '5': 3, '10': 'countFollowing'},
    {'1': 'count_followers', '3': 3, '4': 1, '5': 3, '10': 'countFollowers'},
    {'1': 'member_since', '3': 4, '4': 1, '5': 3, '10': 'memberSince'},
    {'1': 'is_me', '3': 5, '4': 1, '5': 8, '10': 'isMe'},
    {'1': 'visible', '3': 6, '4': 1, '5': 8, '10': 'visible'},
    {
      '1': 'stats',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.DetailedStatsReply',
      '9': 0,
      '10': 'stats',
      '17': true
    },
  ],
  '8': [
    {'1': '_stats'},
  ],
};

/// Descriptor for `ProfileReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List profileReplyDescriptor = $convert.base64Decode(
    'CgxQcm9maWxlUmVwbHkSKgoEdXNlchgBIAEoCzIWLnJ1bWdhcC52MS5Vc2VyU3VtbWFyeVIEdX'
    'NlchInCg9jb3VudF9mb2xsb3dpbmcYAiABKANSDmNvdW50Rm9sbG93aW5nEicKD2NvdW50X2Zv'
    'bGxvd2VycxgDIAEoA1IOY291bnRGb2xsb3dlcnMSIQoMbWVtYmVyX3NpbmNlGAQgASgDUgttZW'
    '1iZXJTaW5jZRITCgVpc19tZRgFIAEoCFIEaXNNZRIYCgd2aXNpYmxlGAYgASgIUgd2aXNpYmxl'
    'EjgKBXN0YXRzGAcgASgLMh0ucnVtZ2FwLnYxLkRldGFpbGVkU3RhdHNSZXBseUgAUgVzdGF0c4'
    'gBAUIICgZfc3RhdHM=');
