// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveMockField<T> extends ReactiveFormField<T, Null> {
  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  ReactiveMockField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    InputDecoration decoration = const InputDecoration(),
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        _defaultContextMenuBuilder,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    TextEditingController? controller,
    Clip clipBehavior = Clip.hardEdge,
    bool enableIMEPersonalizedLearning = true,
    bool scribbleEnabled = true,
    ReactiveFormFieldCallback<T>? onTap,
    ReactiveFormFieldCallback<T>? onEditingComplete,
    ReactiveFormFieldCallback<T>? onSubmitted,
    ReactiveFormFieldCallback<T>? onChanged,
    UndoHistoryController? undoController,
    bool? cursorOpacityAnimates,
    TapRegionCallback? onTapOutside,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    bool canRequestFocus = true,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
  }) : super(
          builder: (ReactiveFormFieldState<T, Null> field) {
            final state = field as _ReactiveTextFieldState<T>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            return TextField(
              focusNode: state.focusNode,
              decoration:
                  effectiveDecoration.copyWith(errorText: state.errorText),
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              contextMenuBuilder: contextMenuBuilder,
              readOnly: true,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              enabled: field.control.enabled,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
              autofillHints: autofillHints,
              mouseCursor: mouseCursor,
              obscuringCharacter: obscuringCharacter,
              dragStartBehavior: dragStartBehavior,
              onAppPrivateCommand: onAppPrivateCommand,
              restorationId: restorationId,
              scrollController: scrollController,
              selectionControls: selectionControls,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              clipBehavior: clipBehavior,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              scribbleEnabled: scribbleEnabled,
              onTap: onTap != null ? () => onTap(field.control) : null,
              onSubmitted: onSubmitted != null
                  ? (_) => onSubmitted(field.control)
                  : null,
              onEditingComplete: onEditingComplete != null
                  ? () => onEditingComplete.call(field.control)
                  : null,
              undoController: undoController,
              cursorOpacityAnimates: cursorOpacityAnimates,
              onTapOutside: onTapOutside,
              contentInsertionConfiguration: contentInsertionConfiguration,
              canRequestFocus: canRequestFocus,
              spellCheckConfiguration: spellCheckConfiguration,
              magnifierConfiguration: magnifierConfiguration,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, Null> createState() => _ReactiveTextFieldState<T>();
}

class _ReactiveTextFieldState<T>
    extends ReactiveFocusableFormFieldState<T, Null> {
  @override
  ControlValueAccessor<T, Null> selectValueAccessor() {
    return NullValueAncesor<T>() as ControlValueAccessor<T, Null>;
  }
}

class NullValueAncesor<T> extends ControlValueAccessor<T, Null> {
  @override
  Null modelToViewValue(T? modelValue) {
    return null;
  }

  @override
  T? viewToModelValue(Null viewValue) {
    return null;
  }
}
