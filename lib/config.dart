import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

abstract class FormConfig {}

abstract class FormFieldConfig {
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
