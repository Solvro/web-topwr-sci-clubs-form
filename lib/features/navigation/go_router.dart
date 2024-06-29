import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../main.dart';
import '../auth/repository/remote_auth_repo.dart';
import 'page_404.dart';
import 'utils/parse_query.dart';

part 'go_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          Future.microtask(
            () => ref
                .read(remoteAuthRepoProvider.notifier)
                .loginWithQuery(state.queryParams),
          );
          return const RootView();
        },
      ),
    ],
    errorBuilder: (context, state) => const Page404(),
  );
}
