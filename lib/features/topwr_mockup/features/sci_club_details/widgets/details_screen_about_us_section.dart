import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visual_editor/visual-editor.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/context_extensions.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.localize.about_us,
                    style: context.textTheme.headline),
                const SizedBox(height: 16),
                VisualEditorReadOnly(json: text),
              ],
            ),
          );
  }
}

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
