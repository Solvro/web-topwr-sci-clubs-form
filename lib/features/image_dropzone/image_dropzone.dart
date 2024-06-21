import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import '../../config.dart';
import '../form/widgets/text_style.dart';
import 'image_preview.dart';

class ImageDropzone extends StatefulWidget {
  const ImageDropzone({
    super.key,
    required this.formControl,
    this.sizeInLines = 10,
    this.height = 300,
  });

  final FormControl<Uint8List>? formControl;
  final int sizeInLines;
  final double height;
  @override
  State<ImageDropzone> createState() => _ImageDropzoneState();
}

class _ImageDropzoneState extends State<ImageDropzone> {
  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: FormFieldConfig.imageFormats,
      onDropOver: (event) {
        if (event.session.allowedOperations.contains(DropOperation.copy)) {
          return DropOperation.copy;
        }
        return DropOperation.none;
      },
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
              }),
              strokeWidth: 1,
              radius: FormFieldConfig.radius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ReactiveTextField(
                      maxLines: double.maxFinite.toInt(),
                      formControl: widget.formControl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      )),
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
      if (FormFieldConfig.imageFormats.any(reader.canProvide)) {
        reader.getFile(
          FormFieldConfig.imageFormats.firstWhere(reader.canProvide),
          (file) async {
            didChange(await file.readAll());
          },
          onError: (error) => setError(),
        );
      }
    }
  }

  void onPickFile() async {
    // final data = await controller?.pickFiles(
    //   multiple: false,
    //   mime: FormFieldConfig.imageMimes,
    // );
    // if (data == null) {
    //   return setError(DropzoneErrors.onDropInvalid);
    // }
    // widget.formControl?.updateValue(data.firstOrNull);
    // widget.formControl?.markAsTouched();
  }
}
