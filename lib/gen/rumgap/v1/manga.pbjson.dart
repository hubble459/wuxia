// This is a generated file - do not edit.
//
// Generated from rumgap/v1/manga.proto.

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

@$core.Deprecated('Use mangaRequestDescriptor instead')
const MangaRequest$json = {
  '1': 'MangaRequest',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `MangaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangaRequestDescriptor =
    $convert.base64Decode('CgxNYW5nYVJlcXVlc3QSEAoDdXJsGAEgASgJUgN1cmw=');

@$core.Deprecated('Use mangasRequestDescriptor instead')
const MangasRequest$json = {
  '1': 'MangasRequest',
  '2': [
    {'1': 'urls', '3': 1, '4': 3, '5': 9, '10': 'urls'},
  ],
};

/// Descriptor for `MangasRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangasRequestDescriptor =
    $convert.base64Decode('Cg1NYW5nYXNSZXF1ZXN0EhIKBHVybHMYASADKAlSBHVybHM=');

@$core.Deprecated('Use mangaSourceReplyDescriptor instead')
const MangaSourceReply$json = {
  '1': 'MangaSourceReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'hostname', '3': 3, '4': 1, '5': 9, '10': 'hostname'},
    {'1': 'language', '3': 4, '4': 1, '5': 9, '10': 'language'},
    {'1': 'is_primary', '3': 5, '4': 1, '5': 8, '10': 'isPrimary'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `MangaSourceReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangaSourceReplyDescriptor = $convert.base64Decode(
    'ChBNYW5nYVNvdXJjZVJlcGx5Eg4KAmlkGAEgASgFUgJpZBIQCgN1cmwYAiABKAlSA3VybBIaCg'
    'hob3N0bmFtZRgDIAEoCVIIaG9zdG5hbWUSGgoIbGFuZ3VhZ2UYBCABKAlSCGxhbmd1YWdlEh0K'
    'CmlzX3ByaW1hcnkYBSABKAhSCWlzUHJpbWFyeRIdCgpjcmVhdGVkX2F0GAYgASgDUgljcmVhdG'
    'VkQXQSHQoKdXBkYXRlZF9hdBgHIAEoA1IJdXBkYXRlZEF0');

@$core.Deprecated('Use backfillStatusReplyDescriptor instead')
const BackfillStatusReply$json = {
  '1': 'BackfillStatusReply',
  '2': [
    {
      '1': 'images_downloaded',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'imagesDownloaded'
    },
    {'1': 'images_total', '3': 2, '4': 1, '5': 5, '10': 'imagesTotal'},
  ],
};

/// Descriptor for `BackfillStatusReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List backfillStatusReplyDescriptor = $convert.base64Decode(
    'ChNCYWNrZmlsbFN0YXR1c1JlcGx5EisKEWltYWdlc19kb3dubG9hZGVkGAEgASgFUhBpbWFnZX'
    'NEb3dubG9hZGVkEiEKDGltYWdlc190b3RhbBgCIAEoBVILaW1hZ2VzVG90YWw=');

@$core.Deprecated('Use mangaReplyDescriptor instead')
const MangaReply$json = {
  '1': 'MangaReply',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'cover', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'cover', '17': true},
    {'1': 'is_ongoing', '3': 6, '4': 1, '5': 8, '10': 'isOngoing'},
    {'1': 'genres', '3': 7, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'authors', '3': 8, '4': 3, '5': 9, '10': 'authors'},
    {'1': 'alt_titles', '3': 9, '4': 3, '5': 9, '10': 'altTitles'},
    {'1': 'count_chapters', '3': 10, '4': 1, '5': 3, '10': 'countChapters'},
    {'1': 'next', '3': 11, '4': 1, '5': 3, '9': 1, '10': 'next', '17': true},
    {'1': 'last', '3': 12, '4': 1, '5': 3, '9': 2, '10': 'last', '17': true},
    {'1': 'created_at', '3': 13, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 14, '4': 1, '5': 3, '10': 'updatedAt'},
    {
      '1': 'reading_progress',
      '3': 15,
      '4': 1,
      '5': 5,
      '9': 3,
      '10': 'readingProgress',
      '17': true
    },
    {'1': 'status', '3': 16, '4': 1, '5': 9, '10': 'status'},
    {
      '1': 'sources',
      '3': 17,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.MangaSourceReply',
      '10': 'sources'
    },
    {
      '1': 'progress_ordinal',
      '3': 18,
      '4': 1,
      '5': 1,
      '9': 4,
      '10': 'progressOrdinal',
      '17': true
    },
  ],
  '8': [
    {'1': '_cover'},
    {'1': '_next'},
    {'1': '_last'},
    {'1': '_reading_progress'},
    {'1': '_progress_ordinal'},
  ],
};

/// Descriptor for `MangaReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangaReplyDescriptor = $convert.base64Decode(
    'CgpNYW5nYVJlcGx5Eg4KAmlkGAEgASgFUgJpZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSIAoLZG'
    'VzY3JpcHRpb24YBCABKAlSC2Rlc2NyaXB0aW9uEhkKBWNvdmVyGAUgASgJSABSBWNvdmVyiAEB'
    'Eh0KCmlzX29uZ29pbmcYBiABKAhSCWlzT25nb2luZxIWCgZnZW5yZXMYByADKAlSBmdlbnJlcx'
    'IYCgdhdXRob3JzGAggAygJUgdhdXRob3JzEh0KCmFsdF90aXRsZXMYCSADKAlSCWFsdFRpdGxl'
    'cxIlCg5jb3VudF9jaGFwdGVycxgKIAEoA1INY291bnRDaGFwdGVycxIXCgRuZXh0GAsgASgDSA'
    'FSBG5leHSIAQESFwoEbGFzdBgMIAEoA0gCUgRsYXN0iAEBEh0KCmNyZWF0ZWRfYXQYDSABKANS'
    'CWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GA4gASgDUgl1cGRhdGVkQXQSLgoQcmVhZGluZ19wcm'
    '9ncmVzcxgPIAEoBUgDUg9yZWFkaW5nUHJvZ3Jlc3OIAQESFgoGc3RhdHVzGBAgASgJUgZzdGF0'
    'dXMSNQoHc291cmNlcxgRIAMoCzIbLnJ1bWdhcC52MS5NYW5nYVNvdXJjZVJlcGx5Ugdzb3VyY2'
    'VzEi4KEHByb2dyZXNzX29yZGluYWwYEiABKAFIBFIPcHJvZ3Jlc3NPcmRpbmFsiAEBQggKBl9j'
    'b3ZlckIHCgVfbmV4dEIHCgVfbGFzdEITChFfcmVhZGluZ19wcm9ncmVzc0ITChFfcHJvZ3Jlc3'
    'Nfb3JkaW5hbA==');

@$core.Deprecated('Use mangasReplyDescriptor instead')
const MangasReply$json = {
  '1': 'MangasReply',
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
      '6': '.rumgap.v1.MangaReply',
      '10': 'items'
    },
  ],
};

/// Descriptor for `MangasReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mangasReplyDescriptor = $convert.base64Decode(
    'CgtNYW5nYXNSZXBseRI4CgpwYWdpbmF0aW9uGAEgASgLMhgucnVtZ2FwLnYxLlBhZ2luYXRlUm'
    'VwbHlSCnBhZ2luYXRpb24SKwoFaXRlbXMYAiADKAsyFS5ydW1nYXAudjEuTWFuZ2FSZXBseVIF'
    'aXRlbXM=');

@$core.Deprecated('Use addSourceRequestDescriptor instead')
const AddSourceRequest$json = {
  '1': 'AddSourceRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `AddSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addSourceRequestDescriptor = $convert.base64Decode(
    'ChBBZGRTb3VyY2VSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEhAKA3VybBgCIA'
    'EoCVIDdXJs');

@$core.Deprecated('Use removeSourceRequestDescriptor instead')
const RemoveSourceRequest$json = {
  '1': 'RemoveSourceRequest',
  '2': [
    {'1': 'manga_source_id', '3': 1, '4': 1, '5': 5, '10': 'mangaSourceId'},
  ],
};

/// Descriptor for `RemoveSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeSourceRequestDescriptor = $convert.base64Decode(
    'ChNSZW1vdmVTb3VyY2VSZXF1ZXN0EiYKD21hbmdhX3NvdXJjZV9pZBgBIAEoBVINbWFuZ2FTb3'
    'VyY2VJZA==');

@$core.Deprecated('Use setPrimarySourceRequestDescriptor instead')
const SetPrimarySourceRequest$json = {
  '1': 'SetPrimarySourceRequest',
  '2': [
    {'1': 'manga_source_id', '3': 1, '4': 1, '5': 5, '10': 'mangaSourceId'},
  ],
};

/// Descriptor for `SetPrimarySourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrimarySourceRequestDescriptor =
    $convert.base64Decode(
        'ChdTZXRQcmltYXJ5U291cmNlUmVxdWVzdBImCg9tYW5nYV9zb3VyY2VfaWQYASABKAVSDW1hbm'
        'dhU291cmNlSWQ=');
