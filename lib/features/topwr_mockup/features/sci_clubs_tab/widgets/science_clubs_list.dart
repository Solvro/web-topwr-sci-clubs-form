import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/where_non_null_iterable.dart";
import "../../../../firebase/models/sci_club.dart";
import "../../../config/ui_config.dart";
import "../../../widgets/my_error_widget.dart";
import "../../navigator/navigator/detail_view_navigator.dart";
import "../../navigator/navigator/nested_navigator.dart";
import "../controller/science_clubs_view_controller.dart";
import "science_club_card.dart";
import "science_clubs_view_loading.dart";

class ScienceClubsList extends ConsumerWidget {
  const ScienceClubsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scienceClubsListControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ScienceClubsViewConfig.mediumPadding,
      ),
      child: switch (state) {
        AsyncValue(:final Iterable<SciClub?> value) =>
          _ScienceClubsListView(value.whereNonNull.toList()),
        AsyncError(:final error) => MyErrorWidget(error),
        _ => const ScienceClubsViewLoading(),
      },
    );
  }
}

class _ScienceClubsListView extends ConsumerWidget {
  const _ScienceClubsListView(this.filteredCircles);

  final List<SciClub> filteredCircles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (filteredCircles.isEmpty) {
      return Center(
        child: Text(
          context.localize.sci_circle_not_found,
          style: context.textTheme.body,
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: ScienceClubsViewConfig.mediumPadding,
      ),
      gridDelegate: ScienceClubsViewConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ScienceClubCard(filteredCircles[index], () async {
        if (filteredCircles[index].id != null) {
          ref
              .read(navigatorProvider)
              .navigateToScienceClubsDetails(filteredCircles[index].id!);
        }
      }),
    );
  }
}
