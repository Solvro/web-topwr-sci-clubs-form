import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../paddings.dart";

class BigScrollableSectionPlacehoder extends StatelessWidget {
  const BigScrollableSectionPlacehoder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableLoaderBuilder(
      crossAxisForcedSize: 220,
      mainAxisItemSize: BigPreviewCardConfig.cardWidth,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const MediumLeftPadding(
          child: SizedBox(
            width: BigPreviewCardConfig.cardWidth,
            child: Placeholder(),
          ),
        );
      },
    );
  }
}
