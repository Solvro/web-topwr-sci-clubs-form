import 'package:flutter_quill/flutter_quill.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import 'form_subsection.dart';
import 'quill_field.dart';

class WYSIWYGEditor extends StatefulWidget {
  const WYSIWYGEditor(this.title, this.formControl, {super.key});

  final String title;
  final FormControl<String>? formControl;

  @override
  State<WYSIWYGEditor> createState() => _WYSIWYGEditorState();
}

class _WYSIWYGEditorState extends State<WYSIWYGEditor> {
  // final controller = QuillController.basic();

  // StreamSubscription<DocChange>? subscription;

  // @override
  // void initState() {
  //   super.initState();
  //   initValue();
  // }

  // void initValue() {
  //   controller.document = Document.fromHtml(widget.formControl?.value ?? "");
  //   subscription = controller.document.changes.listen(listener);
  // }

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   controller.dispose();
  //   super.dispose();
  // }

  // void listener(_) {
  //   Future.microtask(() {
  //     final html = controller.document.toDelta().toHtml();
  //     widget.formControl?.updateValue(html);
  //     widget.formControl?.updateValueAndValidity();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: FormSubsection(
        onInitState: () {},
        title: widget.title,
        buildChildren: (setError) {
          final quillSharedConfigurations = QuillSharedConfigurations(
            locale: const Locale('pl'),
            dialogTheme: QuillDialogTheme(
              dialogBackgroundColor: context.colorTheme.greyLight,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(FormFieldConfig.radius),
              ),
            ),
          );
          return [
            ReactiveQuillField(
              formControl: widget.formControl,
              context: context,
              sharedConfigurations: quillSharedConfigurations,
            ),
          ];
        },
      ),
    );
  }
}
