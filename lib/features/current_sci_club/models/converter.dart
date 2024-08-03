import "package:freezed_annotation/freezed_annotation.dart";

import "url.dart";

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
