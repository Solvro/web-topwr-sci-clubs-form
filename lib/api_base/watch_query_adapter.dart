import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'gql_client_provider.dart';

class GqlOfflineException implements Exception {
  const GqlOfflineException();
}

extension _WatchQueryStreamAdapter<T> on Ref {
  void handleErrors(QueryResult<T> event) {
    if (!event.hasException) return;

    if (event.exception?.linkException != null) {
      throw const GqlOfflineException();
    }

    throw Exception(
      event.exception,
    ); //rethrow GraphQL Errors as not silent ones
  }

  Stream<QueryResult<T>> watchQueryStreamAdapter(
    GraphQLClient client,
    WatchQueryOptions<T> options,
  ) {
    final observableQuery = client.watchQuery(options);
    onDispose(observableQuery.close);
    return observableQuery.stream.map((event) {
      handleErrors(event);
      return event;
    }).where(
      (event) => event.isNotLoading,
    );
  }
}

extension TTLWatchQueryAdapter on AutoDisposeStreamProviderRef {
  Stream<T?> watchQueryWithCache<T>(
      WatchQueryOptions<T> watchQueryOptions) async* {
    final apiClient = await watch(gqlClientProvider);
    final newOptions = watchQueryOptions;
    yield* watchQueryStreamAdapter(
      apiClient,
      newOptions,
    ).map(
      (event) => event.parsedData,
    );
  }
}
