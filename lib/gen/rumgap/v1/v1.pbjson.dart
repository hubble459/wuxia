// This is a generated file - do not edit.
//
// Generated from rumgap/v1/v1.proto.

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

@$core.Deprecated('Use idDescriptor instead')
const Id$json = {
  '1': 'Id',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `Id`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List idDescriptor =
    $convert.base64Decode('CgJJZBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use detailedErrorDescriptor instead')
const DetailedError$json = {
  '1': 'DetailedError',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 5, '10': 'status'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'details',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'details'
    },
  ],
};

/// Descriptor for `DetailedError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detailedErrorDescriptor = $convert.base64Decode(
    'Cg1EZXRhaWxlZEVycm9yEhYKBnN0YXR1cxgBIAEoBVIGc3RhdHVzEhgKB21lc3NhZ2UYAiABKA'
    'lSB21lc3NhZ2USLgoHZGV0YWlscxgDIAMoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSB2RldGFp'
    'bHM=');
