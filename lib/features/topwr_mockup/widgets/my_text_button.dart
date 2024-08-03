import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    this.onClick,
    required this.actionTitle,
    this.isOrange = true,
    this.icon,
  });

  final IconData? icon;
  final void Function()? onClick;
  final String actionTitle;
  final bool isOrange;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClick,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      icon: icon == null
          ? null
          : Icon(
              icon,
              color: isOrange
                  ? context.colorTheme.orangePomegranade
                  : context.colorTheme.blueAzure,
            ),
      label: Text(
        actionTitle,
        style: isOrange
            ? context.textTheme.boldBodyOrange
            : context.textTheme.boldBody.copyWith(
                color: context.colorTheme.blueAzure,
              ),
      ),
    );
  }
}
