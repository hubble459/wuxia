// This is a generated file - do not edit.
//
// Generated from rumgap/v1/admin.proto.

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

@$core.Deprecated('Use adminCreateUserRequestDescriptor instead')
const AdminCreateUserRequest$json = {
  '1': 'AdminCreateUserRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'admin', '3': 4, '4': 1, '5': 8, '10': 'admin'},
  ],
};

/// Descriptor for `AdminCreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminCreateUserRequestDescriptor = $convert.base64Decode(
    'ChZBZG1pbkNyZWF0ZVVzZXJSZXF1ZXN0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIUCg'
    'VlbWFpbBgCIAEoCVIFZW1haWwSGgoIcGFzc3dvcmQYAyABKAlSCHBhc3N3b3JkEhQKBWFkbWlu'
    'GAQgASgIUgVhZG1pbg==');

@$core.Deprecated('Use adminDeleteUserRequestDescriptor instead')
const AdminDeleteUserRequest$json = {
  '1': 'AdminDeleteUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `AdminDeleteUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminDeleteUserRequestDescriptor = $convert
    .base64Decode('ChZBZG1pbkRlbGV0ZVVzZXJSZXF1ZXN0Eg4KAmlkGAEgASgFUgJpZA==');

@$core.Deprecated('Use adminSetPasswordRequestDescriptor instead')
const AdminSetPasswordRequest$json = {
  '1': 'AdminSetPasswordRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `AdminSetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminSetPasswordRequestDescriptor =
    $convert.base64Decode(
        'ChdBZG1pblNldFBhc3N3b3JkUmVxdWVzdBIOCgJpZBgBIAEoBVICaWQSGgoIcGFzc3dvcmQYAi'
        'ABKAlSCHBhc3N3b3Jk');
