import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';

class FormSubsection<T> extends StatefulWidget {
  const FormSubsection({
    super.key,
    required this.title,
    this.errorMessage,
    required this.buildChildren,
    required this.onInitState,
    this.expandableMode = false,
  });

  final String title;
  final String? errorMessage;

  final List<Widget> Function(void Function(bool isErr) setError) buildChildren;
  final VoidCallback onInitState;

  final bool expandableMode;

  @override
  State<FormSubsection<T>> createState() => _TagsCheckboxListState<T>();
}

class _TagsCheckboxListState<T> extends State<FormSubsection<T>> {
  bool isError = false;
  @override
  void initState() {
    widget.onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FormFieldConfig.padding,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorTheme.blackMirage,
          ),
          borderRadius: const BorderRadius.all(FormFieldConfig.radius),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: context.textTheme.body,
                    ),
                  ),
                  if (isError && widget.errorMessage != null)
                    Text(
                      widget.errorMessage!,
                      style: context.textTheme.titleOrange,
                    ),
                ],
              ),
            ),
            enabled: true,
            initiallyExpanded: true,
            children: widget.buildChildren(
              (isErr) => setState(
                () {
                  isError = isErr;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
