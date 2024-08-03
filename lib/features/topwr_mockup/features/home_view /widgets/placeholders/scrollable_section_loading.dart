import "package:flutter/cupertino.dart";

import "../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../paddings.dart";

class ScrollableSectionPlaceholder extends StatelessWidget {
  const ScrollableSectionPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    const size = 120.0;

    return ScrollableLoaderBuilder(
      mainAxisItemSize: size,
      crossAxisForcedSize: size,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const MediumLeftPadding(
          child: SizedBox(
            width: size,
            height: size,
            child: Placeholder(),
          ),
        );
      },
    );
  }
}
