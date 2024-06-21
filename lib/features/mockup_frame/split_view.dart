import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class FormSplitView extends StatelessWidget {
  const FormSplitView({super.key, required this.form, required this.phone});

  final Widget form;
  final Widget phone;

  @override
  Widget build(BuildContext context) {
    return SplitView(
      viewMode: SplitViewMode.Horizontal,
      indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
      activeIndicator: const SplitIndicator(
        viewMode: SplitViewMode.Horizontal,
        isActive: true,
      ),
      controller: SplitViewController(
          weights: [null, 0.3],
          limits: [null, WeightLimit(max: 0.5, min: 0.1)]),
      children: [
        form,
        phone,
      ],
    );
  }
}
