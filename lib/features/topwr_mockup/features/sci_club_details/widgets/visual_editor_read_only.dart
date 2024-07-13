import 'dart:async';

import 'package:flutter/material.dart';

import 'package:visual_editor/visual-editor.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../../utils/delta_utils.dart';
import '../../../../form/model/form_model.dart';

class VisualEditorReadOnly extends StatefulWidget {
  const VisualEditorReadOnly(
    this.id, {
    super.key,
    required this.json,
  });

  final String json;
  final String id;
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
      final form = ReactiveSciClubFormModelForm.of(context);
      final isCurrForm = form?.idControl?.value == widget.id;
      if (isCurrForm) {
        _subs = form?.form.valueChanges.listen(listenOnChanges);
      }
    });
    super.initState();
  }

  void listenOnChanges(values) {
    final form = ReactiveSciClubFormModelForm.of(context);
    final val = form?.descriptionControl?.value;
    if (val is String) {
      controller.update(DeltaUtil.tryFromJson(val).delta);
    }
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
          customStyles: EditorStylesM(
            bold: const TextStyle(fontWeight: FontWeight.w900),
            link: TextStyle(
              color: context.colorTheme.orangePomegranade,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
