import 'dart:ui';

abstract class SplashScreenConfig {
  static const logoAssetName = "assets/splash_screen/splash_logo.png";
  static const additionalWaitDuration = Duration(milliseconds: 0);
  static const animationDuration = Duration(milliseconds: 800);
  static const androidSplashSizeInDp = 288.0;
  static const androidNativeSplashColor = Color(0xFFEE6644);
}
