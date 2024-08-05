import "package:flutter/material.dart";
import "package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/convert_html.dart";
import "../../../../../utils/launch_url_util.dart";

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(24).copyWith(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localize.about_us,
                  style: context.textTheme.headline,
                ),
                const SizedBox(height: 16),
                HtmlWidget(
                  text,
                  customStylesBuilder: context.customStylesBuilder,
                  onTapUrl: LaunchUrlUtil.launch,
                ),
              ],
            ),
          );
  }
}
