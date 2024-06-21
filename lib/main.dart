import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'features/form/form_widget.dart';
import 'features/mockup_frame/mockup_frame.dart';
import 'features/mockup_frame/split_view.dart';
import 'features/topwr_mockup/config/ui_config.dart';
import 'features/topwr_mockup/features/home_view /widgets/logo_app_bar.dart';
import 'features/topwr_mockup/features/splash_screen/splash_screen.dart';
import 'features/topwr_mockup/features/splash_screen/splash_screen_controller.dart';

void main() async {
  SplashScreenController.preserveNativeSplashScreen();
  runApp(
    const ProviderScope(
      child: SplashScreen(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyAppConfig.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        extensions: const [AppTheme()],
        colorScheme: const ColorScheme.light().copyWith(
          surface: ColorsConsts.whiteSoap,
          primary: ColorsConsts.blueAzure,
          error: ColorsConsts.orangePomegranade,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const RootView(),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LogoAppBar(
          context,
          backgroundColor: context.colorTheme.greyLight,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FormSplitView(
            form: SciClubForm(),
            phone: MockupFrame(),
          ),
        ));
  }
}
