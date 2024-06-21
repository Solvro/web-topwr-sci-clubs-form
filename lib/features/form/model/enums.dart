import 'package:enum_map/enum_map.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
@unmodifiableEnumMap
enum SciClubType {
  scientificCircle,
  culturalAgenda,
  studentOrganization,
  studentMedia,
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Source {
  manualEntry,
  aktywniWebsite,
  studentDepartment,
}
