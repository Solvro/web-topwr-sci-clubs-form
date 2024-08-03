import "package:flutter/material.dart";
import "package:reactive_forms_annotations/reactive_forms_annotations.dart";
import "package:reactive_segmented_control/reactive_segmented_control.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../model/enums.dart";

class TypeChoiceField extends StatelessWidget {
  const TypeChoiceField(
    this.formControl, {
    super.key,
  });
  final FormControl<SciClubType>? formControl;
  @override
  Widget build(BuildContext context) {
    final choices = UnmodifiableSciClubTypeMap(
      scientificCircle: _ChoiceText(context.localize.sci_circle_type),
      studentOrganization: _ChoiceText(context.localize.stud_org_type),
      studentMedia: _ChoiceText(context.localize.stud_media_type),
      culturalAgenda: _ChoiceText(context.localize.cultural_agenda_type),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ReactiveSegmentedControl<SciClubType, SciClubType>(
        formControl: formControl,
        decoration: InputDecoration(
          labelText: context.localize.form_sci_type,
          labelStyle: context.textTheme.title,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        padding: EdgeInsets.zero,
        children: choices,
      ),
    );
  }
}

class _ChoiceText extends StatelessWidget {
  const _ChoiceText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: context.textTheme.title.copyWith(
          color: DefaultTextStyle.of(context).style.color,
        ),
      ),
    );
  }
}
