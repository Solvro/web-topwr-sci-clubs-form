import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

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
  DropzoneViewController? controller;

  String? tempUrl;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField(
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
                Positioned.fill(
                  child: DropzoneView(
                    mime: FormFieldConfig.imageMimes,
                    operation: DragOperation.copy,
                    cursor: CursorType.grab,
                    onCreated: (DropzoneViewController ctrl) =>
                        controller = ctrl,
                    onError: (String? ev) => setError(DropzoneErrors.onError),
                    onDrop: onDrop,
                    onDropMultiple: (List<dynamic>? ev) => onDrop(ev?.first),
                    onDropInvalid: (value) =>
                        setError(DropzoneErrors.onDropInvalid),
                  ),
                ),
                DragAndDropImagePreview(
                  url: tempUrl,
                  onRemoveFile: onRemoveFile,
                  onPickFile: onPickFile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onDrop(value) async {
    if (value == null) {
      return setError(DropzoneErrors.onDropInvalid);
    }

    final data = await controller?.getFileData(value);
    widget.formControl?.updateValue(data);
    widget.formControl?.markAsTouched();
    tempUrl = await controller?.createFileUrl(value);
  }

  @override
  void dispose() {
    if (tempUrl != null) {
      controller?.releaseFileUrl(tempUrl!);
    }
    super.dispose();
  }

  void setError(DropzoneErrors err) {
    widget.formControl?.setErrors({
      err.toString(): switch (err) {
        DropzoneErrors.onError => "Dropzone On Error",
        DropzoneErrors.onDropInvalid => "Dropzone On Drop Invalid",
      },
    });
  }

  void onRemoveFile() {
    tempUrl = null;
    widget.formControl?.updateValue(null);
  }

  void onPickFile() async {
    final data = await controller?.pickFiles(
      multiple: false,
      mime: FormFieldConfig.imageMimes,
    );
    if (data == null) {
      return setError(DropzoneErrors.onDropInvalid);
    }
    widget.formControl?.updateValue(data.firstOrNull);
    widget.formControl?.markAsTouched();
    tempUrl = await controller?.createFileUrl(data.firstOrNull);
  }
}

enum DropzoneErrors {
  onError,
  onDropInvalid,
}
