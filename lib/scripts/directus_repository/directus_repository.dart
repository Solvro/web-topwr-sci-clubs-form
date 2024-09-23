import "package:graphql/client.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../api_base/gql_client_provider.dart";
import "../../api_base/schema.graphql.dart";
import "get_directus_tags.graphql.dart";
import "mutate_sci_club.graphql.dart";

part "directus_repository.g.dart";

typedef SciClubDirectusUpdate = Input$update_Scientific_Circles_input;

@Riverpod(keepAlive: true)
class DirectusRepository extends _$DirectusRepository {
  @override
  // ignore: prefer_void_to_null
  Future<List<Query$GetDirectusTags$Tags>> build() async {
    final apiClient = await ref.watch(gqlClientProvider);
    final res = await apiClient.query$GetDirectusTags();
    return res.parsedData?.Tags ?? [];
  }

  Future<QueryResult<Mutation$updateSciClubs>> updateSciClub(
    String id,
    SciClubDirectusUpdate data,
  ) async {
    final apiClient = await ref.watch(gqlClientProvider);
    return apiClient.mutate$updateSciClubs(
      Options$Mutation$updateSciClubs(
        variables: Variables$Mutation$updateSciClubs(id: id, data: data),
      ),
    );
  }
}
