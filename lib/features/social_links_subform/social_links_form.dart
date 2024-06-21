import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../utils/context_extensions.dart';
import '../form/model/form_model.dart';
import '../form/widgets/form_subsection.dart';
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
            height: null,
            title: context.localize.form_sci_social_links,
            formControl: formModel.socialLinksControl,
            onInitState: () {
              formModel.addSocialLinksItem(const SocialUrl());
            },
            buildChildren: (setError) {
              return [
                ...formModel.socialLinksSocialUrlForm.map((model) {
                  return SocialLinkSection(model);
                })
              ];
            },
          );
        });
  }
}
