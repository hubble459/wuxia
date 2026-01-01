// This is a generated file - do not edit.
//
// Generated from rumgap/v1/scrape_error.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ScrapeErrorType extends $pb.ProtobufEnum {
  static const ScrapeErrorType Unknown =
      ScrapeErrorType._(0, _omitEnumNames ? '' : 'Unknown');
  static const ScrapeErrorType ReqwestError =
      ScrapeErrorType._(1, _omitEnumNames ? '' : 'ReqwestError');
  static const ScrapeErrorType ReqwestMiddlewareError =
      ScrapeErrorType._(2, _omitEnumNames ? '' : 'ReqwestMiddlewareError');
  static const ScrapeErrorType IoError =
      ScrapeErrorType._(3, _omitEnumNames ? '' : 'IoError');
  static const ScrapeErrorType ConfigError =
      ScrapeErrorType._(4, _omitEnumNames ? '' : 'ConfigError');
  static const ScrapeErrorType ConfigDeserializeError =
      ScrapeErrorType._(5, _omitEnumNames ? '' : 'ConfigDeserializeError');
  static const ScrapeErrorType WebScrapingError =
      ScrapeErrorType._(6, _omitEnumNames ? '' : 'WebScrapingError');
  static const ScrapeErrorType NotAValidURL =
      ScrapeErrorType._(7, _omitEnumNames ? '' : 'NotAValidURL');
  static const ScrapeErrorType SelectorError =
      ScrapeErrorType._(8, _omitEnumNames ? '' : 'SelectorError');
  static const ScrapeErrorType WebsiteNotSupported =
      ScrapeErrorType._(9, _omitEnumNames ? '' : 'WebsiteNotSupported');
  static const ScrapeErrorType SearchNotSupported =
      ScrapeErrorType._(10, _omitEnumNames ? '' : 'SearchNotSupported');
  static const ScrapeErrorType MultipleScrapingErrors =
      ScrapeErrorType._(11, _omitEnumNames ? '' : 'MultipleScrapingErrors');
  static const ScrapeErrorType CloudflareIUAM =
      ScrapeErrorType._(12, _omitEnumNames ? '' : 'CloudflareIUAM');

  static const $core.List<ScrapeErrorType> values = <ScrapeErrorType>[
    Unknown,
    ReqwestError,
    ReqwestMiddlewareError,
    IoError,
    ConfigError,
    ConfigDeserializeError,
    WebScrapingError,
    NotAValidURL,
    SelectorError,
    WebsiteNotSupported,
    SearchNotSupported,
    MultipleScrapingErrors,
    CloudflareIUAM,
  ];

  static final $core.List<ScrapeErrorType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static ScrapeErrorType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ScrapeErrorType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
