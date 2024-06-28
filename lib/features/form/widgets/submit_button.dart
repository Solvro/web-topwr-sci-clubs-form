import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../theme/colors.dart';
import '../../../utils/context_extensions.dart';
import '../controller/form_widget_controller.dart';
import '../model/form_model.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveSciClubFormModelFormConsumer(
      builder: (context, formModel, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: ColorsConsts.orangePomegranade,
          ),
        ),
        child: OutlinedButton.icon(
          onPressed: formModel.form.valid == true
              ? () => ref
                  .watch(formWidgetControllerProvider.notifier)
                  .submit(formModel.model)
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
