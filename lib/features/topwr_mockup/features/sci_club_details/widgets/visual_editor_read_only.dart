import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:visual_editor/document/services/delta.utils.dart';
import 'package:visual_editor/visual-editor.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../form/model/form_model.dart';
import '../../../../form/widgets/quill_field.dart';

class VisualEditorReadOnly extends StatefulWidget {
  const VisualEditorReadOnly({
    super.key,
    required this.json,
  });

  final String json;

  @override
  State<VisualEditorReadOnly> createState() => _VisualEditorReadOnlyState();
}

class _VisualEditorReadOnlyState extends State<VisualEditorReadOnly> {
  late final EditorController controller;

  StreamSubscription<Map<String, Object?>?>? _subs;

  @override
  void dispose() {
    _subs?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    controller = EditorController(
      document: DeltaUtil.tryFromJson(widget.json),
    );
    Future.microtask(() {
      _subs = ReactiveSciClubFormModelForm.of(context)
          ?.form
          .valueChanges
          .listen((values) {
        final value = values?["description"];
        if (value is String) {
          controller.update(DeltaUtil.tryFromJson(
            value,
          ).delta);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textTheme.body,
      child: VisualEditor(
        controller: controller,
        focusNode: FocusNode(canRequestFocus: false),
        config: EditorConfigM(
          readOnly: true,
          autoFocus: false,
          textSelectionControls: emptyTextSelectionControls,
          markersVisibility: false,
          enableInteractiveSelection: false,
        ),
      ),
    );
  }
}
