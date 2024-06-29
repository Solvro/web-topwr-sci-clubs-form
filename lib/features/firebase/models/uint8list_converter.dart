import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

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

class IgnoreConverter implements JsonConverter<Uint8List?, String?> {
  const IgnoreConverter();

  @override
  Null fromJson(json) {
    return null;
  }

  @override
  Null toJson(Uint8List? object) {
    return null;
  }
}
