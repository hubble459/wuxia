// This is a generated file - do not edit.
//
// Generated from rumgap/v1/meta.proto.

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

@$core.Deprecated('Use metaHostnamesOptionDescriptor instead')
const MetaHostnamesOption$json = {
  '1': 'MetaHostnamesOption',
  '2': [
    {'1': 'HostnamesReading', '2': 0},
    {'1': 'HostnamesManga', '2': 1},
    {'1': 'HostnamesOnline', '2': 2},
  ],
};

/// Descriptor for `MetaHostnamesOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaHostnamesOptionDescriptor = $convert.base64Decode(
    'ChNNZXRhSG9zdG5hbWVzT3B0aW9uEhQKEEhvc3RuYW1lc1JlYWRpbmcQABISCg5Ib3N0bmFtZX'
    'NNYW5nYRABEhMKD0hvc3RuYW1lc09ubGluZRAC');

@$core.Deprecated('Use metaGenresOptionDescriptor instead')
const MetaGenresOption$json = {
  '1': 'MetaGenresOption',
  '2': [
    {'1': 'GenresReading', '2': 0},
    {'1': 'GenresManga', '2': 1},
  ],
};

/// Descriptor for `MetaGenresOption`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List metaGenresOptionDescriptor = $convert.base64Decode(
    'ChBNZXRhR2VucmVzT3B0aW9uEhEKDUdlbnJlc1JlYWRpbmcQABIPCgtHZW5yZXNNYW5nYRAB');

@$core.Deprecated('Use metaReplyDescriptor instead')
const MetaReply$json = {
  '1': 'MetaReply',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 9, '10': 'items'},
  ],
};

/// Descriptor for `MetaReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaReplyDescriptor =
    $convert.base64Decode('CglNZXRhUmVwbHkSFAoFaXRlbXMYASADKAlSBWl0ZW1z');

@$core.Deprecated('Use metaHostnamesRequestDescriptor instead')
const MetaHostnamesRequest$json = {
  '1': 'MetaHostnamesRequest',
  '2': [
    {
      '1': 'option',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.MetaHostnamesOption',
      '9': 0,
      '10': 'option',
      '17': true
    },
  ],
  '8': [
    {'1': '_option'},
  ],
};

/// Descriptor for `MetaHostnamesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaHostnamesRequestDescriptor = $convert.base64Decode(
    'ChRNZXRhSG9zdG5hbWVzUmVxdWVzdBI7CgZvcHRpb24YASABKA4yHi5ydW1nYXAudjEuTWV0YU'
    'hvc3RuYW1lc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');

@$core.Deprecated('Use metaGenresRequestDescriptor instead')
const MetaGenresRequest$json = {
  '1': 'MetaGenresRequest',
  '2': [
    {
      '1': 'option',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.rumgap.v1.MetaGenresOption',
      '9': 0,
      '10': 'option',
      '17': true
    },
  ],
  '8': [
    {'1': '_option'},
  ],
};

/// Descriptor for `MetaGenresRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List metaGenresRequestDescriptor = $convert.base64Decode(
    'ChFNZXRhR2VucmVzUmVxdWVzdBI4CgZvcHRpb24YASABKA4yGy5ydW1nYXAudjEuTWV0YUdlbn'
    'Jlc09wdGlvbkgAUgZvcHRpb26IAQFCCQoHX29wdGlvbg==');

@$core.Deprecated('Use statsReplyDescriptor instead')
const StatsReply$json = {
  '1': 'StatsReply',
  '2': [
    {
      '1': 'count_total_reading',
      '3': 1,
      '4': 1,
      '5': 3,
      '10': 'countTotalReading'
    },
    {
      '1': 'count_total_chapters',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'countTotalChapters'
    },
    {'1': 'count_reading', '3': 3, '4': 1, '5': 3, '10': 'countReading'},
    {'1': 'count_chapters', '3': 4, '4': 1, '5': 3, '10': 'countChapters'},
  ],
};

/// Descriptor for `StatsReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsReplyDescriptor = $convert.base64Decode(
    'CgpTdGF0c1JlcGx5Ei4KE2NvdW50X3RvdGFsX3JlYWRpbmcYASABKANSEWNvdW50VG90YWxSZW'
    'FkaW5nEjAKFGNvdW50X3RvdGFsX2NoYXB0ZXJzGAIgASgDUhJjb3VudFRvdGFsQ2hhcHRlcnMS'
    'IwoNY291bnRfcmVhZGluZxgDIAEoA1IMY291bnRSZWFkaW5nEiUKDmNvdW50X2NoYXB0ZXJzGA'
    'QgASgDUg1jb3VudENoYXB0ZXJz');

@$core.Deprecated('Use detailedStatsRequestDescriptor instead')
const DetailedStatsRequest$json = {
  '1': 'DetailedStatsRequest',
  '2': [
    {
      '1': 'utc_offset_minutes',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'utcOffsetMinutes'
    },
  ],
};

/// Descriptor for `DetailedStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detailedStatsRequestDescriptor = $convert.base64Decode(
    'ChREZXRhaWxlZFN0YXRzUmVxdWVzdBIsChJ1dGNfb2Zmc2V0X21pbnV0ZXMYASABKAVSEHV0Y0'
    '9mZnNldE1pbnV0ZXM=');

@$core.Deprecated('Use statsDayDescriptor instead')
const StatsDay$json = {
  '1': 'StatsDay',
  '2': [
    {'1': 'day', '3': 1, '4': 1, '5': 5, '10': 'day'},
    {'1': 'chapters', '3': 2, '4': 1, '5': 3, '10': 'chapters'},
  ],
};

/// Descriptor for `StatsDay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsDayDescriptor = $convert.base64Decode(
    'CghTdGF0c0RheRIQCgNkYXkYASABKAVSA2RheRIaCghjaGFwdGVycxgCIAEoA1IIY2hhcHRlcn'
    'M=');

@$core.Deprecated('Use statsCountDescriptor instead')
const StatsCount$json = {
  '1': 'StatsCount',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'series', '3': 2, '4': 1, '5': 3, '10': 'series'},
    {'1': 'chapters', '3': 3, '4': 1, '5': 3, '10': 'chapters'},
  ],
};

/// Descriptor for `StatsCount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsCountDescriptor = $convert.base64Decode(
    'CgpTdGF0c0NvdW50EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGc2VyaWVzGAIgASgDUgZzZXJpZX'
    'MSGgoIY2hhcHRlcnMYAyABKANSCGNoYXB0ZXJz');

@$core.Deprecated('Use statsSeriesDescriptor instead')
const StatsSeries$json = {
  '1': 'StatsSeries',
  '2': [
    {'1': 'manga_id', '3': 1, '4': 1, '5': 5, '10': 'mangaId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'cover', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'cover', '17': true},
    {'1': 'progress', '3': 4, '4': 1, '5': 3, '10': 'progress'},
    {'1': 'total', '3': 5, '4': 1, '5': 3, '10': 'total'},
    {'1': 'amount', '3': 6, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'at', '3': 7, '4': 1, '5': 3, '10': 'at'},
  ],
  '8': [
    {'1': '_cover'},
  ],
};

/// Descriptor for `StatsSeries`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsSeriesDescriptor = $convert.base64Decode(
    'CgtTdGF0c1NlcmllcxIZCghtYW5nYV9pZBgBIAEoBVIHbWFuZ2FJZBIUCgV0aXRsZRgCIAEoCV'
    'IFdGl0bGUSGQoFY292ZXIYAyABKAlIAFIFY292ZXKIAQESGgoIcHJvZ3Jlc3MYBCABKANSCHBy'
    'b2dyZXNzEhQKBXRvdGFsGAUgASgDUgV0b3RhbBIWCgZhbW91bnQYBiABKANSBmFtb3VudBIOCg'
    'JhdBgHIAEoA1ICYXRCCAoGX2NvdmVy');

@$core.Deprecated('Use statsFriendDescriptor instead')
const StatsFriend$json = {
  '1': 'StatsFriend',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 5, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'is_me', '3': 3, '4': 1, '5': 8, '10': 'isMe'},
    {'1': 'chapters_30d', '3': 4, '4': 1, '5': 3, '10': 'chapters30d'},
    {'1': 'chapters_total', '3': 5, '4': 1, '5': 3, '10': 'chaptersTotal'},
    {'1': 'current_streak', '3': 6, '4': 1, '5': 5, '10': 'currentStreak'},
    {'1': 'longest_streak', '3': 7, '4': 1, '5': 5, '10': 'longestStreak'},
    {'1': 'shared_count', '3': 8, '4': 1, '5': 3, '10': 'sharedCount'},
    {'1': 'shared_titles', '3': 9, '4': 3, '5': 9, '10': 'sharedTitles'},
  ],
};

/// Descriptor for `StatsFriend`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsFriendDescriptor = $convert.base64Decode(
    'CgtTdGF0c0ZyaWVuZBIXCgd1c2VyX2lkGAEgASgFUgZ1c2VySWQSGgoIdXNlcm5hbWUYAiABKA'
    'lSCHVzZXJuYW1lEhMKBWlzX21lGAMgASgIUgRpc01lEiEKDGNoYXB0ZXJzXzMwZBgEIAEoA1IL'
    'Y2hhcHRlcnMzMGQSJQoOY2hhcHRlcnNfdG90YWwYBSABKANSDWNoYXB0ZXJzVG90YWwSJQoOY3'
    'VycmVudF9zdHJlYWsYBiABKAVSDWN1cnJlbnRTdHJlYWsSJQoObG9uZ2VzdF9zdHJlYWsYByAB'
    'KAVSDWxvbmdlc3RTdHJlYWsSIQoMc2hhcmVkX2NvdW50GAggASgDUgtzaGFyZWRDb3VudBIjCg'
    '1zaGFyZWRfdGl0bGVzGAkgAygJUgxzaGFyZWRUaXRsZXM=');

@$core.Deprecated('Use statsYearDescriptor instead')
const StatsYear$json = {
  '1': 'StatsYear',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'chapters', '3': 2, '4': 1, '5': 3, '10': 'chapters'},
    {'1': 'minutes', '3': 3, '4': 1, '5': 3, '10': 'minutes'},
    {'1': 'new_series', '3': 4, '4': 1, '5': 3, '10': 'newSeries'},
    {'1': 'finished_series', '3': 5, '4': 1, '5': 3, '10': 'finishedSeries'},
    {'1': 'active_days', '3': 6, '4': 1, '5': 3, '10': 'activeDays'},
    {
      '1': 'top_series',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '9': 0,
      '10': 'topSeries',
      '17': true
    },
    {
      '1': 'top_genre',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'topGenre',
      '17': true
    },
    {'1': 'top_month', '3': 9, '4': 1, '5': 5, '10': 'topMonth'},
    {
      '1': 'top_month_chapters',
      '3': 10,
      '4': 1,
      '5': 3,
      '10': 'topMonthChapters'
    },
    {'1': 'months', '3': 11, '4': 3, '5': 3, '10': 'months'},
  ],
  '8': [
    {'1': '_top_series'},
    {'1': '_top_genre'},
  ],
};

/// Descriptor for `StatsYear`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statsYearDescriptor = $convert.base64Decode(
    'CglTdGF0c1llYXISEgoEeWVhchgBIAEoBVIEeWVhchIaCghjaGFwdGVycxgCIAEoA1IIY2hhcH'
    'RlcnMSGAoHbWludXRlcxgDIAEoA1IHbWludXRlcxIdCgpuZXdfc2VyaWVzGAQgASgDUgluZXdT'
    'ZXJpZXMSJwoPZmluaXNoZWRfc2VyaWVzGAUgASgDUg5maW5pc2hlZFNlcmllcxIfCgthY3Rpdm'
    'VfZGF5cxgGIAEoA1IKYWN0aXZlRGF5cxI6Cgp0b3Bfc2VyaWVzGAcgASgLMhYucnVtZ2FwLnYx'
    'LlN0YXRzU2VyaWVzSABSCXRvcFNlcmllc4gBARIgCgl0b3BfZ2VucmUYCCABKAlIAVIIdG9wR2'
    'VucmWIAQESGwoJdG9wX21vbnRoGAkgASgFUgh0b3BNb250aBIsChJ0b3BfbW9udGhfY2hhcHRl'
    'cnMYCiABKANSEHRvcE1vbnRoQ2hhcHRlcnMSFgoGbW9udGhzGAsgAygDUgZtb250aHNCDQoLX3'
    'RvcF9zZXJpZXNCDAoKX3RvcF9nZW5yZQ==');

@$core.Deprecated('Use detailedStatsReplyDescriptor instead')
const DetailedStatsReply$json = {
  '1': 'DetailedStatsReply',
  '2': [
    {'1': 'chapters_read', '3': 1, '4': 1, '5': 3, '10': 'chaptersRead'},
    {'1': 'chapters_opened', '3': 2, '4': 1, '5': 3, '10': 'chaptersOpened'},
    {'1': 'pages_read', '3': 3, '4': 1, '5': 3, '10': 'pagesRead'},
    {'1': 'screens_scrolled', '3': 4, '4': 1, '5': 1, '10': 'screensScrolled'},
    {'1': 'minutes_read', '3': 5, '4': 1, '5': 3, '10': 'minutesRead'},
    {'1': 'series_total', '3': 6, '4': 1, '5': 3, '10': 'seriesTotal'},
    {'1': 'series_completed', '3': 7, '4': 1, '5': 3, '10': 'seriesCompleted'},
    {
      '1': 'series_in_progress',
      '3': 8,
      '4': 1,
      '5': 3,
      '10': 'seriesInProgress'
    },
    {
      '1': 'series_not_started',
      '3': 9,
      '4': 1,
      '5': 3,
      '10': 'seriesNotStarted'
    },
    {'1': 'series_dropped', '3': 10, '4': 1, '5': 3, '10': 'seriesDropped'},
    {'1': 'series_ongoing', '3': 11, '4': 1, '5': 3, '10': 'seriesOngoing'},
    {'1': 'backlog_chapters', '3': 12, '4': 1, '5': 3, '10': 'backlogChapters'},
    {'1': 'library_chapters', '3': 13, '4': 1, '5': 3, '10': 'libraryChapters'},
    {
      '1': 'minutes_per_chapter',
      '3': 14,
      '4': 1,
      '5': 1,
      '10': 'minutesPerChapter'
    },
    {
      '1': 'days',
      '3': 20,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsDay',
      '10': 'days'
    },
    {'1': 'hours', '3': 21, '4': 3, '5': 3, '10': 'hours'},
    {'1': 'weekdays', '3': 22, '4': 3, '5': 3, '10': 'weekdays'},
    {'1': 'current_streak', '3': 23, '4': 1, '5': 5, '10': 'currentStreak'},
    {'1': 'longest_streak', '3': 24, '4': 1, '5': 5, '10': 'longestStreak'},
    {'1': 'sessions', '3': 25, '4': 1, '5': 3, '10': 'sessions'},
    {
      '1': 'longest_session_minutes',
      '3': 26,
      '4': 1,
      '5': 3,
      '10': 'longestSessionMinutes'
    },
    {
      '1': 'biggest_binge',
      '3': 27,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '9': 0,
      '10': 'biggestBinge',
      '17': true
    },
    {
      '1': 'first_read_at',
      '3': 28,
      '4': 1,
      '5': 3,
      '9': 1,
      '10': 'firstReadAt',
      '17': true
    },
    {'1': 'member_since', '3': 29, '4': 1, '5': 3, '10': 'memberSince'},
    {'1': 'chapters_30d', '3': 30, '4': 1, '5': 3, '10': 'chapters30d'},
    {
      '1': 'genres',
      '3': 40,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsCount',
      '10': 'genres'
    },
    {
      '1': 'authors',
      '3': 41,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsCount',
      '10': 'authors'
    },
    {
      '1': 'hosts',
      '3': 42,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsCount',
      '10': 'hosts'
    },
    {
      '1': 'languages',
      '3': 43,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsCount',
      '10': 'languages'
    },
    {
      '1': 'most_read',
      '3': 50,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '10': 'mostRead'
    },
    {
      '1': 'recently_finished',
      '3': 51,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '10': 'recentlyFinished'
    },
    {
      '1': 'abandoned',
      '3': 52,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '10': 'abandoned'
    },
    {
      '1': 'fastest_finish',
      '3': 53,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '9': 2,
      '10': 'fastestFinish',
      '17': true
    },
    {
      '1': 'longest_relationship',
      '3': 54,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.StatsSeries',
      '9': 3,
      '10': 'longestRelationship',
      '17': true
    },
    {
      '1': 'friends',
      '3': 60,
      '4': 3,
      '5': 11,
      '6': '.rumgap.v1.StatsFriend',
      '10': 'friends'
    },
    {
      '1': 'year',
      '3': 70,
      '4': 1,
      '5': 11,
      '6': '.rumgap.v1.StatsYear',
      '9': 4,
      '10': 'year',
      '17': true
    },
  ],
  '8': [
    {'1': '_biggest_binge'},
    {'1': '_first_read_at'},
    {'1': '_fastest_finish'},
    {'1': '_longest_relationship'},
    {'1': '_year'},
  ],
};

/// Descriptor for `DetailedStatsReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detailedStatsReplyDescriptor = $convert.base64Decode(
    'ChJEZXRhaWxlZFN0YXRzUmVwbHkSIwoNY2hhcHRlcnNfcmVhZBgBIAEoA1IMY2hhcHRlcnNSZW'
    'FkEicKD2NoYXB0ZXJzX29wZW5lZBgCIAEoA1IOY2hhcHRlcnNPcGVuZWQSHQoKcGFnZXNfcmVh'
    'ZBgDIAEoA1IJcGFnZXNSZWFkEikKEHNjcmVlbnNfc2Nyb2xsZWQYBCABKAFSD3NjcmVlbnNTY3'
    'JvbGxlZBIhCgxtaW51dGVzX3JlYWQYBSABKANSC21pbnV0ZXNSZWFkEiEKDHNlcmllc190b3Rh'
    'bBgGIAEoA1ILc2VyaWVzVG90YWwSKQoQc2VyaWVzX2NvbXBsZXRlZBgHIAEoA1IPc2VyaWVzQ2'
    '9tcGxldGVkEiwKEnNlcmllc19pbl9wcm9ncmVzcxgIIAEoA1IQc2VyaWVzSW5Qcm9ncmVzcxIs'
    'ChJzZXJpZXNfbm90X3N0YXJ0ZWQYCSABKANSEHNlcmllc05vdFN0YXJ0ZWQSJQoOc2VyaWVzX2'
    'Ryb3BwZWQYCiABKANSDXNlcmllc0Ryb3BwZWQSJQoOc2VyaWVzX29uZ29pbmcYCyABKANSDXNl'
    'cmllc09uZ29pbmcSKQoQYmFja2xvZ19jaGFwdGVycxgMIAEoA1IPYmFja2xvZ0NoYXB0ZXJzEi'
    'kKEGxpYnJhcnlfY2hhcHRlcnMYDSABKANSD2xpYnJhcnlDaGFwdGVycxIuChNtaW51dGVzX3Bl'
    'cl9jaGFwdGVyGA4gASgBUhFtaW51dGVzUGVyQ2hhcHRlchInCgRkYXlzGBQgAygLMhMucnVtZ2'
    'FwLnYxLlN0YXRzRGF5UgRkYXlzEhQKBWhvdXJzGBUgAygDUgVob3VycxIaCgh3ZWVrZGF5cxgW'
    'IAMoA1IId2Vla2RheXMSJQoOY3VycmVudF9zdHJlYWsYFyABKAVSDWN1cnJlbnRTdHJlYWsSJQ'
    'oObG9uZ2VzdF9zdHJlYWsYGCABKAVSDWxvbmdlc3RTdHJlYWsSGgoIc2Vzc2lvbnMYGSABKANS'
    'CHNlc3Npb25zEjYKF2xvbmdlc3Rfc2Vzc2lvbl9taW51dGVzGBogASgDUhVsb25nZXN0U2Vzc2'
    'lvbk1pbnV0ZXMSQAoNYmlnZ2VzdF9iaW5nZRgbIAEoCzIWLnJ1bWdhcC52MS5TdGF0c1Nlcmll'
    'c0gAUgxiaWdnZXN0QmluZ2WIAQESJwoNZmlyc3RfcmVhZF9hdBgcIAEoA0gBUgtmaXJzdFJlYW'
    'RBdIgBARIhCgxtZW1iZXJfc2luY2UYHSABKANSC21lbWJlclNpbmNlEiEKDGNoYXB0ZXJzXzMw'
    'ZBgeIAEoA1ILY2hhcHRlcnMzMGQSLQoGZ2VucmVzGCggAygLMhUucnVtZ2FwLnYxLlN0YXRzQ2'
    '91bnRSBmdlbnJlcxIvCgdhdXRob3JzGCkgAygLMhUucnVtZ2FwLnYxLlN0YXRzQ291bnRSB2F1'
    'dGhvcnMSKwoFaG9zdHMYKiADKAsyFS5ydW1nYXAudjEuU3RhdHNDb3VudFIFaG9zdHMSMwoJbG'
    'FuZ3VhZ2VzGCsgAygLMhUucnVtZ2FwLnYxLlN0YXRzQ291bnRSCWxhbmd1YWdlcxIzCgltb3N0'
    'X3JlYWQYMiADKAsyFi5ydW1nYXAudjEuU3RhdHNTZXJpZXNSCG1vc3RSZWFkEkMKEXJlY2VudG'
    'x5X2ZpbmlzaGVkGDMgAygLMhYucnVtZ2FwLnYxLlN0YXRzU2VyaWVzUhByZWNlbnRseUZpbmlz'
    'aGVkEjQKCWFiYW5kb25lZBg0IAMoCzIWLnJ1bWdhcC52MS5TdGF0c1Nlcmllc1IJYWJhbmRvbm'
    'VkEkIKDmZhc3Rlc3RfZmluaXNoGDUgASgLMhYucnVtZ2FwLnYxLlN0YXRzU2VyaWVzSAJSDWZh'
    'c3Rlc3RGaW5pc2iIAQESTgoUbG9uZ2VzdF9yZWxhdGlvbnNoaXAYNiABKAsyFi5ydW1nYXAudj'
    'EuU3RhdHNTZXJpZXNIA1ITbG9uZ2VzdFJlbGF0aW9uc2hpcIgBARIwCgdmcmllbmRzGDwgAygL'
    'MhYucnVtZ2FwLnYxLlN0YXRzRnJpZW5kUgdmcmllbmRzEi0KBHllYXIYRiABKAsyFC5ydW1nYX'
    'AudjEuU3RhdHNZZWFySARSBHllYXKIAQFCEAoOX2JpZ2dlc3RfYmluZ2VCEAoOX2ZpcnN0X3Jl'
    'YWRfYXRCEQoPX2Zhc3Rlc3RfZmluaXNoQhcKFV9sb25nZXN0X3JlbGF0aW9uc2hpcEIHCgVfeW'
    'Vhcg==');
