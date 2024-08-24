import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart";

class ScienceClubsViewLoading extends StatelessWidget {
  const ScienceClubsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: ScienceClubsViewConfig.researchGroupTabGridDelegate,
      itemBuilder: (context, index) => const WideTileLoading(),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
