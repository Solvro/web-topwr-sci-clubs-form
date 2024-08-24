import "package:collection/collection.dart";
import "package:enum_map/enum_map.dart";
import "package:json_annotation/json_annotation.dart";

part "enums.g.dart";

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
@unmodifiableEnumMap
enum SciClubType {
  scientificCirlce,
  culturalAgenda,
  studentOrganization,
  studentMedia;

  static SciClubType? fromJsonVal(String? str) => _$SciClubTypeEnumMap.entries
      .firstWhereOrNull(
        (element) => element.value == str,
      )
      ?.key;
  String? toJsonVal() => _$SciClubTypeEnumMap[this];
}

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum Source {
  manualEntry,
  aktywniWebsite,
  studentDepartment;

  static Source? fromJsonVal(String? str) => _$SourceEnumMap.entries
      .firstWhereOrNull(
        (element) => element.value == str,
      )
      ?.key;
}
