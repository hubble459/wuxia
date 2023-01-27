///
//  Generated code. Do not modify.
//  source: search.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = const {
  '1': 'SearchRequest',
  '2': const [
    const {'1': 'keyword', '3': 1, '4': 1, '5': 9, '10': 'keyword'},
    const {'1': 'hostnames', '3': 2, '4': 3, '5': 9, '10': 'hostnames'},
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode('Cg1TZWFyY2hSZXF1ZXN0EhgKB2tleXdvcmQYASABKAlSB2tleXdvcmQSHAoJaG9zdG5hbWVzGAIgAygJUglob3N0bmFtZXM=');
@$core.Deprecated('Use searchMangaDescriptor instead')
const SearchManga$json = const {
  '1': 'SearchManga',
  '2': const [
    const {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '9': 0, '10': 'mangaId', '17': true},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'posted', '3': 4, '4': 1, '5': 3, '9': 1, '10': 'posted', '17': true},
    const {'1': 'cover', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'cover', '17': true},
    const {'1': 'is_reading', '3': 6, '4': 1, '5': 8, '10': 'isReading'},
  ],
  '8': const [
    const {'1': '_manga_id'},
    const {'1': '_posted'},
    const {'1': '_cover'},
  ],
};

/// Descriptor for `SearchManga`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchMangaDescriptor = $convert.base64Decode('CgtTZWFyY2hNYW5nYRIeCghtYW5nYV9pZBgBIAEoBUgAUgdtYW5nYUlkiAEBEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIQCgN1cmwYAyABKAlSA3VybBIbCgZwb3N0ZWQYBCABKANIAVIGcG9zdGVkiAEBEhkKBWNvdmVyGAUgASgJSAJSBWNvdmVyiAEBEh0KCmlzX3JlYWRpbmcYBiABKAhSCWlzUmVhZGluZ0ILCglfbWFuZ2FfaWRCCQoHX3Bvc3RlZEIICgZfY292ZXI=');
@$core.Deprecated('Use searchReplyDescriptor instead')
const SearchReply$json = const {
  '1': 'SearchReply',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.rumgap.SearchManga', '10': 'items'},
  ],
};

/// Descriptor for `SearchReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchReplyDescriptor = $convert.base64Decode('CgtTZWFyY2hSZXBseRIpCgVpdGVtcxgBIAMoCzITLnJ1bWdhcC5TZWFyY2hNYW5nYVIFaXRlbXM=');
