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
    const {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    const {'1': 'progress', '3': 2, '4': 1, '5': 5, '10': 'progress'},
  ],
};

/// Descriptor for `ReadingPatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readingPatchRequestDescriptor = $convert.base64Decode('ChNSZWFkaW5nUGF0Y2hSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEhoKCHByb2dyZXNzGAIgASgFUghwcm9ncmVzcw==');
@$core.Deprecated('Use updateChapterOffsetRequestDescriptor instead')
const UpdateChapterOffsetRequest$json = const {
  '1': 'UpdateChapterOffsetRequest',
  '2': const [
    const {'1': 'chapter_id', '3': 1, '4': 1, '5': 5, '10': 'chapterId'},
    const {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `UpdateChapterOffsetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChapterOffsetRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVDaGFwdGVyT2Zmc2V0UmVxdWVzdBIdCgpjaGFwdGVyX2lkGAEgASgFUgljaGFwdGVySWQSFgoGb2Zmc2V0GAIgASgFUgZvZmZzZXQ=');
