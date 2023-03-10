///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userRegisterRequestDescriptor instead')
const UserRegisterRequest$json = const {
  '1': 'UserRegisterRequest',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `UserRegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRegisterRequestDescriptor = $convert.base64Decode('ChNVc2VyUmVnaXN0ZXJSZXF1ZXN0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQSFAoFZW1haWwYAyABKAlSBWVtYWls');
@$core.Deprecated('Use deviceTokenRequestDescriptor instead')
const DeviceTokenRequest$json = const {
  '1': 'DeviceTokenRequest',
  '2': const [
    const {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `DeviceTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceTokenRequestDescriptor = $convert.base64Decode('ChJEZXZpY2VUb2tlblJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2Vu');
@$core.Deprecated('Use userRequestDescriptor instead')
const UserRequest$json = const {
  '1': 'UserRequest',
  '2': const [
    const {'1': 'password', '3': 1, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'username'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'email'},
  ],
  '8': const [
    const {'1': 'identifier'},
  ],
};

/// Descriptor for `UserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRequestDescriptor = $convert.base64Decode('CgtVc2VyUmVxdWVzdBIaCghwYXNzd29yZBgBIAEoCVIIcGFzc3dvcmQSHAoIdXNlcm5hbWUYAiABKAlIAFIIdXNlcm5hbWUSFgoFZW1haWwYAyABKAlIAFIFZW1haWxCDAoKaWRlbnRpZmllcg==');
@$core.Deprecated('Use userUpdateRequestDescriptor instead')
const UserUpdateRequest$json = const {
  '1': 'UserUpdateRequest',
  '2': const [
    const {'1': 'password', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'password', '17': true},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'username', '17': true},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'email', '17': true},
    const {'1': 'preferred_hostnames', '3': 4, '4': 3, '5': 9, '10': 'preferredHostnames'},
    const {'1': 'device_ids', '3': 5, '4': 3, '5': 9, '10': 'deviceIds'},
  ],
  '8': const [
    const {'1': '_password'},
    const {'1': '_username'},
    const {'1': '_email'},
  ],
};

/// Descriptor for `UserUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdateRequestDescriptor = $convert.base64Decode('ChFVc2VyVXBkYXRlUmVxdWVzdBIfCghwYXNzd29yZBgBIAEoCUgAUghwYXNzd29yZIgBARIfCgh1c2VybmFtZRgCIAEoCUgBUgh1c2VybmFtZYgBARIZCgVlbWFpbBgDIAEoCUgCUgVlbWFpbIgBARIvChNwcmVmZXJyZWRfaG9zdG5hbWVzGAQgAygJUhJwcmVmZXJyZWRIb3N0bmFtZXMSHQoKZGV2aWNlX2lkcxgFIAMoCVIJZGV2aWNlSWRzQgsKCV9wYXNzd29yZEILCglfdXNlcm5hbWVCCAoGX2VtYWls');
@$core.Deprecated('Use userReplyDescriptor instead')
const UserReply$json = const {
  '1': 'UserReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'permissions', '3': 4, '4': 1, '5': 5, '10': 'permissions'},
    const {'1': 'preferred_hostnames', '3': 5, '4': 3, '5': 9, '10': 'preferredHostnames'},
    const {'1': 'device_ids', '3': 6, '4': 3, '5': 9, '10': 'deviceIds'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UserReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userReplyDescriptor = $convert.base64Decode('CglVc2VyUmVwbHkSDgoCaWQYASABKAVSAmlkEhoKCHVzZXJuYW1lGAIgASgJUgh1c2VybmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSIAoLcGVybWlzc2lvbnMYBCABKAVSC3Blcm1pc3Npb25zEi8KE3ByZWZlcnJlZF9ob3N0bmFtZXMYBSADKAlSEnByZWZlcnJlZEhvc3RuYW1lcxIdCgpkZXZpY2VfaWRzGAYgAygJUglkZXZpY2VJZHMSHQoKY3JlYXRlZF9hdBgHIAEoA1IJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCCABKANSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use userFullReplyDescriptor instead')
const UserFullReply$json = const {
  '1': 'UserFullReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'permissions', '3': 4, '4': 1, '5': 5, '10': 'permissions'},
    const {'1': 'preferred_hostnames', '3': 5, '4': 3, '5': 9, '10': 'preferredHostnames'},
    const {'1': 'device_ids', '3': 6, '4': 3, '5': 9, '10': 'deviceIds'},
    const {'1': 'count_following', '3': 7, '4': 1, '5': 3, '10': 'countFollowing'},
    const {'1': 'count_followers', '3': 8, '4': 1, '5': 3, '10': 'countFollowers'},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UserFullReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFullReplyDescriptor = $convert.base64Decode('Cg1Vc2VyRnVsbFJlcGx5Eg4KAmlkGAEgASgFUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSFAoFZW1haWwYAyABKAlSBWVtYWlsEiAKC3Blcm1pc3Npb25zGAQgASgFUgtwZXJtaXNzaW9ucxIvChNwcmVmZXJyZWRfaG9zdG5hbWVzGAUgAygJUhJwcmVmZXJyZWRIb3N0bmFtZXMSHQoKZGV2aWNlX2lkcxgGIAMoCVIJZGV2aWNlSWRzEicKD2NvdW50X2ZvbGxvd2luZxgHIAEoA1IOY291bnRGb2xsb3dpbmcSJwoPY291bnRfZm9sbG93ZXJzGAggASgDUg5jb3VudEZvbGxvd2VycxIdCgpjcmVhdGVkX2F0GAkgASgDUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgKIAEoA1IJdXBkYXRlZEF0');
@$core.Deprecated('Use userTokenReplyDescriptor instead')
const UserTokenReply$json = const {
  '1': 'UserTokenReply',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.rumgap.UserFullReply', '10': 'user'},
    const {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `UserTokenReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userTokenReplyDescriptor = $convert.base64Decode('Cg5Vc2VyVG9rZW5SZXBseRIpCgR1c2VyGAEgASgLMhUucnVtZ2FwLlVzZXJGdWxsUmVwbHlSBHVzZXISFAoFdG9rZW4YAiABKAlSBXRva2Vu');
@$core.Deprecated('Use usersReplyDescriptor instead')
const UsersReply$json = const {
  '1': 'UsersReply',
  '2': const [
    const {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.PaginateReply', '10': 'pagination'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.UserReply', '10': 'items'},
  ],
};

/// Descriptor for `UsersReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersReplyDescriptor = $convert.base64Decode('CgpVc2Vyc1JlcGx5EjUKCnBhZ2luYXRpb24YASABKAsyFS5ydW1nYXAuUGFnaW5hdGVSZXBseVIKcGFnaW5hdGlvbhInCgVpdGVtcxgCIAMoCzIRLnJ1bWdhcC5Vc2VyUmVwbHlSBWl0ZW1z');
