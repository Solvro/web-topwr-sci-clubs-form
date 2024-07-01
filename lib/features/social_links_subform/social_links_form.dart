import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:separate/separate.dart';
import 'package:uuid/uuid.dart';

import '../../utils/context_extensions.dart';
import '../form/model/form_model.dart';
import '../form/widgets/form_subsection.dart';
import '../topwr_mockup/widgets/my_text_button.dart';
import 'widget/social_link_section.dart';

class SocialLinksForm extends StatelessWidget {
  const SocialLinksForm({super.key, required this.formModel});

  final SciClubFormModelForm formModel;

  static const uuid = Uuid();

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
                      key: ValueKey(model.model.id),
                      removeCallback: () =>
                          formModel.removeSocialLinksItemAtIndex(index),
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
                        SocialUrl(
                          name: "",
                          url: "",
                          id: uuid.v4(),
                        ),
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
