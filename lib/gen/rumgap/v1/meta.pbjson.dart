// This is a generated file - do not edit.
//
// Generated from rumgap/v1/meta.proto.

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

@$core.Deprecated('Use metaHostnamesOptionDescriptor instead')
const MetaHostnamesOption$json = {
  '1': 'MetaHostnamesOption',
  '2': [
    {'1': 'HostnamesReading', '2': 0},
    {'1': 'HostnamesManga', '2': 1},
    {'1': 'HostnamesOnline', '2': 2},
  ],
};

/// Descriptor for `MetaHostnamesOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaHostnamesOptionDescriptor = $convert.base64Decode(
    'ChNNZXRhSG9zdG5hbWVzT3B0aW9uEhQKEEhvc3RuYW1lc1JlYWRpbmcQABISCg5Ib3N0bmFtZX'
    'NNYW5nYRABEhMKD0hvc3RuYW1lc09ubGluZRAC');

@$core.Deprecated('Use metaGenresOptionDescriptor instead')
const MetaGenresOption$json = {
  '1': 'MetaGenresOption',
  '2': [
    {'1': 'GenresReading', '2': 0},
    {'1': 'GenresManga', '2': 1},
  ],
};

/// Descriptor for `MetaGenresOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaGenresOptionDescriptor = $convert.base64Decode(
    'ChBNZXRhR2VucmVzT3B0aW9uEhEKDUdlbnJlc1JlYWRpbmcQABIPCgtHZW5yZXNNYW5nYRAB');

@$core.Deprecated('Use metaReplyDescriptor instead')
const MetaReply$json = {
  '1': 'MetaReply',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 9, '10': 'items'},
  ],
};

/// Descriptor for `MetaReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaReplyDescriptor =
    $convert.base64Decode('CglNZXRhUmVwbHkSFAoFaXRlbXMYASADKAlSBWl0ZW1z');

@$core.Deprecated('Use metaHostnamesRequestDescriptor instead')
const MetaHostnamesRequest$json = {
  '1': 'MetaHostnamesRequest',
  '2': [
    {
      '1': 'option',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.MetaHostnamesOption',
      '9': 0,
      '10': 'option',
      '17': true
    },
  ],
  '8': [
    {'1': '_option'},
  ],
};

/// Descriptor for `MetaHostnamesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaHostnamesRequestDescriptor = $convert.base64Decode(
    'ChRNZXRhSG9zdG5hbWVzUmVxdWVzdBI7CgZvcHRpb24YASABKA4yHi5ydW1nYXAudjEuTWV0YU'
    'hvc3RuYW1lc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');

@$core.Deprecated('Use metaGenresRequestDescriptor instead')
const MetaGenresRequest$json = {
  '1': 'MetaGenresRequest',
  '2': [
    {
      '1': 'option',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.MetaGenresOption',
      '9': 0,
      '10': 'option',
      '17': true
    },
  ],
  '8': [
    {'1': '_option'},
  ],
};

/// Descriptor for `MetaGenresRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaGenresRequestDescriptor = $convert.base64Decode(
    'ChFNZXRhR2VucmVzUmVxdWVzdBI4CgZvcHRpb24YASABKA4yGy5ydW1nYXAudjEuTWV0YUdlbn'
    'Jlc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');

@$core.Deprecated('Use statsReplyDescriptor instead')
const StatsReply$json = {
  '1': 'StatsReply',
  '2': [
    {
      '1': 'count_total_reading',
      '3': 1,
      '4': 1,
      '5': 3,
      '10': 'countTotalReading'
    },
    {
      '1': 'count_total_chapters',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'countTotalChapters'
    },
    {'1': 'count_reading', '3': 3, '4': 1, '5': 3, '10': 'countReading'},
    {'1': 'count_chapters', '3': 4, '4': 1, '5': 3, '10': 'countChapters'},
  ],
};

/// Descriptor for `StatsReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsReplyDescriptor = $convert.base64Decode(
    'CgpTdGF0c1JlcGx5Ei4KE2NvdW50X3RvdGFsX3JlYWRpbmcYASABKANSEWNvdW50VG90YWxSZW'
    'FkaW5nEjAKFGNvdW50X3RvdGFsX2NoYXB0ZXJzGAIgASgDUhJjb3VudFRvdGFsQ2hhcHRlcnMS'
    'IwoNY291bnRfcmVhZGluZxgDIAEoA1IMY291bnRSZWFkaW5nEiUKDmNvdW50X2NoYXB0ZXJzGA'
    'QgASgDUg1jb3VudENoYXB0ZXJz');
