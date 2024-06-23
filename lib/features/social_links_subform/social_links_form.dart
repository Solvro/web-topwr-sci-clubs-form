import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:separate/separate.dart';

import '../../utils/context_extensions.dart';
import '../form/model/form_model.dart';
import '../form/widgets/form_subsection.dart';
import '../topwr_mockup/widgets/my_text_button.dart';
import 'widget/social_link_section.dart';

class SocialLinksForm extends StatelessWidget {
  const SocialLinksForm({super.key, required this.formModel});

  final SciClubFormModelForm formModel;
  @override
  Widget build(BuildContext context) {
    return ReactiveFormArray(
        formArray: formModel.socialLinksControl,
        builder: (context, formArray, child) {
          return FormSubsection(
            title: context.localize.form_sci_social_links,
            onInitState: () {},
            buildChildren: (setError) {
              return [
                Container(), // needed for adequate separator behaviour
                ...formModel.socialLinksSocialUrlForm.mapIndexed(
                  (index, model) {
                    return SocialLinkSection(
                      key: ValueKey(index),
                      model,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MyTextButton(
                    actionTitle: context.localize.add_social_link_btn,
                    onClick: () {
                      formModel.addSocialLinksItem(
                        const SocialUrl(name: "", url: ""),
                      );
                    },
                  ),
                ),
              ].separate(
                (i, e0, e1) => const Divider(height: 1),
              );
            },
          );
        });
  }
}
