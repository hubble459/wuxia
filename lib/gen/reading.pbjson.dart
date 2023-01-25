///
//  Generated code. Do not modify.
//  source: reading.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use readingPostRequestDescriptor instead')
const ReadingPostRequest$json = const {
  '1': 'ReadingPostRequest',
  '2': const [
    const {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `ReadingPostRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPostRequestDescriptor = $convert.base64Decode('ChJSZWFkaW5nUG9zdFJlcXVlc3QSGQoIbWFuZ2FfaWQYASABKAVSB21hbmdhSWQ=');
@$core.Deprecated('Use readingPatchRequestDescriptor instead')
const ReadingPatchRequest$json = const {
  '1': 'ReadingPatchRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'progress', '3': 2, '4': 1, '5': 5, '10': 'progress'},
  ],
};

/// Descriptor for `ReadingPatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPatchRequestDescriptor = $convert.base64Decode('ChNSZWFkaW5nUGF0Y2hSZXF1ZXN0Eg4KAmlkGAEgASgFUgJpZBIaCghwcm9ncmVzcxgCIAEoBVIIcHJvZ3Jlc3M=');
@$core.Deprecated('Use readingReplyDescriptor instead')
const ReadingReply$json = const {
  '1': 'ReadingReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'progress', '3': 3, '4': 1, '5': 5, '10': 'progress'},
    const {'1': 'cover', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'cover', '17': true},
    const {'1': 'count_chapters', '3': 5, '4': 1, '5': 5, '10': 'countChapters'},
    const {'1': 'manga', '3': 6, '4': 1, '5': 11, '6': '.rumgap.MangaReply', '10': 'manga'},
    const {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 8, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
  '8': const [
    const {'1': '_cover'},
  ],
};

/// Descriptor for `ReadingReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingReplyDescriptor = $convert.base64Decode('CgxSZWFkaW5nUmVwbHkSDgoCaWQYASABKAVSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIaCghwcm9ncmVzcxgDIAEoBVIIcHJvZ3Jlc3MSGQoFY292ZXIYBCABKAlIAFIFY292ZXKIAQESJQoOY291bnRfY2hhcHRlcnMYBSABKAVSDWNvdW50Q2hhcHRlcnMSKAoFbWFuZ2EYBiABKAsyEi5ydW1nYXAuTWFuZ2FSZXBseVIFbWFuZ2ESHQoKY3JlYXRlZF9hdBgHIAEoA1IJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCCABKANSCXVwZGF0ZWRBdEIICgZfY292ZXI=');
@$core.Deprecated('Use readingsReplyDescriptor instead')
const ReadingsReply$json = const {
  '1': 'ReadingsReply',
  '2': const [
    const {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.PaginateReply', '10': 'pagination'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.ReadingReply', '10': 'items'},
  ],
};

/// Descriptor for `ReadingsReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingsReplyDescriptor = $convert.base64Decode('Cg1SZWFkaW5nc1JlcGx5EjUKCnBhZ2luYXRpb24YASABKAsyFS5ydW1nYXAuUGFnaW5hdGVSZXBseVIKcGFnaW5hdGlvbhIqCgVpdGVtcxgCIAMoCzIULnJ1bWdhcC5SZWFkaW5nUmVwbHlSBWl0ZW1z');
