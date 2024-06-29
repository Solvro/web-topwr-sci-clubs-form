import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../utils/context_extensions.dart';
import 'form_subsection.dart';
import 'reactive_mock_field.dart';

final _htmlContoller = Provider((ref) => HtmlEditorController());

class HtmlField extends ConsumerWidget {
  const HtmlField(this.title, this.formControl, {super.key});

  final String title;
  final FormControl<String>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_htmlContoller);

    return FormSubsection(
      title: title,
      buildChildren: (setError) => [
        HtmlEditor(
          controller: controller,
          htmlEditorOptions: HtmlEditorOptions(
            initialText: formControl?.value,
            hint: "<p>${context.localize.form_sci_desc_hint}</p>",
          ),
          otherOptions: const OtherOptions(
            height: 400,
          ),
          htmlToolbarOptions: const HtmlToolbarOptions(
            defaultToolbarButtons: [
              StyleButtons(),
              FontButtons(clearAll: false),
              ColorButtons(),
              ListButtons(listStyles: false),
              ParagraphButtons(
                textDirection: false,
                lineHeight: false,
                caseConverter: false,
              ),
              InsertButtons(
                video: false,
                audio: false,
                table: false,
                hr: false,
                otherFile: false,
              ),
            ],
          ),
          callbacks: Callbacks(
            onChangeContent: (p0) {
              formControl?.updateValue(p0);
              formControl?.updateValueAndValidity();
              setError(false);
            },
            onInit: () {
              controller.setFullScreen();
            },
          ),
        ),
        IgnorePointer(
          child: ReactiveMockField(
            style: const TextStyle(
              color: Colors.transparent,
              fontSize: 0,
            ),
            formControl: formControl,
            decoration: const InputDecoration.collapsed(
              hintText: "",
              enabled: false,
            ),
          ),
        ),
      ],
      onInitState: () {},
    );
  }
}
