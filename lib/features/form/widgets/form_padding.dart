import 'package:flutter/material.dart';

class FormPadding extends StatelessWidget {
  const FormPadding({super.key, required this.child});
  final Widget child;

  EdgeInsets getPadding(double width) {
    if (width > 800) {
      return const EdgeInsets.all(40.0);
    } else if (width > 650) {
      return const EdgeInsets.all(24.0);
    } else if (width > 550) {
      return const EdgeInsets.all(16.0);
    } else if (width > 450) {
      return const EdgeInsets.all(8.0);
    } else {
      return EdgeInsets.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final padding = getPadding(width);
        return Padding(
          padding: padding,
          child: child,
        );
      },
    );
  }
}
