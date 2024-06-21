import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../theme/app_theme.dart';
import '../../form/model/enums.dart';
import '../../form/widgets/text_style.dart';

class LinkTypePicker extends StatelessWidget {
  const LinkTypePicker({super.key, this.formControl, this.formControlName});
  final FormControl<UrlType>? formControl;
  final String? formControlName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      child: ReactiveDropdownField<UrlType>(
          formControl: formControl,
          formControlName: formControlName,
          items: UrlType.values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.val),
                ),
              )
              .toList(),
          decoration: InputDecoration(
            border: FieldStateBorder(context),
            labelStyle: FieldTextStateStyle(context),
            errorStyle: FieldTextStateStyle(
              context,
            ), // it doesnt fully work without errorStyle specified :/
            filled: true,
            hoverColor: context.colorTheme.blueAzure.withOpacity(0.1),
          )),
    );
  }
}
