import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../utils/determine_icon.dart';
import '../../form/widgets/form_fields.dart';

class LinkField extends MyFormField {
  LinkField(
    String? url,
    super.label, {
    super.key,
    super.formControl,
    super.formControlName,
    Widget? prefix,
  }) : super(
          prefixIcon: Image.asset(url.determineIcon()),
          padding: EdgeInsets.zero,
        );
}
