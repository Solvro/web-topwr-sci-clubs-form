import "package:flutter/material.dart";

import "../../../../../config/config.dart";
import "../../../../firebase/models/sci_club.dart";
import "../../../config/ui_config.dart";
import "../../../widgets/my_cached_image.dart";
import "../../../widgets/wide_tile_card.dart";

class ScienceClubCard extends StatelessWidget {
  final SciClub sciClub;
  final VoidCallback? onTap;

  const ScienceClubCard(this.sciClub, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      title: sciClub.name ?? "",
      subtitle: sciClub.department,
      onTap: onTap,
      secondSubtitle: sciClub.tags.map((tag) => "#$tag").toList().join(", "),
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(
          right: ScienceClubCardConfig.trailingPadding,
          top: ScienceClubCardConfig.trailingPadding,
          bottom: ScienceClubCardConfig.trailingPadding,
        ),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: WideTileCardConfig.radius,
                bottomRight: WideTileCardConfig.radius,
              ),
            ),
            child: MyCachedImage(
              sciClub.logo?.url ?? "",
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
