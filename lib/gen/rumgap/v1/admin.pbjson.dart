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

@$core.Deprecated('Use storageBucketDescriptor instead')
const StorageBucket$json = {
  '1': 'StorageBucket',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bytes', '3': 2, '4': 1, '5': 3, '10': 'bytes'},
    {'1': 'files', '3': 3, '4': 1, '5': 3, '10': 'files'},
  ],
};

/// Descriptor for `StorageBucket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageBucketDescriptor = $convert.base64Decode(
    'Cg1TdG9yYWdlQnVja2V0EhIKBG5hbWUYASABKAlSBG5hbWUSFAoFYnl0ZXMYAiABKANSBWJ5dG'
    'VzEhQKBWZpbGVzGAMgASgDUgVmaWxlcw==');

@$core.Deprecated('Use storageGroupDescriptor instead')
const StorageGroup$json = {
  '1': 'StorageGroup',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'cover', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'cover', '17': true},
    {'1': 'bytes', '3': 4, '4': 1, '5': 3, '10': 'bytes'},
    {'1': 'pages', '3': 5, '4': 1, '5': 3, '10': 'pages'},
    {'1': 'chapters', '3': 6, '4': 1, '5': 3, '10': 'chapters'},
  ],
  '8': [
    {'1': '_cover'},
  ],
};

/// Descriptor for `StorageGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageGroupDescriptor = $convert.base64Decode(
    'CgxTdG9yYWdlR3JvdXASEAoDa2V5GAEgASgJUgNrZXkSFAoFdGl0bGUYAiABKAlSBXRpdGxlEh'
    'kKBWNvdmVyGAMgASgJSABSBWNvdmVyiAEBEhQKBWJ5dGVzGAQgASgDUgVieXRlcxIUCgVwYWdl'
    'cxgFIAEoA1IFcGFnZXMSGgoIY2hhcHRlcnMYBiABKANSCGNoYXB0ZXJzQggKBl9jb3Zlcg==');

@$core.Deprecated('Use storageReplyDescriptor instead')
const StorageReply$json = {
  '1': 'StorageReply',
  '2': [
    {'1': 'disk_bytes', '3': 1, '4': 1, '5': 3, '10': 'diskBytes'},
    {'1': 'disk_files', '3': 2, '4': 1, '5': 3, '10': 'diskFiles'},
    {
      '1': 'disk',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StorageBucket',
      '10': 'disk'
    },
    {'1': 'database_bytes', '3': 4, '4': 1, '5': 3, '10': 'databaseBytes'},
    {
      '1': 'tables',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StorageBucket',
      '10': 'tables'
    },
    {
      '1': 'volume_total_bytes',
      '3': 6,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'volumeTotalBytes',
      '17': true
    },
    {
      '1': 'volume_free_bytes',
      '3': 7,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'volumeFreeBytes',
      '17': true
    },
    {
      '1': 'hosts',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StorageGroup',
      '10': 'hosts'
    },
    {
      '1': 'manga',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StorageGroup',
      '10': 'manga'
    },
    {'1': 'pages_stored', '3': 10, '4': 1, '5': 3, '10': 'pagesStored'},
    {'1': 'pages_pending', '3': 11, '4': 1, '5': 3, '10': 'pagesPending'},
    {'1': 'pages_failed', '3': 12, '4': 1, '5': 3, '10': 'pagesFailed'},
    {'1': 'measured_at', '3': 13, '4': 1, '5': 3, '10': 'measuredAt'},
    {'1': 'scan_millis', '3': 14, '4': 1, '5': 3, '10': 'scanMillis'},
  ],
  '8': [
    {'1': '_volume_total_bytes'},
    {'1': '_volume_free_bytes'},
  ],
};

/// Descriptor for `StorageReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageReplyDescriptor = $convert.base64Decode(
    'CgxTdG9yYWdlUmVwbHkSHQoKZGlza19ieXRlcxgBIAEoA1IJZGlza0J5dGVzEh0KCmRpc2tfZm'
    'lsZXMYAiABKANSCWRpc2tGaWxlcxIsCgRkaXNrGAMgAygLMhgucnVtZ2FwLnYxLlN0b3JhZ2VC'
    'dWNrZXRSBGRpc2sSJQoOZGF0YWJhc2VfYnl0ZXMYBCABKANSDWRhdGFiYXNlQnl0ZXMSMAoGdG'
    'FibGVzGAUgAygLMhgucnVtZ2FwLnYxLlN0b3JhZ2VCdWNrZXRSBnRhYmxlcxIxChJ2b2x1bWVf'
    'dG90YWxfYnl0ZXMYBiABKANIAFIQdm9sdW1lVG90YWxCeXRlc4gBARIvChF2b2x1bWVfZnJlZV'
    '9ieXRlcxgHIAEoA0gBUg92b2x1bWVGcmVlQnl0ZXOIAQESLQoFaG9zdHMYCCADKAsyFy5ydW1n'
    'YXAudjEuU3RvcmFnZUdyb3VwUgVob3N0cxItCgVtYW5nYRgJIAMoCzIXLnJ1bWdhcC52MS5TdG'
    '9yYWdlR3JvdXBSBW1hbmdhEiEKDHBhZ2VzX3N0b3JlZBgKIAEoA1ILcGFnZXNTdG9yZWQSIwoN'
    'cGFnZXNfcGVuZGluZxgLIAEoA1IMcGFnZXNQZW5kaW5nEiEKDHBhZ2VzX2ZhaWxlZBgMIAEoA1'
    'ILcGFnZXNGYWlsZWQSHwoLbWVhc3VyZWRfYXQYDSABKANSCm1lYXN1cmVkQXQSHwoLc2Nhbl9t'
    'aWxsaXMYDiABKANSCnNjYW5NaWxsaXNCFQoTX3ZvbHVtZV90b3RhbF9ieXRlc0IUChJfdm9sdW'
    '1lX2ZyZWVfYnl0ZXM=');
