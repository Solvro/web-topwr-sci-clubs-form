import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/utils/parse_query.dart';
import 'auth_root.dart';
import 'repository/remote_auth_repo.dart';

class LoginFromQueryParams extends ConsumerWidget {
  const LoginFromQueryParams({required this.builder, super.key});

  final LoggedBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ModalRoute.of(context)?.settings.queryParams;
    print(params);
    Future.microtask(
      () => ref
          .read(
            remoteAuthRepoProvider.notifier,
          )
          .loginWithQuery(params),
    );
    return AuthRoot(builder: builder);
  }
}
