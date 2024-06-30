import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/context_extensions.dart';
import '../image_dropzone/image_dropzone.dart';
import '../mockup_frame/breakpoint.dart';
import '../mockup_frame/preview_fab.dart';
import '../social_links_subform/social_links_form.dart';
import 'model/form_model.dart';
import 'widgets/fab_send.dart';
import 'widgets/form_fields.dart';
import 'widgets/form_header.dart';
import 'widgets/html_field.dart';
import 'widgets/select_tags.dart';
import 'widgets/type_choice_field.dart';

class SciClubForm extends ConsumerWidget {
  const SciClubForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!context.showSplitView)
            const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: ShowPreviewFAB(),
            ),
          const FabSend(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ReactiveSciClubFormModelFormConsumer(
                builder: (context, formModel, child) => Column(
                  children: [
                    const FormHeader(),
                    MyFormField(
                      context.localize.form_sci_club_name,
                      formControl: formModel.nameControl,
                    ),
                    MyFormField(
                      context.localize.form_sci_club_department,
                      formControl: formModel.departmentControl,
                    ),
                    TypeChoiceField(formModel.typeControl),
                    ImageDropzone(
                      label: context.localize.form_logo,
                      formControl: formModel.logoControl,
                    ),
                    ImageDropzone(
                      label: context.localize.form_cover,
                      formControl: formModel.coverControl,
                    ),
                    SocialLinksForm(formModel: formModel),
                    SelectTags(formModel.tagsControl),
                    MyFormField(
                      context.localize.form_sci_short_desc,
                      formControl: formModel.shortDescriptionControl,
                    ),
                    HtmlField(
                      context.localize.form_sci_desc,
                      formModel.descriptionControl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
