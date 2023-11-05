//
//  Generated code. Do not modify.
//  source: rumgap/v1/user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userRegisterRequestDescriptor instead')
const UserRegisterRequest$json = {
  '1': 'UserRegisterRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `UserRegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterRequestDescriptor = $convert.base64Decode(
    'ChNVc2VyUmVnaXN0ZXJSZXF1ZXN0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIaCghwYX'
    'Nzd29yZBgCIAEoCVIIcGFzc3dvcmQSFAoFZW1haWwYAyABKAlSBWVtYWls');

@$core.Deprecated('Use deviceTokenRequestDescriptor instead')
const DeviceTokenRequest$json = {
  '1': 'DeviceTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `DeviceTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceTokenRequestDescriptor = $convert.base64Decode(
    'ChJEZXZpY2VUb2tlblJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2Vu');

@$core.Deprecated('Use userRequestDescriptor instead')
const UserRequest$json = {
  '1': 'UserRequest',
  '2': [
    {'1': 'password', '3': 1, '4': 1, '5': 9, '10': 'password'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'username'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'email'},
  ],
  '8': [
    {'1': 'identifier'},
  ],
};

/// Descriptor for `UserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRequestDescriptor = $convert.base64Decode(
    'CgtVc2VyUmVxdWVzdBIaCghwYXNzd29yZBgBIAEoCVIIcGFzc3dvcmQSHAoIdXNlcm5hbWUYAi'
    'ABKAlIAFIIdXNlcm5hbWUSFgoFZW1haWwYAyABKAlIAFIFZW1haWxCDAoKaWRlbnRpZmllcg==');

@$core.Deprecated('Use userUpdateRequestDescriptor instead')
const UserUpdateRequest$json = {
  '1': 'UserUpdateRequest',
  '2': [
    {'1': 'password', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'password', '17': true},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'username', '17': true},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'email', '17': true},
    {'1': 'preferred_hostnames', '3': 4, '4': 3, '5': 9, '10': 'preferredHostnames'},
    {'1': 'device_ids', '3': 5, '4': 3, '5': 9, '10': 'deviceIds'},
  ],
  '8': [
    {'1': '_password'},
    {'1': '_username'},
    {'1': '_email'},
  ],
};

/// Descriptor for `UserUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdateRequestDescriptor = $convert.base64Decode(
    'ChFVc2VyVXBkYXRlUmVxdWVzdBIfCghwYXNzd29yZBgBIAEoCUgAUghwYXNzd29yZIgBARIfCg'
    'h1c2VybmFtZRgCIAEoCUgBUgh1c2VybmFtZYgBARIZCgVlbWFpbBgDIAEoCUgCUgVlbWFpbIgB'
    'ARIvChNwcmVmZXJyZWRfaG9zdG5hbWVzGAQgAygJUhJwcmVmZXJyZWRIb3N0bmFtZXMSHQoKZG'
    'V2aWNlX2lkcxgFIAMoCVIJZGV2aWNlSWRzQgsKCV9wYXNzd29yZEILCglfdXNlcm5hbWVCCAoG'
    'X2VtYWls');

@$core.Deprecated('Use userReplyDescriptor instead')
const UserReply$json = {
  '1': 'UserReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'permissions', '3': 4, '4': 1, '5': 5, '10': 'permissions'},
    {'1': 'preferred_hostnames', '3': 5, '4': 3, '5': 9, '10': 'preferredHostnames'},
    {'1': 'device_ids', '3': 6, '4': 3, '5': 9, '10': 'deviceIds'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 8, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UserReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReplyDescriptor = $convert.base64Decode(
    'CglVc2VyUmVwbHkSDgoCaWQYASABKAVSAmlkEhoKCHVzZXJuYW1lGAIgASgJUgh1c2VybmFtZR'
    'IUCgVlbWFpbBgDIAEoCVIFZW1haWwSIAoLcGVybWlzc2lvbnMYBCABKAVSC3Blcm1pc3Npb25z'
    'Ei8KE3ByZWZlcnJlZF9ob3N0bmFtZXMYBSADKAlSEnByZWZlcnJlZEhvc3RuYW1lcxIdCgpkZX'
    'ZpY2VfaWRzGAYgAygJUglkZXZpY2VJZHMSHQoKY3JlYXRlZF9hdBgHIAEoA1IJY3JlYXRlZEF0'
    'Eh0KCnVwZGF0ZWRfYXQYCCABKANSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use userFullReplyDescriptor instead')
const UserFullReply$json = {
  '1': 'UserFullReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'permissions', '3': 4, '4': 1, '5': 5, '10': 'permissions'},
    {'1': 'preferred_hostnames', '3': 5, '4': 3, '5': 9, '10': 'preferredHostnames'},
    {'1': 'device_ids', '3': 6, '4': 3, '5': 9, '10': 'deviceIds'},
    {'1': 'count_following', '3': 7, '4': 1, '5': 3, '10': 'countFollowing'},
    {'1': 'count_followers', '3': 8, '4': 1, '5': 3, '10': 'countFollowers'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UserFullReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFullReplyDescriptor = $convert.base64Decode(
    'Cg1Vc2VyRnVsbFJlcGx5Eg4KAmlkGAEgASgFUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm'
    '5hbWUSFAoFZW1haWwYAyABKAlSBWVtYWlsEiAKC3Blcm1pc3Npb25zGAQgASgFUgtwZXJtaXNz'
    'aW9ucxIvChNwcmVmZXJyZWRfaG9zdG5hbWVzGAUgAygJUhJwcmVmZXJyZWRIb3N0bmFtZXMSHQ'
    'oKZGV2aWNlX2lkcxgGIAMoCVIJZGV2aWNlSWRzEicKD2NvdW50X2ZvbGxvd2luZxgHIAEoA1IO'
    'Y291bnRGb2xsb3dpbmcSJwoPY291bnRfZm9sbG93ZXJzGAggASgDUg5jb3VudEZvbGxvd2Vycx'
    'IdCgpjcmVhdGVkX2F0GAkgASgDUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgKIAEoA1IJdXBk'
    'YXRlZEF0');

@$core.Deprecated('Use userTokenReplyDescriptor instead')
const UserTokenReply$json = {
  '1': 'UserTokenReply',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.rumgap.v1.UserFullReply', '10': 'user'},
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `UserTokenReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTokenReplyDescriptor = $convert.base64Decode(
    'Cg5Vc2VyVG9rZW5SZXBseRIsCgR1c2VyGAEgASgLMhgucnVtZ2FwLnYxLlVzZXJGdWxsUmVwbH'
    'lSBHVzZXISFAoFdG9rZW4YAiABKAlSBXRva2Vu');

@$core.Deprecated('Use usersReplyDescriptor instead')
const UsersReply$json = {
  '1': 'UsersReply',
  '2': [
    {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.v1.PaginateReply', '10': 'pagination'},
    {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.v1.UserReply', '10': 'items'},
  ],
};

/// Descriptor for `UsersReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersReplyDescriptor = $convert.base64Decode(
    'CgpVc2Vyc1JlcGx5EjgKCnBhZ2luYXRpb24YASABKAsyGC5ydW1nYXAudjEuUGFnaW5hdGVSZX'
    'BseVIKcGFnaW5hdGlvbhIqCgVpdGVtcxgCIAMoCzIULnJ1bWdhcC52MS5Vc2VyUmVwbHlSBWl0'
    'ZW1z');

