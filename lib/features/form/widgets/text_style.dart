import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/typography.dart';

class FieldStateBorder extends OutlineInputBorder
    implements WidgetStateProperty<OutlineInputBorder> {
  final BuildContext context;
  const FieldStateBorder(this.context);

  @override
  OutlineInputBorder resolve(Set<WidgetState> states) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(FormFieldConfig.radius),
      borderSide: BorderSide(
        color: FieldStateColor(
          context,
        ).resolve(
          states,
        ),
      ),
    );
  }
}

class FieldTextStateStyle extends WidgetStateTextStyle {
  final BuildContext context;
  const FieldTextStateStyle(this.context);

  @override
  TextStyle resolve(Set<WidgetState> states) {
    return BoldBodyTextStyle(
      color: FieldStateColor(context).resolve(states),
    );
  }
}

class FieldStateColor extends WidgetStateColor {
  final BuildContext context;
  FieldStateColor(this.context) : super(context.colorTheme.blackMirage.value);

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.isError) return context.colorTheme.orangePomegranade;
    if (states.isFocused || states.isHovered) {
      return context.colorTheme.blueAzure;
    }
    return context.colorTheme.blackMirage;
  }
}

extension IsWidgetStateExt on Set<WidgetState> {
  bool get isError => contains(WidgetState.error);
  bool get isFocused => contains(WidgetState.focused);
  bool get isHovered => contains(WidgetState.hovered);
}
