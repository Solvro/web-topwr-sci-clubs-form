import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../api_base/watch_query_adapter.dart";
import "getScientificCircles.graphql.dart";

part "scientific_circles_repository.g.dart";

typedef ScientificCircle
    = Query$GetScientificCircles$Scientific_Circles; // just alias for shorter type name

@riverpod
Stream<List<ScientificCircle?>?> scientificCirclesRepository(
  ScientificCirclesRepositoryRef ref,
) async* {
  final stream = ref.watchQueryWithCache(
    WatchOptions$Query$GetScientificCircles(eagerlyFetchResults: true),
  );
  yield* stream.map(
    (event) => event?.Scientific_Circles.toList(),
  );
}
