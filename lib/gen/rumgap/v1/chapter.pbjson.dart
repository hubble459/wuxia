// This is a generated file - do not edit.
//
// Generated from rumgap/v1/chapter.proto.

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

@$core.Deprecated('Use chapterRequestDescriptor instead')
const ChapterRequest$json = {
  '1': 'ChapterRequest',
  '2': [
    {'1': 'manga_source_id', '3': 1, '4': 1, '5': 5, '10': 'mangaSourceId'},
    {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `ChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterRequestDescriptor = $convert.base64Decode(
    'Cg5DaGFwdGVyUmVxdWVzdBImCg9tYW5nYV9zb3VyY2VfaWQYASABKAVSDW1hbmdhU291cmNlSW'
    'QSFAoFaW5kZXgYAiABKAVSBWluZGV4');

@$core.Deprecated('Use chapterOffsetDescriptor instead')
const ChapterOffset$json = {
  '1': 'ChapterOffset',
  '2': [
    {'1': 'pixels', '3': 1, '4': 1, '5': 5, '10': 'pixels'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {
      '1': 'fraction',
      '3': 3,
      '4': 1,
      '5': 2,
      '9': 0,
      '10': 'fraction',
      '17': true
    },
  ],
  '8': [
    {'1': '_fraction'},
  ],
};

/// Descriptor for `ChapterOffset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterOffsetDescriptor = $convert.base64Decode(
    'Cg1DaGFwdGVyT2Zmc2V0EhYKBnBpeGVscxgBIAEoBVIGcGl4ZWxzEhIKBHBhZ2UYAiABKAVSBH'
    'BhZ2USHwoIZnJhY3Rpb24YAyABKAJIAFIIZnJhY3Rpb26IAQFCCwoJX2ZyYWN0aW9u');

@$core.Deprecated('Use chapterReplyDescriptor instead')
const ChapterReply$json = {
  '1': 'ChapterReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'manga_source_id', '3': 2, '4': 1, '5': 5, '10': 'mangaSourceId'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'number', '3': 5, '4': 1, '5': 2, '10': 'number'},
    {'1': 'index', '3': 6, '4': 1, '5': 3, '10': 'index'},
    {'1': 'posted', '3': 7, '4': 1, '5': 3, '9': 0, '10': 'posted', '17': true},
    {
      '1': 'offset',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.ChapterOffset',
      '9': 1,
      '10': 'offset',
      '17': true
    },
    {'1': 'created_at', '3': 9, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 3, '10': 'updatedAt'},
    {
      '1': 'canonical_chapter_id',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'canonicalChapterId',
      '17': true
    },
    {
      '1': 'ordinal',
      '3': 12,
      '4': 1,
      '5': 1,
      '9': 3,
      '10': 'ordinal',
      '17': true
    },
  ],
  '8': [
    {'1': '_posted'},
    {'1': '_offset'},
    {'1': '_canonical_chapter_id'},
    {'1': '_ordinal'},
  ],
};

/// Descriptor for `ChapterReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chapterReplyDescriptor = $convert.base64Decode(
    'CgxDaGFwdGVyUmVwbHkSDgoCaWQYASABKAVSAmlkEiYKD21hbmdhX3NvdXJjZV9pZBgCIAEoBV'
    'INbWFuZ2FTb3VyY2VJZBIQCgN1cmwYAyABKAlSA3VybBIUCgV0aXRsZRgEIAEoCVIFdGl0bGUS'
    'FgoGbnVtYmVyGAUgASgCUgZudW1iZXISFAoFaW5kZXgYBiABKANSBWluZGV4EhsKBnBvc3RlZB'
    'gHIAEoA0gAUgZwb3N0ZWSIAQESNQoGb2Zmc2V0GAggASgLMhgucnVtZ2FwLnYxLkNoYXB0ZXJP'
    'ZmZzZXRIAVIGb2Zmc2V0iAEBEh0KCmNyZWF0ZWRfYXQYCSABKANSCWNyZWF0ZWRBdBIdCgp1cG'
    'RhdGVkX2F0GAogASgDUgl1cGRhdGVkQXQSNQoUY2Fub25pY2FsX2NoYXB0ZXJfaWQYCyABKAVI'
    'AlISY2Fub25pY2FsQ2hhcHRlcklkiAEBEh0KB29yZGluYWwYDCABKAFIA1IHb3JkaW5hbIgBAU'
    'IJCgdfcG9zdGVkQgkKB19vZmZzZXRCFwoVX2Nhbm9uaWNhbF9jaGFwdGVyX2lkQgoKCF9vcmRp'
    'bmFs');

@$core.Deprecated('Use chaptersReplyDescriptor instead')
const ChaptersReply$json = {
  '1': 'ChaptersReply',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.PaginateReply',
      '10': 'pagination'
    },
    {
      '1': 'items',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.ChapterReply',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ChaptersReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chaptersReplyDescriptor = $convert.base64Decode(
    'Cg1DaGFwdGVyc1JlcGx5EjgKCnBhZ2luYXRpb24YASABKAsyGC5ydW1nYXAudjEuUGFnaW5hdG'
    'VSZXBseVIKcGFnaW5hdGlvbhItCgVpdGVtcxgCIAMoCzIXLnJ1bWdhcC52MS5DaGFwdGVyUmVw'
    'bHlSBWl0ZW1z');

@$core.Deprecated('Use imagePageDescriptor instead')
const ImagePage$json = {
  '1': 'ImagePage',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'width', '3': 2, '4': 1, '5': 5, '9': 0, '10': 'width', '17': true},
    {'1': 'height', '3': 3, '4': 1, '5': 5, '9': 1, '10': 'height', '17': true},
  ],
  '8': [
    {'1': '_width'},
    {'1': '_height'},
  ],
};

/// Descriptor for `ImagePage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imagePageDescriptor = $convert.base64Decode(
    'CglJbWFnZVBhZ2USEAoDdXJsGAEgASgJUgN1cmwSGQoFd2lkdGgYAiABKAVIAFIFd2lkdGiIAQ'
    'ESGwoGaGVpZ2h0GAMgASgFSAFSBmhlaWdodIgBAUIICgZfd2lkdGhCCQoHX2hlaWdodA==');

@$core.Deprecated('Use imagesReplyDescriptor instead')
const ImagesReply$json = {
  '1': 'ImagesReply',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.ImagePage',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ImagesReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imagesReplyDescriptor = $convert.base64Decode(
    'CgtJbWFnZXNSZXBseRIqCgVpdGVtcxgBIAMoCzIULnJ1bWdhcC52MS5JbWFnZVBhZ2VSBWl0ZW'
    '1z');

@$core.Deprecated('Use paginateChapterQueryDescriptor instead')
const PaginateChapterQuery$json = {
  '1': 'PaginateChapterQuery',
  '2': [
    {'1': 'manga_source_id', '3': 1, '4': 1, '5': 5, '10': 'mangaSourceId'},
    {
      '1': 'paginate_query',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.PaginateQuery',
      '9': 0,
      '10': 'paginateQuery',
      '17': true
    },
    {
      '1': 'reversed',
      '3': 3,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'reversed',
      '17': true
    },
  ],
  '8': [
    {'1': '_paginate_query'},
    {'1': '_reversed'},
  ],
};

/// Descriptor for `PaginateChapterQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginateChapterQueryDescriptor = $convert.base64Decode(
    'ChRQYWdpbmF0ZUNoYXB0ZXJRdWVyeRImCg9tYW5nYV9zb3VyY2VfaWQYASABKAVSDW1hbmdhU2'
    '91cmNlSWQSRAoOcGFnaW5hdGVfcXVlcnkYAiABKAsyGC5ydW1nYXAudjEuUGFnaW5hdGVRdWVy'
    'eUgAUg1wYWdpbmF0ZVF1ZXJ5iAEBEh8KCHJldmVyc2VkGAMgASgISAFSCHJldmVyc2VkiAEBQh'
    'EKD19wYWdpbmF0ZV9xdWVyeUILCglfcmV2ZXJzZWQ=');

@$core.Deprecated('Use linkChapterRequestDescriptor instead')
const LinkChapterRequest$json = {
  '1': 'LinkChapterRequest',
  '2': [
    {'1': 'chapter_id', '3': 1, '4': 1, '5': 5, '10': 'chapterId'},
    {
      '1': 'canonical_chapter_id',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'canonicalChapterId'
    },
  ],
};

/// Descriptor for `LinkChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkChapterRequestDescriptor = $convert.base64Decode(
    'ChJMaW5rQ2hhcHRlclJlcXVlc3QSHQoKY2hhcHRlcl9pZBgBIAEoBVIJY2hhcHRlcklkEjAKFG'
    'Nhbm9uaWNhbF9jaGFwdGVyX2lkGAIgASgFUhJjYW5vbmljYWxDaGFwdGVySWQ=');

@$core.Deprecated('Use unlinkChapterRequestDescriptor instead')
const UnlinkChapterRequest$json = {
  '1': 'UnlinkChapterRequest',
  '2': [
    {'1': 'chapter_id', '3': 1, '4': 1, '5': 5, '10': 'chapterId'},
  ],
};

/// Descriptor for `UnlinkChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlinkChapterRequestDescriptor = $convert.base64Decode(
    'ChRVbmxpbmtDaGFwdGVyUmVxdWVzdBIdCgpjaGFwdGVyX2lkGAEgASgFUgljaGFwdGVySWQ=');

@$core.Deprecated('Use findEquivalentRequestDescriptor instead')
const FindEquivalentRequest$json = {
  '1': 'FindEquivalentRequest',
  '2': [
    {
      '1': 'canonical_chapter_id',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'canonicalChapterId'
    },
    {'1': 'manga_source_id', '3': 2, '4': 1, '5': 5, '10': 'mangaSourceId'},
  ],
};

/// Descriptor for `FindEquivalentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findEquivalentRequestDescriptor = $convert.base64Decode(
    'ChVGaW5kRXF1aXZhbGVudFJlcXVlc3QSMAoUY2Fub25pY2FsX2NoYXB0ZXJfaWQYASABKAVSEm'
    'Nhbm9uaWNhbENoYXB0ZXJJZBImCg9tYW5nYV9zb3VyY2VfaWQYAiABKAVSDW1hbmdhU291cmNl'
    'SWQ=');
