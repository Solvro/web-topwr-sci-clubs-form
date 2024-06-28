import 'package:flutter/material.dart';

import '../../../../firebase/models/sci_club.dart';
import '../../../config/ui_config.dart';

import '../../../widgets/my_cached_image.dart';
import '../../../widgets/wide_tile_card.dart';

class ResearchGroupCard extends StatelessWidget {
  final SciClub sciCircle;
  final VoidCallback? onTap;
  const ResearchGroupCard(this.sciCircle, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      isActive: false,
      title: sciCircle.name,
      subtitle: sciCircle.department ?? "",
      onTap: onTap,
      secondSubtitle: sciCircle.tags.map((tag) => '#$tag').toList().join(', '),
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(
            right: ScientificCircleCardConfig.trailingPadding,
            top: ScientificCircleCardConfig.trailingPadding,
            bottom: ScientificCircleCardConfig.trailingPadding),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: WideTileCardConfig.radius,
                  bottomRight: WideTileCardConfig.radius),
            ),
            child: MyCachedImage(
              sciCircle.logo,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
