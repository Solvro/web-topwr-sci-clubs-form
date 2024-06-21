import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../utils/context_extensions.dart';
import '../image_dropzone/image_dropzone.dart';
import 'model/form_model.dart';
import 'widgets/form_fields.dart';
import 'widgets/type_choice_field.dart';

class SciClubForm extends ConsumerWidget {
  const SciClubForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SciClubFormModelFormBuilder(
      model: ref.watch(sciClubFormModelProvider),
      builder: (context, formModel, child) {
        return ListView(children: [
          MyFormField(
            formModel.nameControl,
            context.localize.form_sci_club_name,
          ),
          MyFormField(
            formModel.departmentControl,
            context.localize.form_sci_club_department,
          ),
          MyFormField(
            formModel.shortDescriptionControl,
            context.localize.form_sci_short_desc,
          ),
          TypeChoiceField(formModel.typeControl),
          MyFormField(
            formModel.descriptionControl,
            context.localize.form_sci_short_desc,
          ),
          ImageDropzone(
            label: context.localize.form_logo,
            formControl: formModel.logoControl,
          ),
          ImageDropzone(
            label: context.localize.form_cover,
            formControl: formModel.coverControl,
          ),
        ]);
      },
    );
  }
}
