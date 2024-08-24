import "package:flutter/material.dart";

import "../../../../../theme/app_theme.dart";

class LineHandle extends StatelessWidget {
  const LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorTheme.blackMirage.withOpacity(0.16),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
