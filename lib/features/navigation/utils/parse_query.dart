// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

import 'hex_converter.dart';

part 'parse_query.freezed.dart';
part 'parse_query.g.dart';

extension ParseQuery on GoRouterState {
  QueryParams? get queryParams {
    try {
      return QueryParams.fromJson(uri.queryParameters);
    } catch (e) {
      return null;
    }
  }
}

@freezed
class QueryParams with _$QueryParams {
  const factory QueryParams({
    @JsonKey(name: '1') @HexConverter() required String email,
    @JsonKey(name: '2') required String token,
  }) = _QueryParams;

  factory QueryParams.fromJson(Map<String, Object?> json) =>
      _$QueryParamsFromJson(json);
}
