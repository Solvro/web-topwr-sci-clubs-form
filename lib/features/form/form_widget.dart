import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../utils/context_extensions.dart';
import 'widgets/form_fields.dart';
import 'model/form_model.dart';

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
            formModel.shortDescriptionControl,
            context.localize.form_sci_short_desc,
          ),
          MyFormField(
            formModel.descriptionControl,
            context.localize.form_sci_short_desc,
          ),
        ]);
      },
    );
  }
}
