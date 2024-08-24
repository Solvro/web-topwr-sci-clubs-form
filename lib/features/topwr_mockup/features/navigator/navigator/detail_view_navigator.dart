import "dart:async";

import "../../../config/nav_bar_config.dart";
import "../../../config/navigator_config.dart";
import "nested_navigator.dart";
import "tab_bar_navigator.dart";

/// Extracted logic of navigating to detailed views
extension DetailViewNavigator on NestedNavigator {
  void navigateToScienceClubsDetails(String argument) {
    unawaited(changeTabBar(NavBarEnum.sciCircles));
    unawaited(
      navigatorKey.currentState?.pushNamed(
        AppRoutes.studyCircleDetails,
        arguments: argument,
      ),
    );
  }
}
