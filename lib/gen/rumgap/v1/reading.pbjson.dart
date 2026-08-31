// This is a generated file - do not edit.
//
// Generated from rumgap/v1/reading.proto.

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

@$core.Deprecated('Use readingPostRequestDescriptor instead')
const ReadingPostRequest$json = {
  '1': 'ReadingPostRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `ReadingPostRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPostRequestDescriptor =
    $convert.base64Decode(
        'ChJSZWFkaW5nUG9zdFJlcXVlc3QSGQoIbWFuZ2FfaWQYASABKAVSB21hbmdhSWQ=');

@$core.Deprecated('Use readingPatchRequestDescriptor instead')
const ReadingPatchRequest$json = {
  '1': 'ReadingPatchRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'progress', '3': 2, '4': 1, '5': 5, '10': 'progress'},
    {
      '1': 'chapter_id',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'chapterId',
      '17': true
    },
  ],
  '8': [
    {'1': '_chapter_id'},
  ],
};

/// Descriptor for `ReadingPatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPatchRequestDescriptor = $convert.base64Decode(
    'ChNSZWFkaW5nUGF0Y2hSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEhoKCHByb2'
    'dyZXNzGAIgASgFUghwcm9ncmVzcxIiCgpjaGFwdGVyX2lkGAMgASgFSABSCWNoYXB0ZXJJZIgB'
    'AUINCgtfY2hhcHRlcl9pZA==');

@$core.Deprecated('Use updateChapterOffsetRequestDescriptor instead')
const UpdateChapterOffsetRequest$json = {
  '1': 'UpdateChapterOffsetRequest',
  '2': [
    {'1': 'chapter_id', '3': 1, '4': 1, '5': 5, '10': 'chapterId'},
    {'1': 'pixels', '3': 2, '4': 1, '5': 5, '10': 'pixels'},
    {'1': 'page', '3': 3, '4': 1, '5': 5, '10': 'page'},
    {
      '1': 'fraction',
      '3': 4,
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

/// Descriptor for `UpdateChapterOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChapterOffsetRequestDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVDaGFwdGVyT2Zmc2V0UmVxdWVzdBIdCgpjaGFwdGVyX2lkGAEgASgFUgljaGFwdG'
        'VySWQSFgoGcGl4ZWxzGAIgASgFUgZwaXhlbHMSEgoEcGFnZRgDIAEoBVIEcGFnZRIfCghmcmFj'
        'dGlvbhgEIAEoAkgAUghmcmFjdGlvbogBAUILCglfZnJhY3Rpb24=');

@$core.Deprecated('Use getCrossSourceOffsetRequestDescriptor instead')
const GetCrossSourceOffsetRequest$json = {
  '1': 'GetCrossSourceOffsetRequest',
  '2': [
    {
      '1': 'canonical_chapter_id',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'canonicalChapterId'
    },
  ],
};

/// Descriptor for `GetCrossSourceOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCrossSourceOffsetRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRDcm9zc1NvdXJjZU9mZnNldFJlcXVlc3QSMAoUY2Fub25pY2FsX2NoYXB0ZXJfaWQYAS'
        'ABKAVSEmNhbm9uaWNhbENoYXB0ZXJJZA==');

@$core.Deprecated('Use deleteReadingRequestDescriptor instead')
const DeleteReadingRequest$json = {
  '1': 'DeleteReadingRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `DeleteReadingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteReadingRequestDescriptor =
    $convert.base64Decode(
        'ChREZWxldGVSZWFkaW5nUmVxdWVzdBIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZA==');

@$core.Deprecated('Use crossSourceOffsetReplyDescriptor instead')
const CrossSourceOffsetReply$json = {
  '1': 'CrossSourceOffsetReply',
  '2': [
    {
      '1': 'fraction',
      '3': 1,
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

/// Descriptor for `CrossSourceOffsetReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crossSourceOffsetReplyDescriptor =
    $convert.base64Decode(
        'ChZDcm9zc1NvdXJjZU9mZnNldFJlcGx5Eh8KCGZyYWN0aW9uGAEgASgCSABSCGZyYWN0aW9uiA'
        'EBQgsKCV9mcmFjdGlvbg==');
