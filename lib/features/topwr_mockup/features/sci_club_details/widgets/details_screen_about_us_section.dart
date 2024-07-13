import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html2md/html2md.dart';
import 'package:visual_editor/main.dart';
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
                IgnorePointer(
                  child: VisualEditor(
                    controller: EditorController(
                      document: DeltaDocM.fromJson(jsonDecode(text)),
                    ),
                    focusNode: FocusNode()..canRequestFocus = false,
                    config: EditorConfigM(
                      readOnly: true,
                      autoFocus: false,
                      textSelectionControls: emptyTextSelectionControls,
                      markersVisibility: false,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
