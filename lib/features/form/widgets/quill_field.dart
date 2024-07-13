import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:visual_editor/document/models/delta/delta-changes.model.dart';
import 'package:visual_editor/document/services/delta.utils.dart';
import 'package:visual_editor/visual-editor.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/delta_utils.dart';
import 'reactive_mock_field.dart';

/// A [ReactiveQuillField] that contains a [QuillEditor].
///
/// This is a convenience widget that wraps a [QuillEditor] widget in a
/// [ReactiveFormField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveQuillField extends ReactiveFormField<String, String> {
  final EditorController? _controller;

  /// Creates a [ReactiveQuillField] that contains a [QuillEditor].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'html': Validators.required});
  ///
  /// ReactiveQuillField(
  ///   formControlName: 'html',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'hmtl': Validators.required});
  ///
  /// ReactiveQuillField(
  ///   formControl: form.control('html'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveQuillField(
  ///   formControlName: 'hmtml',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The my field must must must not be empty',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveQuillField(
  ///   formControlName: 'html',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [QuillEditor], [QuillToolbar] class
  /// and [QuillEditor], [QuillToolbar] the constructor.
  ReactiveQuillField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    EditorController? controller,
    required BuildContext context,
  })  : _controller = controller,
        super(
          builder: (ReactiveFormFieldState<String, String> field) {
            final state = field as _ReactiveQuillFieldState;
            return Column(
              children: [
                EditorToolbar.basic(
                  controller: state._controller,
                  dialogTheme: EditorDialogThemeM(
                    dialogBackgroundColor: context.colorTheme.greyLight,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(FormFieldConfig.radius),
                    ),
                  ),
                  showFontSize: false,
                  showDividers: false,
                ),
                DefaultTextStyle(
                  style: context.textTheme.body,
                  child: VisualEditor(
                    controller: state._controller,
                    focusNode: state.focusNode,
                    config: EditorConfigM(
                      minHeight:
                          min(MediaQuery.sizeOf(context).height * 0.5, 300),
                      scrollable: false,
                      placeholder: context.localize.form_sci_desc_hint,
                      padding: const EdgeInsets.all(8),
                      autoFocus: false,
                      customStyles: EditorStylesM(
                        bold: const TextStyle(fontWeight: FontWeight.w900),
                        link: TextStyle(
                          color: context.colorTheme.orangePomegranade,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      linkMenuDisabled: true,
                    ),
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
            );
          },
        );

  @override
  ReactiveFormFieldState<String, String> createState() =>
      _ReactiveQuillFieldState();
}

class _ReactiveQuillFieldState
    extends ReactiveFocusableFormFieldState<String, String> {
  late EditorController _controller;

  StreamSubscription<DocAndChangeM>? _subscription;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void onControlValueChanged(dynamic value) {
    _controller.document.delta = DeltaUtil.tryFromJson(value).delta;
    super.onControlValueChanged(value);
  }

  void _initializeController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveQuillField;
    _controller = (currentWidget._controller != null)
        ? currentWidget._controller!
        : EditorController(document: DeltaUtil.tryFromJson(initialValue));
    Future.microtask(() {
      _subscription = _controller.changes$.listen(listenOnData);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    final currentWidget = widget as ReactiveQuillField;
    if (currentWidget._controller == null) {
      _controller.close();
    }
    super.dispose();
  }

  void listenOnData(DocAndChangeM event) {
    didChange(jsonEncode(
      _controller.document.delta.toJson(),
    ));
  }
}
