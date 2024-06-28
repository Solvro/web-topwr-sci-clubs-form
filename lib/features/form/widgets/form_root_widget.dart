import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../utils/context_extensions.dart';
import '../controller/form_widget_controller.dart';
import '../controller/form_widgets_states.dart';
import '../model/form_model.dart';

class FormRootWidget extends ConsumerWidget {
  const FormRootWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formWidgetControllerProvider);

    return switch (state.state) {
      FormViewState.loading => const Center(child: CircularProgressIndicator()),
      FormViewState.saved => const Text("Nicely done"),
      FormViewState.form => ReactiveFormConfig(
          validationMessages: {
            ValidationMessage.required: (error) =>
                context.localize.form_err_req,
            ValidationMessage.email: (error) => context.localize.form_err_email,
            ValidationMessage.pattern: (error) =>
                context.localize.form_err_https_pattrn,
          },
          child: SciClubFormModelFormBuilder(
            model: state.data,
            builder: (context, formModel, child) {
              return child ?? Container();
            },
            child: child,
          ),
        ),
    };
  }
}
