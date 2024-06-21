import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../utils/context_extensions.dart';
import '../form/model/form_model.dart';
import '../form/widgets/form_fields.dart';
import '../form/widgets/form_subsection.dart';
import 'widget/link_field.dart';

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
                  return _SocialLinkSection(model);
                })
              ];
            },
          );
        });
  }
}

class _SocialLinkSection extends StatefulWidget {
  const _SocialLinkSection(this.model);
  final SocialUrlForm model;

  @override
  State<_SocialLinkSection> createState() => _SocialLinkSectionState();
}

class _SocialLinkSectionState extends State<_SocialLinkSection> {
  StreamSubscription? subs;
  @override
  void initState() {
    subs = widget.model.urlControl?.valueChanges
        .listen((event) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    subs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          LinkField(
            formControl: widget.model.urlControl,
            widget.model.model,
            context.localize.url_field,
          ),
          if (!widget.model.model.isUrlEmail)
            MyFormField(
              formControl: widget.model.nameControl,
              context.localize.url_name_field,
            ),
        ],
      ),
    );
  }
}
