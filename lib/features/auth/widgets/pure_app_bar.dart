import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../topwr_mockup/features/home_view /widgets/logo_app_bar.dart';

class PureWebAppBar extends LogoAppBar {
  PureWebAppBar(super.context, {super.key})
      : super(
          onLogoTap: () {
            context.go("/");
          },
          backgroundColor: context.colorTheme.greyLight,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SvgPicture.asset(
                WebAppBarConfig.createdBySvg,
                width: 180,
              ),
            ),
          ],
        );
}