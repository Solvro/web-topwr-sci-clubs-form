// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:quill_html_converter/quill_html_converter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/context_extensions.dart';
import 'reactive_mock_field.dart';

/// A [ReactiveQuillField] that contains a [QuillEditor].
///
/// This is a convenience widget that wraps a [QuillEditor] widget in a
/// [ReactiveFormField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveQuillField extends ReactiveFormField<String, String> {
  final QuillController? _controller;

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
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTextField(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveTextField(
  ///   formControlName: 'email',
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
    QuillController? controller,
    required BuildContext context,
    required QuillSharedConfigurations sharedConfigurations,
  })  : _controller = controller,
        super(
          builder: (ReactiveFormFieldState<String, String> field) {
            final state = field as _ReactiveQuillFieldState;
            return Column(
              children: [
                QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                    controller: state._controller,
                    sharedConfigurations: sharedConfigurations,
                    showFontFamily: false,
                    showSearchButton: false,
                    showDividers: false,
                  ),
                ),
                QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: state._controller,
                    sharedConfigurations: sharedConfigurations,
                    minHeight: 400,
                    placeholder: context.localize.form_sci_desc_hint,
                  ),
                  focusNode: field.focusNode,
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
            // return TextField(
            //   controller: state._textController,
            //   focusNode: state.focusNode,
            //   decoration:
            //       effectiveDecoration.copyWith(errorText: state.errorText),
            //   keyboardType: keyboardType,
            //   textInputAction: textInputAction,
            //   style: style,
            //   strutStyle: strutStyle,
            //   textAlign: textAlign,
            //   textAlignVertical: textAlignVertical,
            //   textDirection: textDirection,
            //   textCapitalization: textCapitalization,
            //   autofocus: autofocus,
            //   contextMenuBuilder: contextMenuBuilder,
            //   readOnly: readOnly,
            //   showCursor: showCursor,
            //   obscureText: obscureText,
            //   autocorrect: autocorrect,
            //   smartDashesType: smartDashesType ??
            //       (obscureText
            //           ? SmartDashesType.disabled
            //           : SmartDashesType.enabled),
            //   smartQuotesType: smartQuotesType ??
            //       (obscureText
            //           ? SmartQuotesType.disabled
            //           : SmartQuotesType.enabled),
            //   enableSuggestions: enableSuggestions,
            //   maxLengthEnforcement: maxLengthEnforcement,
            //   maxLines: maxLines,
            //   minLines: minLines,
            //   expands: expands,
            //   maxLength: maxLength,
            //   inputFormatters: inputFormatters,
            //   enabled: field.control.enabled,
            //   cursorWidth: cursorWidth,
            //   cursorHeight: cursorHeight,
            //   cursorRadius: cursorRadius,
            //   cursorColor: cursorColor,
            //   scrollPadding: scrollPadding,
            //   scrollPhysics: scrollPhysics,
            //   keyboardAppearance: keyboardAppearance,
            //   enableInteractiveSelection: enableInteractiveSelection,
            //   buildCounter: buildCounter,
            //   autofillHints: autofillHints,
            //   mouseCursor: mouseCursor,
            //   obscuringCharacter: obscuringCharacter,
            //   dragStartBehavior: dragStartBehavior,
            //   onAppPrivateCommand: onAppPrivateCommand,
            //   restorationId: restorationId,
            //   scrollController: scrollController,
            //   selectionControls: selectionControls,
            //   selectionHeightStyle: selectionHeightStyle,
            //   selectionWidthStyle: selectionWidthStyle,
            //   clipBehavior: clipBehavior,
            //   enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            //   scribbleEnabled: scribbleEnabled,
            //   onTap: onTap != null ? () => onTap(field.control) : null,
            //   onSubmitted: onSubmitted != null
            //       ? (_) => onSubmitted(field.control)
            //       : null,
            //   onEditingComplete: onEditingComplete != null
            //       ? () => onEditingComplete.call(field.control)
            //       : null,
            //   onChanged: (value) {
            //     field.didChange(value);
            //     onChanged?.call(field.control);
            //   },
            //   undoController: undoController,
            //   cursorOpacityAnimates: cursorOpacityAnimates,
            //   onTapOutside: onTapOutside,
            //   contentInsertionConfiguration: contentInsertionConfiguration,
            //   canRequestFocus: canRequestFocus,
            //   spellCheckConfiguration: spellCheckConfiguration,
            //   magnifierConfiguration: magnifierConfiguration,
            // );
          },
        );

  @override
  ReactiveFormFieldState<String, String> createState() =>
      _ReactiveQuillFieldState();
}

class _ReactiveQuillFieldState
    extends ReactiveFocusableFormFieldState<String, String> {
  late QuillController _controller;

  StreamSubscription<DocChange>? subscription;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void onControlValueChanged(dynamic value) {
    _controller.document = Document.fromHtml(value?.toDelta()?.toHtml() ?? "");
    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<String, String> selectValueAccessor() {
    // if (control is FormControl<int>) {
    //   return IntValueAccessor() as ControlValueAccessor<T, String>;
    // } else if (control is FormControl<double>) {
    //   return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    // } else if (control is FormControl<DateTime>) {
    //   return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    // } else if (control is FormControl<TimeOfDay>) {
    //   return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    // }

    return super.selectValueAccessor();
  }

  void _initializeController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveQuillField;
    _controller = (currentWidget._controller != null)
        ? currentWidget._controller!
        : QuillController.basic();
    _controller.document = Document.fromHtml(initialValue ?? '');
    subscription = _controller.changes.listen(listenOnData);
  }

  @override
  void dispose() {
    subscription?.cancel();
    final currentWidget = widget as ReactiveQuillField;
    if (currentWidget._controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void listenOnData(DocChange event) {
    didChange(_controller.document.toDelta().toHtml());
  }
}
