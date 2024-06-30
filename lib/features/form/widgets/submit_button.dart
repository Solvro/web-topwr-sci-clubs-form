import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/colors.dart';
import '../../../utils/context_extensions.dart';
import '../controller/form_widget_controller.dart';
import '../model/form_model.dart';
import 'my_outline_button.dart';

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
        child: MyOutlineButton(
          icon: Icons.send_rounded,
          actionTitle: context.localize.submit,
          onClick: formModel.form.valid == true
              ? () => ref
                  .watch(formWidgetControllerProvider.notifier)
                  .submit(formModel.model)
              : formModel.form.markAllAsTouched,
        ),
      ),
    );
  }
}
