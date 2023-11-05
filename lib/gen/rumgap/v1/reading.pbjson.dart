//
//  Generated code. Do not modify.
//  source: rumgap/v1/reading.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use readingPostRequestDescriptor instead')
const ReadingPostRequest$json = {
  '1': 'ReadingPostRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `ReadingPostRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPostRequestDescriptor = $convert.base64Decode(
    'ChJSZWFkaW5nUG9zdFJlcXVlc3QSGQoIbWFuZ2FfaWQYASABKAVSB21hbmdhSWQ=');

@$core.Deprecated('Use readingPatchRequestDescriptor instead')
const ReadingPatchRequest$json = {
  '1': 'ReadingPatchRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'progress', '3': 2, '4': 1, '5': 5, '10': 'progress'},
  ],
};

/// Descriptor for `ReadingPatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPatchRequestDescriptor = $convert.base64Decode(
    'ChNSZWFkaW5nUGF0Y2hSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEhoKCHByb2'
    'dyZXNzGAIgASgFUghwcm9ncmVzcw==');

@$core.Deprecated('Use updateChapterOffsetRequestDescriptor instead')
const UpdateChapterOffsetRequest$json = {
  '1': 'UpdateChapterOffsetRequest',
  '2': [
    {'1': 'chapter_id', '3': 1, '4': 1, '5': 5, '10': 'chapterId'},
    {'1': 'pixels', '3': 2, '4': 1, '5': 5, '10': 'pixels'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
  ],
};

/// Descriptor for `UpdateChapterOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChapterOffsetRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVDaGFwdGVyT2Zmc2V0UmVxdWVzdBIdCgpjaGFwdGVyX2lkGAEgASgFUgljaGFwdG'
    'VySWQSFgoGcGl4ZWxzGAIgASgFUgZwaXhlbHMSEgoEcGFnZRgDIAEoBVIEcGFnZQ==');

