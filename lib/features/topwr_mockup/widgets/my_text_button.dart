import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.onClick,
    required this.actionTitle,
    this.isOrange = true,
  });

  final void Function()? onClick;
  final String actionTitle;
  final bool isOrange;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          actionTitle,
          style: isOrange
              ? context.textTheme.boldBodyOrange
              : context.textTheme.boldBody.copyWith(
                  color: context.colorTheme.blueAzure,
                ),
        ),
      ),
    );
  }
}
