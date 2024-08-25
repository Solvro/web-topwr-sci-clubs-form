import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../firebase/models/sci_club.dart";
import "../../science_clubs_filters/filters_controller.dart";

part "current_sci_club_filtered.g.dart";

@riverpod
bool isCurrentSciClubFilterVisible(
  IsCurrentSciClubFilterVisibleRef ref,
  SciClub currentSciClub,
) {
  if (!ref.watch(areFiltersEnabledProvider)) {
    return true;
  }
  final selectedTags =
      ref.watch(selectedTagControllerProvider).map((it) => it.name);

  final selectedDepartments =
      ref.watch(selectedDepartmentControllerProvider).map((it) => it.name);

  final selectedTypes =
      ref.watch(selectedTypeControllerProvider).map((it) => it.toJson());

  final typesIncludes = selectedTypes.isEmpty ||
      selectedTypes.contains(currentSciClub.type?.toJsonVal());
  final tagsIncludes =
      selectedTags.isEmpty || currentSciClub.tags.any(selectedTags.contains);
  final departmentsIncludes = selectedDepartments.isEmpty ||
      selectedDepartments.contains(currentSciClub.department);

  return typesIncludes && tagsIncludes && departmentsIncludes;
}
