import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visual_editor/visual-editor.dart';

import '../../../../../theme/app_theme.dart';

class VisualEditorReadOnly extends StatelessWidget {
  const VisualEditorReadOnly({
    super.key,
    required this.json,
  });

  final String json;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.body,
      child: VisualEditor(
        controller: EditorController(
          document: DeltaDocM.fromJson(jsonDecode(json)),
        ),
        focusNode: FocusNode(canRequestFocus: false),
        config: EditorConfigM(
          readOnly: true,
          autoFocus: false,
          textSelectionControls: emptyTextSelectionControls,
          markersVisibility: false,
          enableInteractiveSelection: false,
        ),
      ),
    );
  }
}
