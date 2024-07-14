import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:parchment/codecs.dart';

extension DeltaUtil on ParchmentDocument {
  static const codec = ParchmentHtmlCodec();

  static ParchmentDocument tryFromJson(String? json) {
    try {
      return ParchmentDocument.fromJson(jsonDecode(json ?? ""));
    } catch (e) {
      return ParchmentDocument();
    }
  }

  static ParchmentDocument tryFromHtml(String? html) {
    try {
      return codec.decode(html!);
    } catch (e) {
      return ParchmentDocument();
    }
  }
}
