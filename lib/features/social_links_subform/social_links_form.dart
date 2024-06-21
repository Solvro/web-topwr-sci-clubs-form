import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../utils/context_extensions.dart';
import '../../utils/where_non_null_iterable.dart';
import '../form/model/form_model.dart';
import '../form/widgets/form_fields.dart';
import '../form/widgets/form_subsection.dart';
import 'widget/link_field.dart';
import 'widget/type_picker.dart';

class SocialLinksForm extends StatelessWidget {
  const SocialLinksForm({super.key, required this.formModel});

  final SciClubFormModelForm formModel;
  @override
  Widget build(BuildContext context) {
    return FormSubsection(
      height: null,
      title: context.localize.form_sci_social_links,
      formControl: formModel.socialLinksControl,
      errorMessage: "",
      onInitState: () {
        formModel.addSocialLinksItem(const SocialUrl());
      },
      buildChildren: (context, formArray, setError) {
        return [
          ...formArray.value.whereNonNull.toList().asMap().map((i, model) {
            return MapEntry(
                i,
                Card(
                  child: Column(
                    key: ValueKey(i.toString()),
                    children: [
                      MyFormField(
                        formControlName: "$i.name",
                        context.localize.url_name_field,
                      ),
                      Padding(
                        padding: FormFieldConfig.padding,
                        child: Row(
                          children: [
                            LinkTypePicker(
                              formControlName: "$i.urlType",
                            ),
                            Expanded(
                              child: LinkField(
                                formControlName: "$i.url",
                                model["url"] as String?,
                                context.localize.url_field,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }).values
        ];
      },
    );
  }
}
