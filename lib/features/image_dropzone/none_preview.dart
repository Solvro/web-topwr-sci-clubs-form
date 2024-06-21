import 'package:flutter/material.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../form/widgets/text_style.dart';

class DragAndDropNonePreview extends StatelessWidget {
  const DragAndDropNonePreview({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.localize.drag_and_drop,
          style: context.textTheme.title,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(FormFieldConfig.radius),
                  side: BorderSide(
                    color: FieldStateColor(context),
                  ),
                ),
              ),
            ),
            child: Text(context.localize.or_choose_btn_msg),
          ),
        ),
      ],
    );
  }
}
