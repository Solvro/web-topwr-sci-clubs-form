import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import '../config/api_base_config.dart';

final _hiveCacheBoxProvider = Provider((ref) async {
  return GraphQLCache();
});

final gqlClientProvider = Provider((ref) async {
  final hiveCache = await ref.watch(_hiveCacheBoxProvider);
  return GraphQLClient(
    cache: hiveCache,
    link: HttpLink(ApiBaseEnv.apiUrl),
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.networkOnly,
      ),
      watchQuery: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      ),
    ),
  );
});
