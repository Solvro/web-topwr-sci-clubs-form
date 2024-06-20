import 'package:device_frame/device_frame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../topwr_mockup/config/ui_config.dart';
import '../topwr_mockup/features/navigator/root_navigator_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockupFrame extends StatelessWidget {
  const MockupFrame({super.key});

  @override
  Widget build(BuildContext context) {
    // return DeviceFrame(
    //   device: Devices.ios.iPhone12,
    //   orientation: Orientation.portrait,
    //   screen: Builder(
    //     builder: (deviceContext) => const RootNavigatorWidget(),
    //   ),
    // );
    return DeviceFrame(
      device: Devices.ios.iPhoneSE,
      // device: DeviceInfo.genericPhone(
      //   platform: TargetPlatform.android,
      //   name: 'Medium',
      //   id: 'medium',
      //   screenSize: const Size(412, 732),
      //   safeAreas: const EdgeInsets.only(
      //     left: 0.0,
      //     top: 24.0,
      //     right: 0.0,
      //     bottom: 0.0,
      //   ),
      //   rotatedSafeAreas: const EdgeInsets.only(
      //     left: 0.0,
      //     top: 24.0,
      //     right: 0.0,
      //     bottom: 0.0,
      //   ),
      // ),
      orientation: Orientation.portrait,
      isFrameVisible: true,
      screen: MaterialApp(
        title: MyAppConfig.title,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: Theme.of(context),
        debugShowCheckedModeBanner: false,
        scrollBehavior: FixScroll(),
        home: const RootNavigatorWidget(),
      ),
    );
  }
}

class FixScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
