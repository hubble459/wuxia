///
//  Generated code. Do not modify.
//  source: chapter.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use chapterRequestDescriptor instead')
const ChapterRequest$json = const {
  '1': 'ChapterRequest',
  '2': const [
    const {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    const {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `ChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterRequestDescriptor = $convert.base64Decode('Cg5DaGFwdGVyUmVxdWVzdBIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZBIUCgVpbmRleBgCIAEoBVIFaW5kZXg=');
@$core.Deprecated('Use chapterReplyDescriptor instead')
const ChapterReply$json = const {
  '1': 'ChapterReply',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'manga_id', '3': 2, '4': 1, '5': 5, '10': 'mangaId'},
    const {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'number', '3': 5, '4': 1, '5': 2, '10': 'number'},
    const {'1': 'index', '3': 6, '4': 1, '5': 3, '10': 'index'},
    const {'1': 'posted', '3': 7, '4': 1, '5': 3, '9': 0, '10': 'posted', '17': true},
    const {'1': 'offset', '3': 8, '4': 1, '5': 5, '9': 1, '10': 'offset', '17': true},
    const {'1': 'created_at', '3': 9, '4': 1, '5': 3, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 10, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
  '8': const [
    const {'1': '_posted'},
    const {'1': '_offset'},
  ],
};

/// Descriptor for `ChapterReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterReplyDescriptor = $convert.base64Decode('CgxDaGFwdGVyUmVwbHkSDgoCaWQYASABKAVSAmlkEhkKCG1hbmdhX2lkGAIgASgFUgdtYW5nYUlkEhAKA3VybBgDIAEoCVIDdXJsEhQKBXRpdGxlGAQgASgJUgV0aXRsZRIWCgZudW1iZXIYBSABKAJSBm51bWJlchIUCgVpbmRleBgGIAEoA1IFaW5kZXgSGwoGcG9zdGVkGAcgASgDSABSBnBvc3RlZIgBARIbCgZvZmZzZXQYCCABKAVIAVIGb2Zmc2V0iAEBEh0KCmNyZWF0ZWRfYXQYCSABKANSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAogASgDUgl1cGRhdGVkQXRCCQoHX3Bvc3RlZEIJCgdfb2Zmc2V0');
@$core.Deprecated('Use chaptersReplyDescriptor instead')
const ChaptersReply$json = const {
  '1': 'ChaptersReply',
  '2': const [
    const {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.PaginateReply', '10': 'pagination'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.ChapterReply', '10': 'items'},
  ],
};

/// Descriptor for `ChaptersReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chaptersReplyDescriptor = $convert.base64Decode('Cg1DaGFwdGVyc1JlcGx5EjUKCnBhZ2luYXRpb24YASABKAsyFS5ydW1nYXAuUGFnaW5hdGVSZXBseVIKcGFnaW5hdGlvbhIqCgVpdGVtcxgCIAMoCzIULnJ1bWdhcC5DaGFwdGVyUmVwbHlSBWl0ZW1z');
@$core.Deprecated('Use imagesReplyDescriptor instead')
const ImagesReply$json = const {
  '1': 'ImagesReply',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 9, '10': 'items'},
  ],
};

/// Descriptor for `ImagesReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imagesReplyDescriptor = $convert.base64Decode('CgtJbWFnZXNSZXBseRIUCgVpdGVtcxgBIAMoCVIFaXRlbXM=');
@$core.Deprecated('Use paginateChapterQueryDescriptor instead')
const PaginateChapterQuery$json = const {
  '1': 'PaginateChapterQuery',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'paginate_query', '3': 2, '4': 1, '5': 11, '6': '.rumgap.PaginateQuery', '9': 0, '10': 'paginateQuery', '17': true},
  ],
  '8': const [
    const {'1': '_paginate_query'},
  ],
};

/// Descriptor for `PaginateChapterQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateChapterQueryDescriptor = $convert.base64Decode('ChRQYWdpbmF0ZUNoYXB0ZXJRdWVyeRIOCgJpZBgBIAEoBVICaWQSQQoOcGFnaW5hdGVfcXVlcnkYAiABKAsyFS5ydW1nYXAuUGFnaW5hdGVRdWVyeUgAUg1wYWdpbmF0ZVF1ZXJ5iAEBQhEKD19wYWdpbmF0ZV9xdWVyeQ==');
