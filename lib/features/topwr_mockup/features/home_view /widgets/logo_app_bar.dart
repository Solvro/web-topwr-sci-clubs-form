import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../theme/app_theme.dart';
import '../../../config/ui_config.dart';

class LogoAppBar extends AppBar {
  /// AppBar with ToPwr colorful logo
  LogoAppBar(
    BuildContext context, {
    super.key,
    Color? backgroundColor,
    super.actions,
  }) : super(
          title: const AppBarLogo(),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: backgroundColor ?? context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
        );
}

class AppBarLogo extends StatelessWidget {
  /// ToPwr Appbar svg colorful themed logo
  const AppBarLogo({super.key});

  static Future<void> precacheImageIfAbsent() async {
    const loader = SvgAssetLoader(AppBarConfig.logoAssetName);
    await svg.cache
        .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: SvgPicture.asset(AppBarConfig.logoAssetName),
    );
  }
}
