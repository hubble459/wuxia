import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';

class JiffyConverter implements JsonConverter<Jiffy, String> {
  const JiffyConverter();

  @override
  Jiffy fromJson(String date) {
    return Jiffy(date);
  }

  @override
  String toJson(Jiffy date) {
    return date.format();
  }
}

class OptionalJiffyConverter implements JsonConverter<Jiffy?, String?> {
  const OptionalJiffyConverter();

  @override
  Jiffy? fromJson(String? date) {
    return date != null ? Jiffy(date) : null;
  }

  @override
  String? toJson(Jiffy? date) {
    return date?.format();
  }
}

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(int i) {
    return i == 1;
  }

  @override
  int toJson(bool b) {
    return b ? 1 : 0;
  }
}

class UriConverter implements JsonConverter<Uri, String> {
  const UriConverter();

  @override
  Uri fromJson(String url) {
    return Uri.parse(url);
  }

  @override
  String toJson(Uri uri) {
    return uri.toString();
  }
}

class OptionalUriConverter implements JsonConverter<Uri?, String?> {
  const OptionalUriConverter();

  @override
  Uri? fromJson(String? url) {
    return url != null ? Uri.parse(url) : null;
  }

  @override
  String? toJson(Uri? uri) {
    return uri?.toString();
  }
}
