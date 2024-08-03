import "package:flutter/material.dart";
import "package:super_drag_and_drop/super_drag_and_drop.dart";

abstract class FormConfig {
  static const mailto = "mailto:";
}

abstract class FormFieldConfig {
  static const bigSectionDefHeight = 200.0;
  static const padding = EdgeInsets.all(8);
  static const radius = Radius.circular(6);
  static const dragAndDropFormats = [
    Formats.jpeg,
    Formats.png,
    Formats.bmp,
  ];
  static const filePickerFormats = ["jpg", "png", "bmp"];
  static const dragAndDropError = "drag and drop error";
}

abstract class WebAppBarConfig {
  static const createdBySvg = "assets/created_by_vert.svg";
}

abstract class UndrawConfig {
  static const wrong = "assets/undraw/injured.svg";
  static const p404 = "assets/undraw/camping.svg";
  static const sent = "assets/undraw/sent.svg";
}

abstract class GuestPageConfig {
  static const landing = "assets/undraw/landing.svg";
  static const landingPng = "assets/preview.png";
  static const portfolioLink = "https://solvro.pwr.edu.pl/portfolio/to-pwr";
  static const contactLink = "https://solvro.pwr.edu.pl/contact";
  static const solvroMailLink = "mailto:kn.solvro@pwr.edu.pl";
}
