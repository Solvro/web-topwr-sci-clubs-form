import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parse_query.freezed.dart';
part 'parse_query.g.dart';

extension ParseQuery on RouteSettings {
  String? get rawName {
    try {
      return Uri.parse(name ?? "").path;
    } catch (e) {
      return null;
    }
  }

  QueryParams? get queryParans {
    try {
      return QueryParams.fromJson(Uri.parse(name ?? "").queryParameters);
    } catch (e) {
      return null;
    }
  }
}

@freezed
class QueryParams with _$QueryParams {
  const factory QueryParams({
    required String email,
    required String token,
  }) = _QueryParams;

  factory QueryParams.fromJson(Map<String, Object?> json) =>
      _$QueryParamsFromJson(json);
}
