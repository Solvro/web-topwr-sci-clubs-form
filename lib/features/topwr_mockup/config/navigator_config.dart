import 'package:flutter/cupertino.dart';

import '../../form/model/form_model.dart';
import '../features/home_view /home_view.dart';
import '../features/sci_clubs_tab/scientific_circles_tab.dart';
import 'nav_bar_config.dart';

abstract class NavigatorConfig {
  static const initialTab = NavBarEnum.home;
}

abstract class AppRoutes {
  AppRoutes._();

  static const root = '/';
  static const studyCircleDetails = 'study-circle-details';
}

abstract class TabsConfig {
  static UnmodifiableNavBarEnumMap<Widget> tabs(BuildContext context) =>
      UnmodifiableNavBarEnumMap(
        home: HomeView(form: ReactiveSciClubFormModelForm.of(context)),
        mapp: const Placeholder(),
        faculties: const Placeholder(),
        sciCircles: const ScientificCirclesTab(),
        parkings: const Placeholder(),
        info: const Placeholder(),
      );
}
