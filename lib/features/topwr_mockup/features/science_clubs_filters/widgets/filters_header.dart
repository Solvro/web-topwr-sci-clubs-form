import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../theme/utils.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../widgets/subsection_header.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../utils.dart";
import "line_handle.dart";

class FiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LineHandle(),
        Center(
          child: Theme(
            data: context.defaultThemeWithOverrideTextStyles(
              boldBodyOrange: context.textTheme.titleOrange,
              boldBody: context.textTheme.title,
            ), // for text button font
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, child) => SubsectionHeader(
                    rightPadding: 24,
                    title: context.localize.filters,
                    actionTitle: context.localize.clear,
                    addArrow: false,
                    onClick: ref.watch(areFiltersEnabledProvider) ||
                            ref.watch(searchFiltersControllerProvider.notEmpty)
                        ? ref.getClearAllFilters(ref)
                        : null,
                  ),
                ),
                // const FiltersSearch(), // I need Stack cause the this lib is terribly made and it's my last hope to make it anything close to what I need
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
