import "dart:convert";
import "dart:typed_data";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:json_annotation/json_annotation.dart";

import "../../current_sci_club/models/url.dart";

class Base64Converter implements JsonConverter<Uint8List?, String?> {
  const Base64Converter();

  @override
  Uint8List? fromJson(String? json) {
    return json == null ? null : base64Decode(json);
  }

  @override
  String? toJson(Uint8List? object) {
    return object == null ? null : base64Encode(object);
  }
}

class IgnoreConverter implements JsonConverter<AbstractUrl?, String?> {
  const IgnoreConverter();

  @override
  Null fromJson(String? json) {
    return null;
  }

  @override
  Null toJson(AbstractUrl? object) {
    return null;
  }
}

class UrlConverter implements JsonConverter<AbstractUrl?, String?> {
  const UrlConverter();

  @override
  AbstractUrl? fromJson(String? json) {
    return json == null ? null : NormalUrl(json);
  }

  @override
  String? toJson(AbstractUrl? object) {
    return object?.url;
  }
}
