// This is a generated file - do not edit.
//
// Generated from rumgap/v1/scrape_error.proto.

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

@$core.Deprecated('Use scrapeErrorTypeDescriptor instead')
const ScrapeErrorType$json = {
  '1': 'ScrapeErrorType',
  '2': [
    {'1': 'Unknown', '2': 0},
    {'1': 'ReqwestError', '2': 1},
    {'1': 'ReqwestMiddlewareError', '2': 2},
    {'1': 'IoError', '2': 3},
    {'1': 'ConfigError', '2': 4},
    {'1': 'ConfigDeserializeError', '2': 5},
    {'1': 'WebScrapingError', '2': 6},
    {'1': 'NotAValidURL', '2': 7},
    {'1': 'SelectorError', '2': 8},
    {'1': 'WebsiteNotSupported', '2': 9},
    {'1': 'SearchNotSupported', '2': 10},
    {'1': 'MultipleScrapingErrors', '2': 11},
    {'1': 'CloudflareIUAM', '2': 12},
  ],
};

/// Descriptor for `ScrapeErrorType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List scrapeErrorTypeDescriptor = $convert.base64Decode(
    'Cg9TY3JhcGVFcnJvclR5cGUSCwoHVW5rbm93bhAAEhAKDFJlcXdlc3RFcnJvchABEhoKFlJlcX'
    'dlc3RNaWRkbGV3YXJlRXJyb3IQAhILCgdJb0Vycm9yEAMSDwoLQ29uZmlnRXJyb3IQBBIaChZD'
    'b25maWdEZXNlcmlhbGl6ZUVycm9yEAUSFAoQV2ViU2NyYXBpbmdFcnJvchAGEhAKDE5vdEFWYW'
    'xpZFVSTBAHEhEKDVNlbGVjdG9yRXJyb3IQCBIXChNXZWJzaXRlTm90U3VwcG9ydGVkEAkSFgoS'
    'U2VhcmNoTm90U3VwcG9ydGVkEAoSGgoWTXVsdGlwbGVTY3JhcGluZ0Vycm9ycxALEhIKDkNsb3'
    'VkZmxhcmVJVUFNEAw=');

@$core.Deprecated('Use scrapeErrorDescriptor instead')
const ScrapeError$json = {
  '1': 'ScrapeError',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.ScrapeErrorType',
      '10': 'type'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ScrapeError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scrapeErrorDescriptor = $convert.base64Decode(
    'CgtTY3JhcGVFcnJvchIuCgR0eXBlGAEgASgOMhoucnVtZ2FwLnYxLlNjcmFwZUVycm9yVHlwZV'
    'IEdHlwZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
