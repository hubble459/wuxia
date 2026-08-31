// This is a generated file - do not edit.
//
// Generated from rumgap/v1/scraper.proto.

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

@$core.Deprecated('Use scraperStatusRequestDescriptor instead')
const ScraperStatusRequest$json = {
  '1': 'ScraperStatusRequest',
};

/// Descriptor for `ScraperStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scraperStatusRequestDescriptor =
    $convert.base64Decode('ChRTY3JhcGVyU3RhdHVzUmVxdWVzdA==');

@$core.Deprecated('Use scraperErrorEntryDescriptor instead')
const ScraperErrorEntry$json = {
  '1': 'ScraperErrorEntry',
  '2': [
    {'1': 'operation', '3': 1, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {
      '1': 'error_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.ScrapeErrorType',
      '10': 'errorType'
    },
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `ScraperErrorEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scraperErrorEntryDescriptor = $convert.base64Decode(
    'ChFTY3JhcGVyRXJyb3JFbnRyeRIcCglvcGVyYXRpb24YASABKAlSCW9wZXJhdGlvbhIQCgN1cm'
    'wYAiABKAlSA3VybBI5CgplcnJvcl90eXBlGAMgASgOMhoucnVtZ2FwLnYxLlNjcmFwZUVycm9y'
    'VHlwZVIJZXJyb3JUeXBlEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2USHQoKY3JlYXRlZF9hdB'
    'gFIAEoA1IJY3JlYXRlZEF0');

@$core.Deprecated('Use scraperStatusDescriptor instead')
const ScraperStatus$json = {
  '1': 'ScraperStatus',
  '2': [
    {'1': 'hostname', '3': 1, '4': 1, '5': 9, '10': 'hostname'},
    {
      '1': 'last_attempt_at',
      '3': 2,
      '4': 1,
      '5': 3,
      '9': 0,
      '10': 'lastAttemptAt',
      '17': true
    },
    {
      '1': 'last_attempt_success',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'lastAttemptSuccess'
    },
    {
      '1': 'last_success_at',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'lastSuccessAt',
      '17': true
    },
    {'1': 'attempts_24h', '3': 5, '4': 1, '5': 3, '10': 'attempts24h'},
    {'1': 'failures_24h', '3': 6, '4': 1, '5': 3, '10': 'failures24h'},
    {
      '1': 'recent_errors',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.ScraperErrorEntry',
      '10': 'recentErrors'
    },
  ],
  '8': [
    {'1': '_last_attempt_at'},
    {'1': '_last_success_at'},
  ],
};

/// Descriptor for `ScraperStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scraperStatusDescriptor = $convert.base64Decode(
    'Cg1TY3JhcGVyU3RhdHVzEhoKCGhvc3RuYW1lGAEgASgJUghob3N0bmFtZRIrCg9sYXN0X2F0dG'
    'VtcHRfYXQYAiABKANIAFINbGFzdEF0dGVtcHRBdIgBARIwChRsYXN0X2F0dGVtcHRfc3VjY2Vz'
    'cxgDIAEoCFISbGFzdEF0dGVtcHRTdWNjZXNzEisKD2xhc3Rfc3VjY2Vzc19hdBgEIAEoA0gBUg'
    '1sYXN0U3VjY2Vzc0F0iAEBEiEKDGF0dGVtcHRzXzI0aBgFIAEoA1ILYXR0ZW1wdHMyNGgSIQoM'
    'ZmFpbHVyZXNfMjRoGAYgASgDUgtmYWlsdXJlczI0aBJBCg1yZWNlbnRfZXJyb3JzGAcgAygLMh'
    'wucnVtZ2FwLnYxLlNjcmFwZXJFcnJvckVudHJ5UgxyZWNlbnRFcnJvcnNCEgoQX2xhc3RfYXR0'
    'ZW1wdF9hdEISChBfbGFzdF9zdWNjZXNzX2F0');

@$core.Deprecated('Use scraperStatusReplyDescriptor instead')
const ScraperStatusReply$json = {
  '1': 'ScraperStatusReply',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.ScraperStatus',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ScraperStatusReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scraperStatusReplyDescriptor = $convert.base64Decode(
    'ChJTY3JhcGVyU3RhdHVzUmVwbHkSLgoFaXRlbXMYASADKAsyGC5ydW1nYXAudjEuU2NyYXBlcl'
    'N0YXR1c1IFaXRlbXM=');
