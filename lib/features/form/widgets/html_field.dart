import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import 'form_subsection.dart';
import 'quill_field.dart';

class WYSIWYGEditor extends StatelessWidget {
  const WYSIWYGEditor(this.title, this.formControl, {super.key});

  final String title;
  final FormControl<String>? formControl;

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FormSubsection(
        onInitState: () {},
        expandableMode: false,
        title: title,
        buildChildren: (setError) {
          return [
            ReactiveQuillField(
              formControl: formControl,
              context: context,
            ),
          ];
        },
      ),
    );
  }
}
