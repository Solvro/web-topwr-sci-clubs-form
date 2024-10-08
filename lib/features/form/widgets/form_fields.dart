import "package:flutter/material.dart";
import "package:reactive_forms_annotations/reactive_forms_annotations.dart";

import "../../../config/config.dart";
import "../../../theme/app_theme.dart";
import "../../form/widgets/text_style.dart";

class MyFormField extends StatelessWidget {
  final FormControl<String>? formControl;
  final String? formControlName;
  final String label;
  final InputDecorationTheme? fallbackTheme;
  const MyFormField(
    this.label, {
    this.formControl,
    this.formControlName,
    this.fallbackTheme,
    super.key,
    this.prefixIcon,
    this.padding = FormFieldConfig.padding,
    this.hintText,
    this.minLines,
    this.maxLines,
    this.counterText,
    this.suffixIcon,
  });

  final Widget? prefixIcon;
  final EdgeInsets padding;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final String? counterText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ReactiveTextField<String>(
        formControl: formControl,
        formControlName: formControlName,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          border: FieldStateBorder(context),
          labelStyle: FieldTextStateStyle(context),
          errorStyle: FieldTextStateStyle(context),
          filled: true,
          hoverColor: context.colorTheme.blueAzure.withOpacity(0.1),
          prefixIcon: prefixIcon,
          // hintText: hintText, //TODO(simon-the-shark): reverse this when they fix the hint bug
          counter: counterText == null
              ? null
              : Row(
                  children: [
                    Text(
                      counterText!,
                      style: context.textTheme.bodyGrey,
                    ),
                  ],
                ),
        ).applyDefaults(
          fallbackTheme ?? const InputDecorationTheme(),
        ),
        minLines: minLines,
        maxLines: maxLines,
      ),
    );
  }
}
