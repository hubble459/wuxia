// This is a generated file - do not edit.
//
// Generated from rumgap/v1/search.proto.

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

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = {
  '1': 'SearchRequest',
  '2': [
    {'1': 'keyword', '3': 1, '4': 1, '5': 9, '10': 'keyword'},
    {'1': 'hostnames', '3': 2, '4': 3, '5': 9, '10': 'hostnames'},
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode(
    'Cg1TZWFyY2hSZXF1ZXN0EhgKB2tleXdvcmQYASABKAlSB2tleXdvcmQSHAoJaG9zdG5hbWVzGA'
    'IgAygJUglob3N0bmFtZXM=');

@$core.Deprecated('Use searchMangaDescriptor instead')
const SearchManga$json = {
  '1': 'SearchManga',
  '2': [
    {
      '1': 'manga_id',
      '3': 1,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'mangaId',
      '17': true
    },
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
    {'1': 'posted', '3': 4, '4': 1, '5': 3, '9': 1, '10': 'posted', '17': true},
    {'1': 'cover', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'cover', '17': true},
    {'1': 'is_reading', '3': 6, '4': 1, '5': 8, '10': 'isReading'},
  ],
  '8': [
    {'1': '_manga_id'},
    {'1': '_posted'},
    {'1': '_cover'},
  ],
};

/// Descriptor for `SearchManga`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchMangaDescriptor = $convert.base64Decode(
    'CgtTZWFyY2hNYW5nYRIeCghtYW5nYV9pZBgBIAEoBUgAUgdtYW5nYUlkiAEBEhQKBXRpdGxlGA'
    'IgASgJUgV0aXRsZRIQCgN1cmwYAyABKAlSA3VybBIbCgZwb3N0ZWQYBCABKANIAVIGcG9zdGVk'
    'iAEBEhkKBWNvdmVyGAUgASgJSAJSBWNvdmVyiAEBEh0KCmlzX3JlYWRpbmcYBiABKAhSCWlzUm'
    'VhZGluZ0ILCglfbWFuZ2FfaWRCCQoHX3Bvc3RlZEIICgZfY292ZXI=');

@$core.Deprecated('Use searchReplyDescriptor instead')
const SearchReply$json = {
  '1': 'SearchReply',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.SearchManga',
      '10': 'items'
    },
  ],
};

/// Descriptor for `SearchReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchReplyDescriptor = $convert.base64Decode(
    'CgtTZWFyY2hSZXBseRIsCgVpdGVtcxgBIAMoCzIWLnJ1bWdhcC52MS5TZWFyY2hNYW5nYVIFaX'
    'RlbXM=');
