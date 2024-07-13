import 'dart:convert';

import 'package:visual_editor/document/services/delta.utils.dart';
import 'package:visual_editor/visual-editor.dart';

extension DeltaUtil on DeltaM {
  static DeltaDocM tryFromJson(String? json) {
    try {
      return DeltaDocM.fromJson(jsonDecode(json ?? ""));
    } catch (e) {
      final du = DeltaUtils();
      final delta = DeltaDocM();
      du.insert(delta.delta, "$json\n");
      return delta;
    }
  }
}
