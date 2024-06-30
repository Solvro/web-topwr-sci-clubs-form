import 'package:flutter/material.dart';

extension SplitViewBreakpoint on BuildContext {
  bool get showSplitView {
    return MediaQuery.sizeOf(this).width >= 650;
  }
}
