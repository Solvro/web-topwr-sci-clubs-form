import "package:auto_route/auto_route.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../main.dart";
import "page_404.dart";

part "router.g.dart";
part "router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/", page: RootRoute.page),
        AutoRoute(path: "*", page: Page404Route.page),
      ];
}

@Riverpod(keepAlive: true)
AppRouter router(RouterRef ref) {
  return AppRouter();
}
