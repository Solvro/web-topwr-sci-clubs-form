import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    return json == null ? null : Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}

class IgnoreConverter implements JsonConverter<Uint8List?, Null> {
  const IgnoreConverter();

  @override
  Null fromJson(Null json) {
    return null;
  }

  @override
  Null toJson(Uint8List? object) {
    return null;
  }
}
