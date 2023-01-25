///
//  Generated code. Do not modify.
//  source: paginate.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use paginateQueryDescriptor instead')
const PaginateQuery$json = const {
  '1': 'PaginateQuery',
  '2': const [
    const {'1': 'per_page', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'perPage', '17': true},
    const {'1': 'page', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'page', '17': true},
  ],
  '8': const [
    const {'1': '_per_page'},
    const {'1': '_page'},
  ],
};

/// Descriptor for `PaginateQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateQueryDescriptor = $convert.base64Decode('Cg1QYWdpbmF0ZVF1ZXJ5Eh4KCHBlcl9wYWdlGAEgASgESABSB3BlclBhZ2WIAQESFwoEcGFnZRgCIAEoBEgBUgRwYWdliAEBQgsKCV9wZXJfcGFnZUIHCgVfcGFnZQ==');
@$core.Deprecated('Use paginateSearchQueryDescriptor instead')
const PaginateSearchQuery$json = const {
  '1': 'PaginateSearchQuery',
  '2': const [
    const {'1': 'per_page', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'perPage', '17': true},
    const {'1': 'page', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'page', '17': true},
    const {'1': 'search', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'search', '17': true},
    const {'1': 'order', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'order', '17': true},
  ],
  '8': const [
    const {'1': '_per_page'},
    const {'1': '_page'},
    const {'1': '_search'},
    const {'1': '_order'},
  ],
};

/// Descriptor for `PaginateSearchQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateSearchQueryDescriptor = $convert.base64Decode('ChNQYWdpbmF0ZVNlYXJjaFF1ZXJ5Eh4KCHBlcl9wYWdlGAEgASgESABSB3BlclBhZ2WIAQESFwoEcGFnZRgCIAEoBEgBUgRwYWdliAEBEhsKBnNlYXJjaBgDIAEoCUgCUgZzZWFyY2iIAQESGQoFb3JkZXIYBCABKAlIA1IFb3JkZXKIAQFCCwoJX3Blcl9wYWdlQgcKBV9wYWdlQgkKB19zZWFyY2hCCAoGX29yZGVy');
@$core.Deprecated('Use paginateReplyDescriptor instead')
const PaginateReply$json = const {
  '1': 'PaginateReply',
  '2': const [
    const {'1': 'total', '3': 1, '4': 1, '5': 4, '10': 'total'},
    const {'1': 'page', '3': 2, '4': 1, '5': 4, '10': 'page'},
    const {'1': 'per_page', '3': 3, '4': 1, '5': 4, '10': 'perPage'},
    const {'1': 'max_page', '3': 4, '4': 1, '5': 4, '10': 'maxPage'},
  ],
};

/// Descriptor for `PaginateReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateReplyDescriptor = $convert.base64Decode('Cg1QYWdpbmF0ZVJlcGx5EhQKBXRvdGFsGAEgASgEUgV0b3RhbBISCgRwYWdlGAIgASgEUgRwYWdlEhkKCHBlcl9wYWdlGAMgASgEUgdwZXJQYWdlEhkKCG1heF9wYWdlGAQgASgEUgdtYXhQYWdl');
