import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
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
          colorScheme: ColorScheme.fromSeed(
            seedColor: context.colorTheme.blueAzure,
          ),
        ),
        child: FloatingActionButton.extended(
          onPressed: formModel.form.valid == true
              ? () {}
              : formModel.form.markAllAsTouched,
          label: Text(context.localize.submit),
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
