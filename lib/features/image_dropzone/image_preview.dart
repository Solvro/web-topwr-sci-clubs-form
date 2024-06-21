import 'package:flutter/material.dart';

import 'none_preview.dart';

class DragAndDropImagePreview extends StatelessWidget {
  const DragAndDropImagePreview({
    super.key,
    required this.url,
    this.onRemoveFile,
    this.onPickFile,
  });

  final String? url;
  final VoidCallback? onRemoveFile;
  final VoidCallback? onPickFile;
  @override
  Widget build(BuildContext context) {
    if (url == null) {
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
          child: Image.network(url!),
        ),
      ],
    );
  }
}
