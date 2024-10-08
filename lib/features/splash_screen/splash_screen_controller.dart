import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/splash.dart";
import "../topwr_mockup/features/home_view /widgets/logo_app_bar.dart";

part "splash_screen_controller.g.dart";

@riverpod
class SplashScreenController extends _$SplashScreenController {
  Future<void> _initializationLogic(BuildContext context) async {
    /*
      Insert here any initialization async logic or operations 
      to be performed, when SplashScreen is showed.
    */
    // await MapMarkerUtils.loadMapMarkerAssets(context);
    // await initHiveForGraphqlCache();
    // await MapController.initializeGoogleMapsRenderingAndroid();

    await AppBarLogo.precacheImageIfAbsent();
  }

  @override
  Future<void> build(BuildContext context) async {
    await _initializationLogic(context);
    await Future.delayed(SplashScreenConfig.additionalWaitDuration);
    hideNativeSplashScreen();
  }

  /// Whether preserves native splash or show flutter one
  static bool get _preserveNativeSplash => kIsWeb || !Platform.isAndroid;

  /// Preserves native splash screen, except of Android, where FlutterSplashScreen is showed as soon as possible
  static void preserveNativeSplashScreen() {
    if (_preserveNativeSplash) {
      final WidgetsBinding widgetsBinding =
          WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }
  }

  /// Hides native splash screen (no effect on Android)
  static void hideNativeSplashScreen() {
    if (_preserveNativeSplash) {
      FlutterNativeSplash.remove();
    }
  }
}
