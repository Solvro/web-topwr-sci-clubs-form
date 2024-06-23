import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../model/form_model.dart';

class FabSend extends StatelessWidget {
  const FabSend({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveSciClubFormModelFormConsumer(
      builder: (context, formModel, child) => FloatingActionButton.extended(
        onPressed: formModel.form.valid == true
            ? () {}
            : formModel.form.markAllAsTouched,
        label: Text(context.localize.submit),
        icon: const Icon(Icons.send_rounded),
        backgroundColor: context.colorTheme.blueAzure,
        foregroundColor: context.colorTheme.whiteSoap,
        splashColor: context.colorTheme.orangePomegranade,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(FormFieldConfig.radius),
        ),
      ),
    );
  }
}
