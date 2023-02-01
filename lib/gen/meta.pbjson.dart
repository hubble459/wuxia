///
//  Generated code. Do not modify.
//  source: meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use metaHostNamesOptionDescriptor instead')
const MetaHostNamesOption$json = const {
  '1': 'MetaHostNamesOption',
  '2': const [
    const {'1': 'HostNamesReading', '2': 0},
    const {'1': 'HostNamesManga', '2': 1},
    const {'1': 'HostNamesOnline', '2': 2},
  ],
};

/// Descriptor for `MetaHostNamesOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaHostNamesOptionDescriptor = $convert.base64Decode('ChNNZXRhSG9zdE5hbWVzT3B0aW9uEhQKEEhvc3ROYW1lc1JlYWRpbmcQABISCg5Ib3N0TmFtZXNNYW5nYRABEhMKD0hvc3ROYW1lc09ubGluZRAC');
@$core.Deprecated('Use metaGenresOptionDescriptor instead')
const MetaGenresOption$json = const {
  '1': 'MetaGenresOption',
  '2': const [
    const {'1': 'GenresReading', '2': 0},
    const {'1': 'GenresManga', '2': 1},
  ],
};

/// Descriptor for `MetaGenresOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaGenresOptionDescriptor = $convert.base64Decode('ChBNZXRhR2VucmVzT3B0aW9uEhEKDUdlbnJlc1JlYWRpbmcQABIPCgtHZW5yZXNNYW5nYRAB');
@$core.Deprecated('Use metaReplyDescriptor instead')
const MetaReply$json = const {
  '1': 'MetaReply',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 9, '10': 'items'},
  ],
};

/// Descriptor for `MetaReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaReplyDescriptor = $convert.base64Decode('CglNZXRhUmVwbHkSFAoFaXRlbXMYASADKAlSBWl0ZW1z');
@$core.Deprecated('Use metaHostNamesRequestDescriptor instead')
const MetaHostNamesRequest$json = const {
  '1': 'MetaHostNamesRequest',
  '2': const [
    const {'1': 'option', '3': 1, '4': 1, '5': 14, '6': '.rumgap.MetaHostNamesOption', '9': 0, '10': 'option', '17': true},
  ],
  '8': const [
    const {'1': '_option'},
  ],
};

/// Descriptor for `MetaHostNamesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaHostNamesRequestDescriptor = $convert.base64Decode('ChRNZXRhSG9zdE5hbWVzUmVxdWVzdBI4CgZvcHRpb24YASABKA4yGy5ydW1nYXAuTWV0YUhvc3ROYW1lc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');
@$core.Deprecated('Use metaGenresRequestDescriptor instead')
const MetaGenresRequest$json = const {
  '1': 'MetaGenresRequest',
  '2': const [
    const {'1': 'option', '3': 1, '4': 1, '5': 14, '6': '.rumgap.MetaGenresOption', '9': 0, '10': 'option', '17': true},
  ],
  '8': const [
    const {'1': '_option'},
  ],
};

/// Descriptor for `MetaGenresRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaGenresRequestDescriptor = $convert.base64Decode('ChFNZXRhR2VucmVzUmVxdWVzdBI1CgZvcHRpb24YASABKA4yGC5ydW1nYXAuTWV0YUdlbnJlc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');
