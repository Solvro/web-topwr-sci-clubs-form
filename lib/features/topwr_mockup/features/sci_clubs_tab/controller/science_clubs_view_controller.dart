import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../utils/contains_lower_case.dart";
import "../../../../../utils/where_non_null_iterable.dart";
import "../../../../firebase/models/sci_club.dart";
import "../../../../firebase/repositories/sci_clubs_repo.dart";
import "../../science_clubs_filters/filters_controller.dart";

part "science_clubs_view_controller.g.dart";

@riverpod
class SearchScienceClubsController extends _$SearchScienceClubsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<Iterable<SciClub?>?> _sciClubsFilteredByTextQuery(
  _SciClubsFilteredByTextQueryRef ref,
) async {
  final originalList = await ref.watch(sciClubsRepoProvider.future);
  final query = ref.watch(searchScienceClubsControllerProvider);
  return originalList.where(
    (element) =>
        element.name.containsLowerCase(query) ||
        element.department.containsLowerCase(query),
  );
}

@riverpod
Future<Iterable<SciClub?>?> scienceClubsListController(
  ScienceClubsListControllerRef ref,
) async {
  final sciClubs =
      (await ref.watch(_sciClubsFilteredByTextQueryProvider.future))
          .whereNonNull;

  if (!ref.watch(areFiltersEnabledProvider)) {
    return sciClubs;
  }

  final selectedTags =
      ref.watch(selectedTagControllerProvider).map((it) => it.name);

  final selectedDepartments =
      ref.watch(selectedDepartmentControllerProvider).map((it) => it.name);

  final selectedTypes =
      ref.watch(selectedTypeControllerProvider).map((it) => it.toJson());

  final filteredByTypes = selectedTypes.isEmpty
      ? sciClubs
      : sciClubs.whereNonNull.where(
          (club) => selectedTypes.contains(club.type?.toJsonVal()),
        );

  final filteredByDepartments = selectedDepartments.isEmpty
      ? filteredByTypes
      : filteredByTypes.where(
          (club) => selectedDepartments.contains(club.department),
        );

  final filteredByTags = selectedTags.isEmpty
      ? filteredByDepartments
      : filteredByDepartments.where(
          (club) => club.tags.whereNonNull.any(selectedTags.contains),
        );

  return filteredByTags;
}
