import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../config/config.dart';
import '../../theme/app_theme.dart';

final _quillControler = Provider((ref) => QuillEditorController());

class HtmlField extends ConsumerWidget {
  const HtmlField(this.title, this.formControl, {super.key});

  final String title;
  final FormControl<String>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_quillControler);

    return Padding(
      padding: FormFieldConfig.padding,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorTheme.blackMirage,
          ),
          borderRadius: const BorderRadius.all(FormFieldConfig.radius),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: context.textTheme.lightTitle,
              ),
              tileColor: context.colorTheme.greyLight,
            ),
            ToolBar(
              toolBarColor: context.colorTheme.greyLight,
              activeIconColor: context.colorTheme.orangePomegranade,
              controller: controller,
            ),
            QuillHtmlEditor(
              text: "<h1>Hello</h1>To przykład twojego super opisu koła 😊",
              controller: controller,
              isEnabled: true,
              minHeight: 300,
              textStyle: context.textTheme.body,
              hintTextStyle: context.textTheme.lightTitle,
              hintTextAlign: TextAlign.start,
              padding: FormFieldConfig.padding,
              backgroundColor: context.colorTheme.whiteSoap,
              onFocusChanged: (hasFocus) {
                if (!hasFocus) formControl?.markAsTouched();
              },
              onTextChanged: (text) => formControl?.updateValue(text),
              // onEditingComplete: (s) => formControl.,
              loadingBuilder: (context) {
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 0.4,
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
