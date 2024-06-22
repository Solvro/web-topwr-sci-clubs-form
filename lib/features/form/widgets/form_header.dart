import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ankieta kół/organizacji do aplikacji mobilnej ToPWR",
          style: context.textTheme.headline.copyWith(fontSize: 40),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: FormFieldConfig.padding,
          child: Text(
            "Zapraszamy do wypełnienia danych o swoim kole naukowym, organizacji studenckiej, mediach lub agendzie. Wprowadzane dane można na bieżąco obserwować w podglądzie aplikacji. Można spojrzeć jak wprowadzone przez nas dane będą prezentować się na kafelku na ekranie domowym, na liście kół/organizacji oraz w widoku szczegółowym. ",
            style: context.textTheme.title,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
