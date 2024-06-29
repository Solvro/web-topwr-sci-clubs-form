import 'package:flutter/material.dart';

import '../../main.dart';
import 'page_404.dart';
import 'utils/parse_query.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.rawName) {
    case '/':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const RootView();
        },
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return const Page404();
        },
      );
  }
}
