import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import '../../config/config.dart';
import '../../theme/app_theme.dart';
import '../form/widgets/text_style.dart';
import 'image_preview.dart';

class ImageDropzone extends StatefulWidget {
  const ImageDropzone({
    super.key,
    required this.formControl,
    this.height = FormFieldConfig.bigSectionDefHeight,
    required this.label,
  });

  final FormControl<Uint8List>? formControl;
  final double height;
  final String label;
  @override
  State<ImageDropzone> createState() => _ImageDropzoneState();
}

class _ImageDropzoneState extends State<ImageDropzone> {
  bool canDrop = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      child: DropRegion(
        formats: FormFieldConfig.dragAndDropFormats,
        onDropOver: (event) {
          if (event.session.allowedOperations.contains(DropOperation.copy)) {
            showDroppingAllowed();
            return DropOperation.copy;
          }
          return DropOperation.none;
        },
        onDropLeave: (_) => disableDroppingAllowed(),
        onDropEnded: (_) => disableDroppingAllowed(),
        onPerformDrop: onPerformDrop,
        child: ReactiveFormField(
          formControl: widget.formControl,
          builder: (fieldState) {
            return Container(
              height: widget.height,
              padding: FormFieldConfig.padding,
              child: DottedBorder(
                color: FieldStateColor(context).resolve({
                  if (fieldState.errorText != null) WidgetState.error,
                  if (canDrop) WidgetState.focused,
                }),
                strokeWidth: 1,
                radius: FormFieldConfig.radius,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedContainer(
                      duration: Durations.short4,
                      color: canDrop
                          ? context.colorTheme.greyPigeon.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    // IgnorePointer(
                    //   child: ReactiveTextField<Uint8List>(
                    //     maxLines: double.maxFinite.toInt(),
                    //     formControl: widget.formControl,
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       label: Padding(
                    //         padding: const EdgeInsets.only(left: 8.0),
                    //         child: Text(widget.label),
                    //       ),
                    //       floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     ),
                    //     readOnly: true,
                    //   ),
                    // ),
                    DragAndDropImagePreview(
                      widget.formControl?.value,
                      onRemoveFile: onRemoveFile,
                      onPickFile: onPickFile,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void didChange(Uint8List value) async {
    widget.formControl?.updateValue(value);
    widget.formControl?.markAsTouched();
  }

  void setError() {
    widget.formControl?.setErrors({
      FormFieldConfig.dragAndDropError: FormFieldConfig.dragAndDropError,
    });
  }

  void onRemoveFile() {
    widget.formControl?.updateValue(null);
    widget.formControl?.markAsUntouched();
  }

  Future<void> onPerformDrop(PerformDropEvent event) async {
    final reader = event.session.items.first.dataReader;
    if (reader != null) {
      if (FormFieldConfig.dragAndDropFormats.any(reader.canProvide)) {
        reader.getFile(
          FormFieldConfig.dragAndDropFormats.firstWhere(reader.canProvide),
          (file) async {
            didChange(await file.readAll());
          },
          onError: (error) => setError(),
        );
      }
    }
  }

  void onPickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: FormFieldConfig.filePickerFormats,
    );
    final data = await result?.xFiles.first.readAsBytes();
    if (data != null) didChange(data);
  }

  void showDroppingAllowed() {
    setState(() {
      canDrop = true;
    });
  }

  void disableDroppingAllowed() {
    setState(() {
      canDrop = false;
    });
  }
}
