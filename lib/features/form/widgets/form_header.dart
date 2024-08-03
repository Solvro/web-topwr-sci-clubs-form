import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../../config/config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

class FormHeader extends StatelessWidget {
  const FormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FormFieldConfig.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.form_title,
            style: context.textTheme.headline.copyWith(fontSize: 40),
            textAlign: TextAlign.start,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: _Desc(),
          ),
        ],
      ),
    );
  }
}

class _Desc extends StatelessWidget {
  const _Desc();

  @override
  Widget build(BuildContext context) {
    final descriptions = <String>[
      // context.localize.form_desc1,
      context.localize.form_desc2,
      context.localize.form_desc3,
      context.localize.form_desc4,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...descriptions.mapIndexed(
          (i, e) => Text(
            e,
            style: context.textTheme.title,
            textAlign: TextAlign.justify,
          ),
        ),
      ].separate(
        (i, e0, e1) => const SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
