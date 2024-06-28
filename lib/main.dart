import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_theme.dart';
import '../../theme/colors.dart';
import 'config/config.dart';
import 'features/form/form_widget.dart';
import 'features/form/widgets/form_root_widget.dart';
import 'features/form/widgets/submit_button.dart';
import 'features/mockup_frame/mockup_frame.dart';
import 'features/mockup_frame/split_view.dart';
import 'features/topwr_mockup/config/ui_config.dart';
import 'features/topwr_mockup/features/home_view /widgets/logo_app_bar.dart';
import 'features/splash_screen/splash_screen.dart';
import 'features/splash_screen/splash_screen_controller.dart';
import 'firebase_options.dart';

void main() async {
  SplashScreenController.preserveNativeSplashScreen();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormRootWidget(
      child: Scaffold(
        appBar: LogoAppBar(
          context,
          backgroundColor: context.colorTheme.greyLight,
          actions: [
            const SubmitButton(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SvgPicture.asset(
                WebAppBarConfig.created_by_svg,
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
    );
  }
}
