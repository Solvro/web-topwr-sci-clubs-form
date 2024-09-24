// ignore_for_file: unreachable_from_main

import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";
// ignore: depend_on_referenced_packages
import "package:flutter_web_plugins/url_strategy.dart";

import "../../theme/app_theme.dart";
import "../../theme/colors.dart";
import "config/config.dart";
import "config/firebase.dart";
import "features/auth/auth_root.dart";
import "features/form/form_root_widget.dart";
import "features/form/form_widget.dart";
import "features/form/widgets/submit_button.dart";
import "features/mockup_frame/breakpoint.dart";
import "features/mockup_frame/floating_app_bar.dart";
import "features/mockup_frame/mockup_frame.dart";
import "features/mockup_frame/split_view.dart";
import "features/navigation/router.dart";
import "features/splash_screen/splash_screen.dart";
import "features/splash_screen/splash_screen_controller.dart";
import "features/topwr_mockup/config/ui_config.dart";
import "features/topwr_mockup/features/home_view /widgets/logo_app_bar.dart";
import "scripts/compare_back.dart";

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
    unawaited(ref.read(compareBackProvider.notifier).compare());
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router.config(),
      title: MyAppConfig.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        extensions: const [AppTheme()],
        colorScheme: const ColorScheme.light().copyWith(
          surface: ColorsConsts.whiteSoap,
          primary: ColorsConsts.blueAzure,
          error: ColorsConsts.orangePomegranade,
          secondary: ColorsConsts.orangePomegranade,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

@RoutePage()
class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = LogoAppBar(
      context,
      backgroundColor: context.colorTheme.greyLight,
      actions: [
        if (context.showSplitView) const SubmitButton(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SvgPicture.asset(
            WebAppBarConfig.createdBySvg,
            width: 180,
          ),
        ),
      ],
    );

    return AuthRoot(
      builder: (context, value) => FormRootWidget(
        child: context.showSplitView
            ? Scaffold(
                appBar: appBar,
                resizeToAvoidBottomInset: false,
                body: const Padding(
                  padding: EdgeInsets.all(8),
                  child: FormSplitView(
                    form: SciClubFormScaffold(
                      child: CustomScrollView(
                        slivers: [
                          SciClubForm(),
                        ],
                      ),
                    ),
                    phone: MockupFrame(),
                  ),
                ),
              )
            : SciClubFormScaffold(
                child: FloatingAppBarScrollView(
                  appBar: appBar,
                  child: const SciClubForm(),
                ),
              ),
      ),
    );
  }
}
