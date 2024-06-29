import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../controller/form_widget_controller.dart';
import '../model/form_model.dart';

class FabSend extends ConsumerWidget {
  const FabSend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveSciClubFormModelFormConsumer(
      builder: (context, formModel, child) => PointerInterceptor(
        child: FloatingActionButton.extended(
          onPressed: formModel.form.valid == true
              ? () => ref
                  .watch(formWidgetControllerProvider.notifier)
                  .submit(formModel.model)
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
      ),
    );
  }
}
