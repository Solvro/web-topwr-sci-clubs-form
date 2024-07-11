import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../current_sci_club/models/url.dart';
import '../topwr_mockup/widgets/my_cached_image.dart';
import 'none_preview.dart';

class DragAndDropImagePreview extends StatelessWidget {
  const DragAndDropImagePreview(
    this.image, {
    super.key,
    this.onRemoveFile,
    this.onPickFile,
  });

  final AbstractUrl? image;
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
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: _Image(image: image),
          ),
        ),
        _CloseButton(onRemoveFile: onRemoveFile),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    required this.onRemoveFile,
  });

  final VoidCallback? onRemoveFile;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton.filled(
        onPressed: onRemoveFile,
        icon: const Icon(Icons.close_outlined),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
          context.colorTheme.blueAzure,
        )),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.image,
  });

  final AbstractUrl? image;

  @override
  Widget build(BuildContext context) {
    return MyCachedImage(
      image?.url ?? "",
      boxFit: BoxFit.cover,
      filterQuality: FilterQuality.none,
    );
  }
}
