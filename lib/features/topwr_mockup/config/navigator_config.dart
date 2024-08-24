import "package:flutter/cupertino.dart";

import "../features/home_view /home_view.dart";
import "../features/sci_clubs_tab/science_clubs_view.dart";
import "nav_bar_config.dart";

abstract class NavigatorConfig {
  static const initialTab = NavBarEnum.home;
}

abstract class AppRoutes {
  AppRoutes._();

  static const root = "/";
  static const studyCircleDetails = "study-circle-details";
}

abstract class TabsConfig {
  static const tabs = UnmodifiableNavBarEnumMap(
    home: HomeView(),
    mapp: Placeholder(),
    faculties: Placeholder(),
    sciCircles: ScienceClubsView(),
    parkings: Placeholder(),
    info: Placeholder(),
  );
}
