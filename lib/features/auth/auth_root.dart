import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../navigation/utils/parse_query.dart";
import "../splash_screen/widgets/flutter_splash_screen.dart";
import "../topwr_mockup/widgets/my_error_widget.dart";
import "models/auth_state.dart";
import "repository/remote_auth_repo.dart";
import "widgets/guest_page.dart";
import "widgets/wrong_url_page.dart";

typedef LoggedBuilder = Widget Function(BuildContext context, Logged value);

class AuthRoot extends ConsumerStatefulWidget {
  const AuthRoot({required this.builder, super.key});

  final LoggedBuilder builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthRootState();
}

class _AuthRootState extends ConsumerState<AuthRoot> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async => ref
          .read(remoteAuthRepoProvider.notifier)
          .loginWithQuery(context.queryParams),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(remoteAuthRepoProvider);
    return switch (state) {
      AsyncLoading<AuthState>() => const FlutterSplashScreen(),
      AsyncError<AuthState>(:final error) => MyErrorWidget(error),
      AsyncData<AuthState>(value: final Wrong _) => const WrongUrlPage(),
      AsyncData<AuthState>(value: final Guest _) => const GuestPage(),
      AsyncData<AuthState>(:final Logged value) =>
        widget.builder(context, value),
      AsyncValue<AuthState>() => throw UnimplementedError(),
    };
  }
}
