import "package:flutter/material.dart";

class FormPadding extends StatelessWidget {
  const FormPadding({super.key, required this.child});
  final Widget child;

  EdgeInsets getPadding(double width) {
    if (width > 800) {
      return const EdgeInsets.all(40);
    } else if (width > 650) {
      return const EdgeInsets.all(24);
    } else if (width > 550) {
      return const EdgeInsets.all(16);
    } else if (width > 450) {
      return const EdgeInsets.all(8);
    } else {
      return EdgeInsets.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.asBoxConstraints().maxWidth;
        final padding = getPadding(width);
        return SliverPadding(
          padding: padding,
          sliver: child,
        );
      },
    );
  }
}
