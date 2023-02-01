///
//  Generated code. Do not modify.
//  source: meta.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MetaHostNamesOption extends $pb.ProtobufEnum {
  static const MetaHostNamesOption HostNamesReading = MetaHostNamesOption._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostNamesReading');
  static const MetaHostNamesOption HostNamesManga = MetaHostNamesOption._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostNamesManga');
  static const MetaHostNamesOption HostNamesOnline = MetaHostNamesOption._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HostNamesOnline');

  static const $core.List<MetaHostNamesOption> values = <MetaHostNamesOption> [
    HostNamesReading,
    HostNamesManga,
    HostNamesOnline,
  ];

  static final $core.Map<$core.int, MetaHostNamesOption> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MetaHostNamesOption? valueOf($core.int value) => _byValue[value];

  const MetaHostNamesOption._($core.int v, $core.String n) : super(v, n);
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

