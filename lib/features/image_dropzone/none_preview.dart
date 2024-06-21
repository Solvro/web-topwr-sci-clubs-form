import 'package:flutter/material.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../topwr_mockup/widgets/my_text_button.dart';

class DragAndDropNonePreview extends StatelessWidget {
  const DragAndDropNonePreview({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          context.localize.drag_and_drop,
          style: context.textTheme.title,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTextButton(
            actionTitle: context.localize.or_choose_btn_msg,
            onClick: onPressed,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.localize.allowed_ext +
                    FormFieldConfig.imageFormats
                        .map(
                          (x) => "*.${x.mimeTypes?.first.split("/")[1]}",
                        )
                        .join(", "),
                style: context.textTheme.body.copyWith(fontSize: 8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
