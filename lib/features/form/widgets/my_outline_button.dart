import "package:flutter/material.dart";

import "../../../config/config.dart";
import "../../../theme/app_theme.dart";

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({
    super.key,
    this.onClick,
    required this.actionTitle,
    this.icon,
    this.isOrange = false,
  });
  final VoidCallback? onClick;
  final String actionTitle;
  final IconData? icon;
  final bool isOrange;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isOrange
          ? Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: context.colorTheme.orangePomegranade,
                  ),
            )
          : Theme.of(context),
      child: OutlinedButton.icon(
        onPressed: onClick,
        label: Text(actionTitle),
        icon: icon == null ? null : Icon(icon),
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(FormFieldConfig.radius),
            ),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
        ),
      ),
    );
  }
}
