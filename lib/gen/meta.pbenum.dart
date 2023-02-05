///
//  Generated code. Do not modify.
//  source: meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MetaHostnamesOption extends $pb.ProtobufEnum {
  static const MetaHostnamesOption HostnamesReading = MetaHostnamesOption._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostnamesReading');
  static const MetaHostnamesOption HostnamesManga = MetaHostnamesOption._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostnamesManga');
  static const MetaHostnamesOption HostnamesOnline = MetaHostnamesOption._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostnamesOnline');

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
  static const MetaGenresOption GenresReading = MetaGenresOption._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GenresReading');
  static const MetaGenresOption GenresManga = MetaGenresOption._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GenresManga');

  static const $core.List<MetaGenresOption> values = <MetaGenresOption> [
    GenresReading,
    GenresManga,
  ];

  static final $core.Map<$core.int, MetaGenresOption> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MetaGenresOption? valueOf($core.int value) => _byValue[value];

  const MetaGenresOption._($core.int v, $core.String n) : super(v, n);
}

