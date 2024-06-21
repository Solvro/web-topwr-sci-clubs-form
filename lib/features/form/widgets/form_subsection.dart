import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';

class FormSubsection<T> extends StatefulWidget {
  const FormSubsection({
    super.key,
    required this.title,
    required this.errorMessage,
    required this.buildChildren,
    required this.onInitState,
    required this.formControl,
    this.height = FormFieldConfig.bigSectionDefHeight * 1.5,
  });

  final String title;
  final String errorMessage;
  final FormArray<T>? formControl;
  final List<Widget> Function(BuildContext context, FormArray<T> formArray,
      void Function(bool isErr) setError) buildChildren;
  final VoidCallback onInitState;
  final double? height;

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
        height: widget.height,
        child: ReactiveFormArray(
          formArray: widget.formControl,
          builder: (context, formArray, child) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.title,
                      style: context.textTheme.headline,
                    ),
                  ),
                ),
                if (isError)
                  Text(
                    widget.errorMessage,
                    style: context.textTheme.titleOrange,
                  ),
                _ListView(
                  shouldExpand: widget.height != null,
                  children: widget.buildChildren(
                    context,
                    formArray,
                    (isErr) => setState(
                      () {
                        isError = isErr;
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({
    required this.children,
    required this.shouldExpand,
  });
  final List<Widget> children;
  final bool shouldExpand;
  @override
  Widget build(BuildContext context) {
    if (!shouldExpand) {
      return Column(
        children: children,
      );
    }
    return Expanded(
      child: ListView(children: children),
    );
  }
}
