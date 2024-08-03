import "package:flutter/material.dart";

import "../../../config/navigator_config.dart";
import "../../../widgets/my_error_widget.dart";
import "../../sci_club_details/study_circle_details.dart";

class DetailPageRoute extends MaterialPageRoute {
  DetailPageRoute(RouteSettings settings)
      : super(
          builder: switch (settings.name) {
            AppRoutes.studyCircleDetails => (_) => const StudyCircleDetails(),
            _ => (_) => MyErrorWidget("Invalid route: ${settings.name}")
          },
          settings: settings,
        );
}
