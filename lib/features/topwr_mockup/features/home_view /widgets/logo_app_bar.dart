import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../theme/app_theme.dart";
import "../../../config/ui_config.dart";

class LogoAppBar extends AppBar {
  /// AppBar with ToPwr colorful logo
  LogoAppBar(
    BuildContext context, {
    super.key,
    Color? backgroundColor,
    VoidCallback? onLogoTap,
    super.actions,
  }) : super(
          title: AppBarLogo(onLogoTap),
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: backgroundColor ?? context.colorTheme.whiteSoap,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
        );
}

class AppBarLogo extends StatelessWidget {
  /// ToPwr Appbar svg colorful themed logo
  const AppBarLogo(this.onLogoTap, {super.key});

  final VoidCallback? onLogoTap;
  static Future<void> precacheImageIfAbsent() async {
    const loader = SvgAssetLoader(AppBarConfig.logoAssetName);
    await svg.cache
        .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLogoTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: SvgPicture.asset(AppBarConfig.logoAssetName),
      ),
    );
  }
}
