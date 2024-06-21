import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'none_preview.dart';

class DragAndDropImagePreview extends StatelessWidget {
  const DragAndDropImagePreview(
    this.image, {
    super.key,
    this.onRemoveFile,
    this.onPickFile,
  });

  final Uint8List? image;
  final VoidCallback? onRemoveFile;
  final VoidCallback? onPickFile;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return DragAndDropNonePreview(
        onPressed: onPickFile,
      );
    }
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onRemoveFile,
            icon: const Icon(Icons.close_outlined),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Image.memory(image!),
        ),
      ],
    );
  }
}
