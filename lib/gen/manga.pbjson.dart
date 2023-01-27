///
//  Generated code. Do not modify.
//  source: manga.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use mangaRequestDescriptor instead')
const MangaRequest$json = const {
  '1': 'MangaRequest',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `MangaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangaRequestDescriptor = $convert.base64Decode('CgxNYW5nYVJlcXVlc3QSEAoDdXJsGAEgASgJUgN1cmw=');
@$core.Deprecated('Use mangasRequestDescriptor instead')
const MangasRequest$json = const {
  '1': 'MangasRequest',
  '2': const [
    const {'1': 'urls', '3': 1, '4': 3, '5': 9, '10': 'urls'},
  ],
};

/// Descriptor for `MangasRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangasRequestDescriptor = $convert.base64Decode('Cg1NYW5nYXNSZXF1ZXN0EhIKBHVybHMYASADKAlSBHVybHM=');
@$core.Deprecated('Use mangaReplyDescriptor instead')
const MangaReply$json = const {
  '1': 'MangaReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'cover', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'cover', '17': true},
    const {'1': 'is_ongoing', '3': 6, '4': 1, '5': 8, '10': 'isOngoing'},
    const {'1': 'genres', '3': 7, '4': 3, '5': 9, '10': 'genres'},
    const {'1': 'authors', '3': 8, '4': 3, '5': 9, '10': 'authors'},
    const {'1': 'alt_titles', '3': 9, '4': 3, '5': 9, '10': 'altTitles'},
    const {'1': 'count_chapters', '3': 10, '4': 1, '5': 3, '10': 'countChapters'},
    const {'1': 'next', '3': 11, '4': 1, '5': 3, '9': 1, '10': 'next', '17': true},
    const {'1': 'last', '3': 12, '4': 1, '5': 3, '9': 2, '10': 'last', '17': true},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 14, '4': 1, '5': 3, '10': 'updatedAt'},
    const {'1': 'reading_progress', '3': 15, '4': 1, '5': 5, '9': 3, '10': 'readingProgress', '17': true},
  ],
  '8': const [
    const {'1': '_cover'},
    const {'1': '_next'},
    const {'1': '_last'},
    const {'1': '_reading_progress'},
  ],
};

/// Descriptor for `MangaReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangaReplyDescriptor = $convert.base64Decode('CgpNYW5nYVJlcGx5Eg4KAmlkGAEgASgFUgJpZBIQCgN1cmwYAiABKAlSA3VybBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhkKBWNvdmVyGAUgASgJSABSBWNvdmVyiAEBEh0KCmlzX29uZ29pbmcYBiABKAhSCWlzT25nb2luZxIWCgZnZW5yZXMYByADKAlSBmdlbnJlcxIYCgdhdXRob3JzGAggAygJUgdhdXRob3JzEh0KCmFsdF90aXRsZXMYCSADKAlSCWFsdFRpdGxlcxIlCg5jb3VudF9jaGFwdGVycxgKIAEoA1INY291bnRDaGFwdGVycxIXCgRuZXh0GAsgASgDSAFSBG5leHSIAQESFwoEbGFzdBgMIAEoA0gCUgRsYXN0iAEBEh0KCmNyZWF0ZWRfYXQYDSABKANSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA4gASgDUgl1cGRhdGVkQXQSLgoQcmVhZGluZ19wcm9ncmVzcxgPIAEoBUgDUg9yZWFkaW5nUHJvZ3Jlc3OIAQFCCAoGX2NvdmVyQgcKBV9uZXh0QgcKBV9sYXN0QhMKEV9yZWFkaW5nX3Byb2dyZXNz');
@$core.Deprecated('Use mangasReplyDescriptor instead')
const MangasReply$json = const {
  '1': 'MangasReply',
  '2': const [
    const {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.PaginateReply', '10': 'pagination'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.MangaReply', '10': 'items'},
  ],
};

/// Descriptor for `MangasReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangasReplyDescriptor = $convert.base64Decode('CgtNYW5nYXNSZXBseRI1CgpwYWdpbmF0aW9uGAEgASgLMhUucnVtZ2FwLlBhZ2luYXRlUmVwbHlSCnBhZ2luYXRpb24SKAoFaXRlbXMYAiADKAsyEi5ydW1nYXAuTWFuZ2FSZXBseVIFaXRlbXM=');
