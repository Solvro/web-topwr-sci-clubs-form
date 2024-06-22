import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../config/config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../form/widgets/form_subsection.dart';

final _quillControler = Provider((ref) => HtmlEditorController());

class HtmlField extends ConsumerWidget {
  const HtmlField(this.title, this.formControl, {super.key});

  final String title;
  final FormControl<String>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_quillControler);

    return FormSubsection(
      title: title,
      buildChildren: (setError) => [
        HtmlEditor(
          controller: controller, //required
          htmlEditorOptions: HtmlEditorOptions(
            initialText: formControl?.value,
            hint: "<p>${context.localize.form_sci_desc_hint}</p>",
          ),
          otherOptions: const OtherOptions(height: 400),
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
          callbacks: Callbacks(onChangeContent: (p0) {
            debugPrint(p0);
            formControl?.updateValue(p0);
            formControl?.updateValueAndValidity();
            setError(false);
          }, onInit: () {
            controller.setFullScreen();
          }),
        ),
      ],
      onInitState: () {},
    );

    // return Padding(
    //   padding: FormFieldConfig.padding,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: context.colorTheme.blackMirage,
    //       ),
    //       borderRadius: const BorderRadius.all(FormFieldConfig.radius),
    //     ),
    //     child: Column(
    //       children: [
    //         ListTile(
    //           title: Text(
    //             ,
    //             style: context.textTheme.lightTitle,
    //           ),
    //           tileColor: context.colorTheme.greyLight,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
