import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../current_sci_club/curr_sci_club_builder.dart';
import '../../../firebase/models/sci_club.dart';
import '../../config/ui_config.dart';
import '../../widgets/my_error_widget.dart';
import '../navigator/navigator/detail_view_navigator.dart';
import '../navigator/navigator/nested_navigator.dart';
import 'controller/scientific_circles_tab_controller.dart';
import 'widgets/scientific_circle_card.dart';
import 'widgets/scientific_circle_loading.dart';

class ScientificCirclesList extends ConsumerWidget {
  const ScientificCirclesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scientificCircleListProvider);

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: ScientificCirclesTabConfig.mediumPadding),
            child: switch (state) {
              AsyncLoading() => const ScientificCirclesLoading(),
              AsyncError(:final error) => MyErrorWidget(error),
              AsyncValue(:final value) => CurrentSciClubBuilder(
                  loader: const ScientificCirclesLoading(),
                  builder: (context, sciClub) => _ScientificCirclesDataView(
                    [
                      sciClub,
                      ...value.whereNonNull.where(
                        (element) => element.id != sciClub.id,
                      )
                    ],
                  ),
                ),
            }));
  }
}

class _ScientificCirclesDataView extends ConsumerWidget {
  const _ScientificCirclesDataView(this.filteredCircles);

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
          bottom: ScientificCirclesTabConfig.mediumPadding),
      gridDelegate: ScientificCirclesTabConfig.researchGroupTabGridDelegate,
      itemCount: filteredCircles.length,
      itemBuilder: (context, index) =>
          ResearchGroupCard(filteredCircles[index], () {
        if (filteredCircles[index].id != null) {
          ref
              .read(navigatorProvider)
              .navigateToStudyCircleDetails(filteredCircles[index].id!);
        }
      }),
    );
  }
}
