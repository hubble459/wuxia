//
//  Generated code. Do not modify.
//  source: rumgap/v1/meta.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MetaHostnamesOption extends $pb.ProtobufEnum {
  static const MetaHostnamesOption HostnamesReading = MetaHostnamesOption._(0, _omitEnumNames ? '' : 'HostnamesReading');
  static const MetaHostnamesOption HostnamesManga = MetaHostnamesOption._(1, _omitEnumNames ? '' : 'HostnamesManga');
  static const MetaHostnamesOption HostnamesOnline = MetaHostnamesOption._(2, _omitEnumNames ? '' : 'HostnamesOnline');

  static const $core.List<MetaHostnamesOption> values = <MetaHostnamesOption> [
    HostnamesReading,
    HostnamesManga,
    HostnamesOnline,
  ];

  static final $core.Map<$core.int, MetaHostnamesOption> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MetaHostnamesOption? valueOf($core.int value) => _byValue[value];

  const MetaHostnamesOption._($core.int v, $core.String n) : super(v, n);
}

class MetaGenresOption extends $pb.ProtobufEnum {
  static const MetaGenresOption GenresReading = MetaGenresOption._(0, _omitEnumNames ? '' : 'GenresReading');
  static const MetaGenresOption GenresManga = MetaGenresOption._(1, _omitEnumNames ? '' : 'GenresManga');

  static const $core.List<MetaGenresOption> values = <MetaGenresOption> [
    GenresReading,
    GenresManga,
  ];

  static final $core.Map<$core.int, MetaGenresOption> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MetaGenresOption? valueOf($core.int value) => _byValue[value];

  const MetaGenresOption._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
