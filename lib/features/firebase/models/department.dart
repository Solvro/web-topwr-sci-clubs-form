import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../theme/hex_color.dart";
import "../../../utils/colors_sort.dart";
import "../../topwr_mockup/config/ui_config.dart";

part "department.freezed.dart";
part "department.g.dart";

@freezed
class Department with _$Department {
  const factory Department({
    required String name,
    required String code,
    String? betterCode,
    String? gradientStart,
    String? gradientEnd,
  }) = _Department;

  const Department._();

  factory Department.fromJson(Map<String, Object?> json) =>
      _$DepartmentFromJson(json);

  LinearGradient get gradient => LinearGradient(
        colors: [
          HexColor(
            gradientStart ?? DepartmentsConfig.defaultColorFirst,
          ),
          HexColor(
            gradientEnd ?? DepartmentsConfig.defaultColorSecond,
          ),
        ]..sortByLightness(),
      );
}

extension GetDepartmentsCodeX on Department? {
  static const _fallbackCode = 0;

  int extractIntFromStrCode() {
    if (this != null && this!.code.length >= 2) {
      return int.tryParse(this!.code.substring(1)) ?? _fallbackCode;
    }
    return _fallbackCode;
  }
}
