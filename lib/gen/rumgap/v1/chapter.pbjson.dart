//
//  Generated code. Do not modify.
//  source: rumgap/v1/chapter.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use chapterRequestDescriptor instead')
const ChapterRequest$json = {
  '1': 'ChapterRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `ChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterRequestDescriptor = $convert.base64Decode(
    'Cg5DaGFwdGVyUmVxdWVzdBIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZBIUCgVpbmRleBgCIA'
    'EoBVIFaW5kZXg=');

@$core.Deprecated('Use chapterOffsetDescriptor instead')
const ChapterOffset$json = {
  '1': 'ChapterOffset',
  '2': [
    {'1': 'pixels', '3': 1, '4': 1, '5': 5, '10': 'pixels'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `ChapterOffset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterOffsetDescriptor = $convert.base64Decode(
    'Cg1DaGFwdGVyT2Zmc2V0EhYKBnBpeGVscxgBIAEoBVIGcGl4ZWxzEhIKBHBhZ2UYAiABKAVSBH'
    'BhZ2U=');

@$core.Deprecated('Use chapterReplyDescriptor instead')
const ChapterReply$json = {
  '1': 'ChapterReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'manga_id', '3': 2, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'number', '3': 5, '4': 1, '5': 2, '10': 'number'},
    {'1': 'index', '3': 6, '4': 1, '5': 3, '10': 'index'},
    {'1': 'posted', '3': 7, '4': 1, '5': 3, '9': 0, '10': 'posted', '17': true},
    {'1': 'offset', '3': 8, '4': 1, '5': 11, '6': '.rumgap.v1.ChapterOffset', '9': 1, '10': 'offset', '17': true},
    {'1': 'created_at', '3': 9, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
  '8': [
    {'1': '_posted'},
    {'1': '_offset'},
  ],
};

/// Descriptor for `ChapterReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterReplyDescriptor = $convert.base64Decode(
    'CgxDaGFwdGVyUmVwbHkSDgoCaWQYASABKAVSAmlkEhkKCG1hbmdhX2lkGAIgASgFUgdtYW5nYU'
    'lkEhAKA3VybBgDIAEoCVIDdXJsEhQKBXRpdGxlGAQgASgJUgV0aXRsZRIWCgZudW1iZXIYBSAB'
    'KAJSBm51bWJlchIUCgVpbmRleBgGIAEoA1IFaW5kZXgSGwoGcG9zdGVkGAcgASgDSABSBnBvc3'
    'RlZIgBARI1CgZvZmZzZXQYCCABKAsyGC5ydW1nYXAudjEuQ2hhcHRlck9mZnNldEgBUgZvZmZz'
    'ZXSIAQESHQoKY3JlYXRlZF9hdBgJIAEoA1IJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCiABKA'
    'NSCXVwZGF0ZWRBdEIJCgdfcG9zdGVkQgkKB19vZmZzZXQ=');

@$core.Deprecated('Use chaptersReplyDescriptor instead')
const ChaptersReply$json = {
  '1': 'ChaptersReply',
  '2': [
    {'1': 'pagination', '3': 1, '4': 1, '5': 11, '6': '.rumgap.v1.PaginateReply', '10': 'pagination'},
    {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.rumgap.v1.ChapterReply', '10': 'items'},
  ],
};

/// Descriptor for `ChaptersReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chaptersReplyDescriptor = $convert.base64Decode(
    'Cg1DaGFwdGVyc1JlcGx5EjgKCnBhZ2luYXRpb24YASABKAsyGC5ydW1nYXAudjEuUGFnaW5hdG'
    'VSZXBseVIKcGFnaW5hdGlvbhItCgVpdGVtcxgCIAMoCzIXLnJ1bWdhcC52MS5DaGFwdGVyUmVw'
    'bHlSBWl0ZW1z');

@$core.Deprecated('Use imagesReplyDescriptor instead')
const ImagesReply$json = {
  '1': 'ImagesReply',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 9, '10': 'items'},
  ],
};

/// Descriptor for `ImagesReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imagesReplyDescriptor = $convert.base64Decode(
    'CgtJbWFnZXNSZXBseRIUCgVpdGVtcxgBIAMoCVIFaXRlbXM=');

@$core.Deprecated('Use paginateChapterQueryDescriptor instead')
const PaginateChapterQuery$json = {
  '1': 'PaginateChapterQuery',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'paginate_query', '3': 2, '4': 1, '5': 11, '6': '.rumgap.v1.PaginateQuery', '9': 0, '10': 'paginateQuery', '17': true},
  ],
  '8': [
    {'1': '_paginate_query'},
  ],
};

/// Descriptor for `PaginateChapterQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateChapterQueryDescriptor = $convert.base64Decode(
    'ChRQYWdpbmF0ZUNoYXB0ZXJRdWVyeRIOCgJpZBgBIAEoBVICaWQSRAoOcGFnaW5hdGVfcXVlcn'
    'kYAiABKAsyGC5ydW1nYXAudjEuUGFnaW5hdGVRdWVyeUgAUg1wYWdpbmF0ZVF1ZXJ5iAEBQhEK'
    'D19wYWdpbmF0ZV9xdWVyeQ==');

