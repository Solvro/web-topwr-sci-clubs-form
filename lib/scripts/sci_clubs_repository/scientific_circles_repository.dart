import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../api_base/gql_client_provider.dart";
import "getScientificCircles.graphql.dart";

part "scientific_circles_repository.g.dart";

typedef ScientificCircle
    = Query$GetScientificCircles$Scientific_Circles; // just alias for shorter type name

@riverpod
Future<List<ScientificCircle>?> scientificCirclesRepository(
  ScientificCirclesRepositoryRef ref,
) async {
  final apiClient = await ref.watch(gqlClientProvider);
  final response = await apiClient.query$GetScientificCircles();
  return response.parsedData?.Scientific_Circles;
}
