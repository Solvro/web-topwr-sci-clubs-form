import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../utils/context_extensions.dart';
import '../model/form_model.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveSciClubFormModelFormConsumer(
      builder: (context, formModel, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: ColorsConsts.orangePomegranade,
          ),
        ),
        child: OutlinedButton.icon(
          onPressed: formModel.form.valid == true
              ? () {}
              : formModel.form.markAllAsTouched,
          label: Text(context.localize.submit),
          icon: const Icon(Icons.send_rounded),
          style: const ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(FormFieldConfig.radius)),
            ),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
          ),
        ),
      ),
    );
  }
}
