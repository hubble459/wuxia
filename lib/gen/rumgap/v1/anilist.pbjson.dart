// This is a generated file - do not edit.
//
// Generated from rumgap/v1/anilist.proto.

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

@$core.Deprecated('Use anilistReturnTargetDescriptor instead')
const AnilistReturnTarget$json = {
  '1': 'AnilistReturnTarget',
  '2': [
    {'1': 'ANILIST_RETURN_APP', '2': 0},
    {'1': 'ANILIST_RETURN_WEB', '2': 1},
  ],
};

/// Descriptor for `AnilistReturnTarget`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List anilistReturnTargetDescriptor = $convert.base64Decode(
    'ChNBbmlsaXN0UmV0dXJuVGFyZ2V0EhYKEkFOSUxJU1RfUkVUVVJOX0FQUBAAEhYKEkFOSUxJU1'
    'RfUkVUVVJOX1dFQhAB');

@$core.Deprecated('Use anilistListStatusDescriptor instead')
const AnilistListStatus$json = {
  '1': 'AnilistListStatus',
  '2': [
    {'1': 'ANILIST_LIST_NONE', '2': 0},
    {'1': 'ANILIST_LIST_CURRENT', '2': 1},
    {'1': 'ANILIST_LIST_PLANNING', '2': 2},
    {'1': 'ANILIST_LIST_COMPLETED', '2': 3},
    {'1': 'ANILIST_LIST_DROPPED', '2': 4},
    {'1': 'ANILIST_LIST_PAUSED', '2': 5},
    {'1': 'ANILIST_LIST_REPEATING', '2': 6},
  ],
};

/// Descriptor for `AnilistListStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List anilistListStatusDescriptor = $convert.base64Decode(
    'ChFBbmlsaXN0TGlzdFN0YXR1cxIVChFBTklMSVNUX0xJU1RfTk9ORRAAEhgKFEFOSUxJU1RfTE'
    'lTVF9DVVJSRU5UEAESGQoVQU5JTElTVF9MSVNUX1BMQU5OSU5HEAISGgoWQU5JTElTVF9MSVNU'
    'X0NPTVBMRVRFRBADEhgKFEFOSUxJU1RfTElTVF9EUk9QUEVEEAQSFwoTQU5JTElTVF9MSVNUX1'
    'BBVVNFRBAFEhoKFkFOSUxJU1RfTElTVF9SRVBFQVRJTkcQBg==');

@$core.Deprecated('Use anilistInfoDescriptor instead')
const AnilistInfo$json = {
  '1': 'AnilistInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'title', '17': true},
    {
      '1': 'description',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'description',
      '17': true
    },
    {'1': 'cover', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'cover', '17': true},
    {'1': 'banner', '3': 6, '4': 1, '5': 9, '9': 3, '10': 'banner', '17': true},
    {'1': 'score', '3': 7, '4': 1, '5': 5, '9': 4, '10': 'score', '17': true},
    {'1': 'genres', '3': 8, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'status', '3': 9, '4': 1, '5': 9, '9': 5, '10': 'status', '17': true},
    {'1': 'match_manual', '3': 10, '4': 1, '5': 8, '10': 'matchManual'},
  ],
  '8': [
    {'1': '_title'},
    {'1': '_description'},
    {'1': '_cover'},
    {'1': '_banner'},
    {'1': '_score'},
    {'1': '_status'},
  ],
};

/// Descriptor for `AnilistInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistInfoDescriptor = $convert.base64Decode(
    'CgtBbmlsaXN0SW5mbxIOCgJpZBgBIAEoBVICaWQSEAoDdXJsGAIgASgJUgN1cmwSGQoFdGl0bG'
    'UYAyABKAlIAFIFdGl0bGWIAQESJQoLZGVzY3JpcHRpb24YBCABKAlIAVILZGVzY3JpcHRpb26I'
    'AQESGQoFY292ZXIYBSABKAlIAlIFY292ZXKIAQESGwoGYmFubmVyGAYgASgJSANSBmJhbm5lco'
    'gBARIZCgVzY29yZRgHIAEoBUgEUgVzY29yZYgBARIWCgZnZW5yZXMYCCADKAlSBmdlbnJlcxIb'
    'CgZzdGF0dXMYCSABKAlIBVIGc3RhdHVziAEBEiEKDG1hdGNoX21hbnVhbBgKIAEoCFILbWF0Y2'
    'hNYW51YWxCCAoGX3RpdGxlQg4KDF9kZXNjcmlwdGlvbkIICgZfY292ZXJCCQoHX2Jhbm5lckII'
    'CgZfc2NvcmVCCQoHX3N0YXR1cw==');

@$core.Deprecated('Use anilistConnectUrlRequestDescriptor instead')
const AnilistConnectUrlRequest$json = {
  '1': 'AnilistConnectUrlRequest',
  '2': [
    {
      '1': 'return_target',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.AnilistReturnTarget',
      '10': 'returnTarget'
    },
  ],
};

/// Descriptor for `AnilistConnectUrlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistConnectUrlRequestDescriptor =
    $convert.base64Decode(
        'ChhBbmlsaXN0Q29ubmVjdFVybFJlcXVlc3QSQwoNcmV0dXJuX3RhcmdldBgBIAEoDjIeLnJ1bW'
        'dhcC52MS5BbmlsaXN0UmV0dXJuVGFyZ2V0UgxyZXR1cm5UYXJnZXQ=');

@$core.Deprecated('Use anilistConnectUrlReplyDescriptor instead')
const AnilistConnectUrlReply$json = {
  '1': 'AnilistConnectUrlReply',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `AnilistConnectUrlReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistConnectUrlReplyDescriptor = $convert
    .base64Decode('ChZBbmlsaXN0Q29ubmVjdFVybFJlcGx5EhAKA3VybBgBIAEoCVIDdXJs');

@$core.Deprecated('Use anilistStatusReplyDescriptor instead')
const AnilistStatusReply$json = {
  '1': 'AnilistStatusReply',
  '2': [
    {'1': 'connected', '3': 1, '4': 1, '5': 8, '10': 'connected'},
    {
      '1': 'user_id',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'userId',
      '17': true
    },
    {
      '1': 'user_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'userName',
      '17': true
    },
    {
      '1': 'expires_at',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'expiresAt',
      '17': true
    },
    {'1': 'expires_soon', '3': 5, '4': 1, '5': 8, '10': 'expiresSoon'},
  ],
  '8': [
    {'1': '_user_id'},
    {'1': '_user_name'},
    {'1': '_expires_at'},
  ],
};

/// Descriptor for `AnilistStatusReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistStatusReplyDescriptor = $convert.base64Decode(
    'ChJBbmlsaXN0U3RhdHVzUmVwbHkSHAoJY29ubmVjdGVkGAEgASgIUgljb25uZWN0ZWQSHAoHdX'
    'Nlcl9pZBgCIAEoBUgAUgZ1c2VySWSIAQESIAoJdXNlcl9uYW1lGAMgASgJSAFSCHVzZXJOYW1l'
    'iAEBEiIKCmV4cGlyZXNfYXQYBCABKANIAlIJZXhwaXJlc0F0iAEBEiEKDGV4cGlyZXNfc29vbh'
    'gFIAEoCFILZXhwaXJlc1Nvb25CCgoIX3VzZXJfaWRCDAoKX3VzZXJfbmFtZUINCgtfZXhwaXJl'
    'c19hdA==');

@$core.Deprecated('Use anilistSearchRequestDescriptor instead')
const AnilistSearchRequest$json = {
  '1': 'AnilistSearchRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `AnilistSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistSearchRequestDescriptor =
    $convert.base64Decode(
        'ChRBbmlsaXN0U2VhcmNoUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnk=');

@$core.Deprecated('Use anilistMediaDescriptor instead')
const AnilistMedia$json = {
  '1': 'AnilistMedia',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {
      '1': 'title_romaji',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'titleRomaji',
      '17': true
    },
    {
      '1': 'title_english',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'titleEnglish',
      '17': true
    },
    {
      '1': 'title_native',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'titleNative',
      '17': true
    },
    {'1': 'synonyms', '3': 6, '4': 3, '5': 9, '10': 'synonyms'},
    {'1': 'cover', '3': 7, '4': 1, '5': 9, '9': 3, '10': 'cover', '17': true},
    {
      '1': 'chapters',
      '3': 8,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'chapters',
      '17': true
    },
    {'1': 'status', '3': 9, '4': 1, '5': 9, '9': 5, '10': 'status', '17': true},
    {
      '1': 'format',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'format',
      '17': true
    },
    {
      '1': 'start_year',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 7,
      '10': 'startYear',
      '17': true
    },
  ],
  '8': [
    {'1': '_title_romaji'},
    {'1': '_title_english'},
    {'1': '_title_native'},
    {'1': '_cover'},
    {'1': '_chapters'},
    {'1': '_status'},
    {'1': '_format'},
    {'1': '_start_year'},
  ],
};

/// Descriptor for `AnilistMedia`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistMediaDescriptor = $convert.base64Decode(
    'CgxBbmlsaXN0TWVkaWESDgoCaWQYASABKAVSAmlkEhAKA3VybBgCIAEoCVIDdXJsEiYKDHRpdG'
    'xlX3JvbWFqaRgDIAEoCUgAUgt0aXRsZVJvbWFqaYgBARIoCg10aXRsZV9lbmdsaXNoGAQgASgJ'
    'SAFSDHRpdGxlRW5nbGlzaIgBARImCgx0aXRsZV9uYXRpdmUYBSABKAlIAlILdGl0bGVOYXRpdm'
    'WIAQESGgoIc3lub255bXMYBiADKAlSCHN5bm9ueW1zEhkKBWNvdmVyGAcgASgJSANSBWNvdmVy'
    'iAEBEh8KCGNoYXB0ZXJzGAggASgFSARSCGNoYXB0ZXJziAEBEhsKBnN0YXR1cxgJIAEoCUgFUg'
    'ZzdGF0dXOIAQESGwoGZm9ybWF0GAogASgJSAZSBmZvcm1hdIgBARIiCgpzdGFydF95ZWFyGAsg'
    'ASgFSAdSCXN0YXJ0WWVhcogBAUIPCg1fdGl0bGVfcm9tYWppQhAKDl90aXRsZV9lbmdsaXNoQg'
    '8KDV90aXRsZV9uYXRpdmVCCAoGX2NvdmVyQgsKCV9jaGFwdGVyc0IJCgdfc3RhdHVzQgkKB19m'
    'b3JtYXRCDQoLX3N0YXJ0X3llYXI=');

@$core.Deprecated('Use anilistSearchReplyDescriptor instead')
const AnilistSearchReply$json = {
  '1': 'AnilistSearchReply',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.AnilistMedia',
      '10': 'items'
    },
  ],
};

/// Descriptor for `AnilistSearchReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistSearchReplyDescriptor = $convert.base64Decode(
    'ChJBbmlsaXN0U2VhcmNoUmVwbHkSLQoFaXRlbXMYASADKAsyFy5ydW1nYXAudjEuQW5pbGlzdE'
    '1lZGlhUgVpdGVtcw==');

@$core.Deprecated('Use setAnilistMatchRequestDescriptor instead')
const SetAnilistMatchRequest$json = {
  '1': 'SetAnilistMatchRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {
      '1': 'anilist_id',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'anilistId',
      '17': true
    },
    {'1': 'rematch', '3': 3, '4': 1, '5': 8, '10': 'rematch'},
  ],
  '8': [
    {'1': '_anilist_id'},
  ],
};

/// Descriptor for `SetAnilistMatchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setAnilistMatchRequestDescriptor = $convert.base64Decode(
    'ChZTZXRBbmlsaXN0TWF0Y2hSZXF1ZXN0EhkKCG1hbmdhX2lkGAEgASgFUgdtYW5nYUlkEiIKCm'
    'FuaWxpc3RfaWQYAiABKAVIAFIJYW5pbGlzdElkiAEBEhgKB3JlbWF0Y2gYAyABKAhSB3JlbWF0'
    'Y2hCDQoLX2FuaWxpc3RfaWQ=');

@$core.Deprecated('Use anilistListEntryRequestDescriptor instead')
const AnilistListEntryRequest$json = {
  '1': 'AnilistListEntryRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
  ],
};

/// Descriptor for `AnilistListEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistListEntryRequestDescriptor =
    $convert.base64Decode(
        'ChdBbmlsaXN0TGlzdEVudHJ5UmVxdWVzdBIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZA==');

@$core.Deprecated('Use anilistListEntryReplyDescriptor instead')
const AnilistListEntryReply$json = {
  '1': 'AnilistListEntryReply',
  '2': [
    {'1': 'connected', '3': 1, '4': 1, '5': 8, '10': 'connected'},
    {'1': 'matched', '3': 2, '4': 1, '5': 8, '10': 'matched'},
    {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.AnilistListStatus',
      '10': 'status'
    },
    {'1': 'progress', '3': 4, '4': 1, '5': 5, '10': 'progress'},
  ],
};

/// Descriptor for `AnilistListEntryReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anilistListEntryReplyDescriptor = $convert.base64Decode(
    'ChVBbmlsaXN0TGlzdEVudHJ5UmVwbHkSHAoJY29ubmVjdGVkGAEgASgIUgljb25uZWN0ZWQSGA'
    'oHbWF0Y2hlZBgCIAEoCFIHbWF0Y2hlZBI0CgZzdGF0dXMYAyABKA4yHC5ydW1nYXAudjEuQW5p'
    'bGlzdExpc3RTdGF0dXNSBnN0YXR1cxIaCghwcm9ncmVzcxgEIAEoBVIIcHJvZ3Jlc3M=');

@$core.Deprecated('Use setAnilistListStatusRequestDescriptor instead')
const SetAnilistListStatusRequest$json = {
  '1': 'SetAnilistListStatusRequest',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.AnilistListStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `SetAnilistListStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setAnilistListStatusRequestDescriptor =
    $convert.base64Decode(
        'ChtTZXRBbmlsaXN0TGlzdFN0YXR1c1JlcXVlc3QSGQoIbWFuZ2FfaWQYASABKAVSB21hbmdhSW'
        'QSNAoGc3RhdHVzGAIgASgOMhwucnVtZ2FwLnYxLkFuaWxpc3RMaXN0U3RhdHVzUgZzdGF0dXM=');
