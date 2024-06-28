import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../firebase/models/sci_club.dart';
import '../../../../firebase/repositories/sci_clubs_repo.dart';
import '../../../../firebase/repositories/tags_repo.dart';

import 'selected_tag_controller.dart';

part 'scientific_circles_tab_controller.g.dart';

@riverpod
class SearchScientificCirclesController
    extends _$SearchScientificCirclesController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<Iterable<SciClub?>?> _sciCirclesFilteredByTextQuery(
    _SciCirclesFilteredByTextQueryRef ref) async {
  final originalList = await ref.watch(sciClubsRepoProvider.future);
  final query = ref.watch(searchScientificCirclesControllerProvider);
  return originalList.where((element) =>
      element.name.toLowerCase().contains(query.toLowerCase()) ||
      (element.department?.toLowerCase().contains(query.toLowerCase()) ??
          false));
}

@riverpod
Future<Iterable<SciClub?>?> scientificCircleList(
    ScientificCircleListRef ref) async {
  final circles =
      await ref.watch(_sciCirclesFilteredByTextQueryProvider.future);

  final selectedCategory = ref.watch(selectedTagControllerProvider);
  if (selectedCategory == ref.watch(allTagSingletonProvider).name) {
    return circles;
  }

  final filteredAndSelectedTag = circles?.where((circle) {
    return circle?.tags.any((tag) => tag == selectedCategory) ?? false;
  });
  return filteredAndSelectedTag;
}
