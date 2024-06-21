import 'package:device_frame/device_frame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../topwr_mockup/config/ui_config.dart';
import '../topwr_mockup/features/navigator/root_navigator_widget.dart';

class MockupFrame extends StatelessWidget {
  const MockupFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: DeviceFrame(
        device: Devices.ios.iPhoneSE,
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
