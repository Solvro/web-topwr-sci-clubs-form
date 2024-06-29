import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

abstract class FormConfig {
  static const mailto = "mailto:";
}

abstract class FormFieldConfig {
  static const bigSectionDefHeight = 200.0;
  static const padding = EdgeInsets.all(8.0);
  static const radius = Radius.circular(6);
  static const dragAndDropFormats = [
    Formats.jpeg,
    Formats.png,
    Formats.bmp,
  ];
  static const filePickerFormats = ['jpg', 'png', 'bmp'];
  static const dragAndDropError = "drag and drop error";
}

abstract class WebAppBarConfig {
  static const created_by_svg = "assets/created_by_vert.svg";
}
