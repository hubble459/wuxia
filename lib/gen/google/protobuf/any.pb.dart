// This is a generated file - do not edit.
//
// Generated from google/protobuf/any.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/src/protobuf/mixins/well_known.dart' as $mixin;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// `Any` contains an arbitrary serialized protocol buffer message along with a
/// URL that describes the type of the serialized message.
///
/// In its binary encoding, an `Any` is an ordinary message; but in other wire
/// forms like JSON, it has a special encoding. The format of the type URL is
/// described on the `type_url` field.
///
/// Protobuf APIs provide utilities to interact with `Any` values:
///
/// - A 'pack' operation accepts a message and constructs a generic `Any` wrapper
///   around it.
/// - An 'unpack' operation reads the content of an `Any` message, either into an
///   existing message or a new one. Unpack operations must check the type of the
///   value they unpack against the declared `type_url`.
/// - An 'is' operation decides whether an `Any` contains a message of the given
///   type, i.e. whether it can 'unpack' that type.
///
/// The JSON format representation of an `Any` follows one of these cases:
///
/// - For types without special-cased JSON encodings, the JSON format
///   representation of the `Any` is the same as that of the message, with an
///   additional `@type` field which contains the type URL.
/// - For types with special-cased JSON encodings (typically called 'well-known'
///   types, listed in https://protobuf.dev/programming-guides/json/#any), the
///   JSON format representation has a key `@type` which contains the type URL
///   and a key `value` which contains the JSON-serialized value.
///
/// The text format representation of an `Any` is like a message with one field
/// whose name is the type URL in brackets. For example, an `Any` containing a
/// `foo.Bar` message may be written `[type.googleapis.com/foo.Bar] { a: 2 }`.
class Any extends $pb.GeneratedMessage with $mixin.AnyMixin {
  factory Any({
    $core.String? typeUrl,
    $core.List<$core.int>? value,
  }) {
    final result = create();
    if (typeUrl != null) result.typeUrl = typeUrl;
    if (value != null) result.value = value;
    return result;
  }

  Any._();

  factory Any.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Any.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Any',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create,
      wellKnownType: $mixin.WellKnownType.any)
    ..aOS(1, _omitFieldNames ? '' : 'typeUrl')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Any clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Any copyWith(void Function(Any) updates) =>
      super.copyWith((message) => updates(message as Any)) as Any;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Any create() => Any._();
  @$core.override
  Any createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Any getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Any>(create);
  static Any? _defaultInstance;

  /// Identifies the type of the serialized Protobuf message with a URI reference
  /// consisting of a prefix ending in a slash and the fully-qualified type name.
  ///
  /// Example: type.googleapis.com/google.protobuf.StringValue
  ///
  /// This string must contain at least one `/` character, and the content after
  /// the last `/` must be the fully-qualified name of the type in canonical
  /// form, without a leading dot. Do not write a scheme on these URI references
  /// so that clients do not attempt to contact them.
  ///
  /// The prefix is arbitrary and Protobuf implementations are expected to
  /// simply strip off everything up to and including the last `/` to identify
  /// the type. `type.googleapis.com/` is a common default prefix that some
  /// legacy implementations require. This prefix does not indicate the origin of
  /// the type, and URIs containing it are not expected to respond to any
  /// requests.
  ///
  /// All type URL strings must be legal URI references with the additional
  /// restriction (for the text format) that the content of the reference
  /// must consist only of alphanumeric characters, percent-encoded escapes, and
  /// characters in the following set (not including the outer backticks):
  /// `/-.~_!$&()*+,;=`. Despite our allowing percent encodings, implementations
  /// should not unescape them to prevent confusion with existing parsers. For
  /// example, `type.googleapis.com%2FFoo` should be rejected.
  ///
  /// In the original design of `Any`, the possibility of launching a type
  /// resolution service at these type URLs was considered but Protobuf never
  /// implemented one and considers contacting these URLs to be problematic and
  /// a potential security issue. Do not attempt to contact type URLs.
  @$pb.TagNumber(1)
  $core.String get typeUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set typeUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTypeUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeUrl() => $_clearField(1);

  /// Holds a Protobuf serialization of the type described by type_url.
  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  /// Creates a new [Any] encoding [message].
  ///
  /// The [typeUrl] will be [typeUrlPrefix]/`fullName` where `fullName` is
  /// the fully qualified name of the type of [message].
  static Any pack($pb.GeneratedMessage message,
      {$core.String typeUrlPrefix = 'type.googleapis.com'}) {
    final result = create();
    $mixin.AnyMixin.packIntoAny(result, message, typeUrlPrefix: typeUrlPrefix);
    return result;
  }
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
