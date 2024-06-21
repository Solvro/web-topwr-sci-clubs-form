import 'package:flutter/material.dart';

abstract class FormConfig {}

abstract class FormFieldConfig {
  static const padding = EdgeInsets.all(8.0);
  static const radius = Radius.circular(6);
  static const imageMimes = const [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/bmp'
  ];
}
