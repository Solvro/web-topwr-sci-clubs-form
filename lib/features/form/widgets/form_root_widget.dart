import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../utils/context_extensions.dart';
import '../model/form_model.dart';

class FormRootWidget extends ConsumerWidget {
  const FormRootWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormConfig(
      validationMessages: {
        ValidationMessage.required: (error) => context.localize.form_err_req,
        ValidationMessage.email: (error) => context.localize.form_err_email,
        ValidationMessage.pattern: (error) =>
            context.localize.form_err_https_pattrn,
      },
      child: SciClubFormModelFormBuilder(
        model: ref.watch(sciClubFormModelProvider),
        builder: (context, formModel, child) {
          return child ?? Container();
        },
        child: child,
      ),
    );
  }
}
