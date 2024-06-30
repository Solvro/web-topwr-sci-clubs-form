import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'config/config.dart';
import 'config/firebase.dart';
import 'features/auth/auth_root.dart';
import 'features/form/form_root_widget.dart';
import 'features/form/form_widget.dart';
import 'features/form/widgets/submit_button.dart';
import 'features/mockup_frame/mockup_frame.dart';
import 'features/mockup_frame/split_view.dart';
import 'features/navigation/go_router.dart';
import 'features/splash_screen/splash_screen.dart';
import 'features/splash_screen/splash_screen_controller.dart';
import 'features/topwr_mockup/config/ui_config.dart';
import 'features/topwr_mockup/features/home_view /widgets/logo_app_bar.dart';

void main() async {
  usePathUrlStrategy();
  SplashScreenController.preserveNativeSplashScreen();
  await firebaseConfig();
  runApp(
    const ProviderScope(
      child: SplashScreen(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
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
    );
  }
}

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthRoot(
      builder: (context, value) => FormRootWidget(
        child: Scaffold(
          appBar: LogoAppBar(
            context,
            backgroundColor: context.colorTheme.greyLight,
            actions: [
              const SubmitButton(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SvgPicture.asset(
                  WebAppBarConfig.createdBySvg,
                  width: 180,
                ),
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: FormSplitView(
              form: SciClubForm(),
              phone: MockupFrame(),
            ),
          ),
        ),
      ),
    );
  }
}
