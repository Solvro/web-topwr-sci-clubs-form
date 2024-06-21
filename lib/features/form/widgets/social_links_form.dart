import 'package:flutter/material.dart';

import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../model/form_model.dart';
import 'form_fields.dart';
import 'form_subsection.dart';

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
        formModel.addSocialLinksItem(const SocialUrl(name: "", url: ""));
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
                      ...model.keys.map(
                        (e) => MyFormField(
                          capitalizeFirst(e),
                          formControlName: "$i.$e",
                        ),
                      )
                    ],
                  ),
                ));
          }).values
        ];
      },
    );
  }
}

String capitalizeFirst(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}
