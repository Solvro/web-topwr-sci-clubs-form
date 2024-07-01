import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';

part 'go_router.g.dart';
part 'go_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/", page: RootRoute.page, fullMatch: true),
      ];
}

@Riverpod(keepAlive: true)
AppRouter router(RouterRef ref) {
  return AppRouter();
}
