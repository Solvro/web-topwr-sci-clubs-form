import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../utils/context_extensions.dart';
import 'visual_editor_read_only.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key, required this.id, required this.text});

  final String text;
  final String id;
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
                VisualEditorReadOnly(id, json: text),
              ],
            ),
          );
  }
}
