import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import 'text_style.dart';

class MyFormField extends StatelessWidget {
  final FormControl<String>? formControl;
  final String? formControlName;
  final String label;
  const MyFormField(
    this.label, {
    this.formControl,
    this.formControlName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FormFieldConfig.padding,
      child: ReactiveTextField<String>(
        formControl: formControl,
        formControlName: formControlName,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          border: FieldStateBorder(context),
          labelStyle: FieldTextStateStyle(context),
          errorStyle: FieldTextStateStyle(
            context,
          ), // it doesnt fully work without errorStyle specified :/
          filled: true,
          hoverColor: context.colorTheme.blueAzure.withOpacity(0.1),
        ),
      ),
    );
  }
}
