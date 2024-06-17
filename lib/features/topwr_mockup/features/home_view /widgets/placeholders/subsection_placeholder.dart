import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/nav_bar_config.dart';
import '../../../../../../utils/context_extensions.dart';
import '../../../../widgets/subsection_header.dart';
import '../../../navigator/navigator/nested_navigator.dart';
import '../../../navigator/navigator/tab_bar_navigator.dart';
import 'big_scrollable_section_placeholder.dart';
import 'scrollable_section_loading.dart';

class SubsectionPlaceholder extends ConsumerWidget {
  const SubsectionPlaceholder({
    this.big = false,
    this.isMapActionString = false,
    required this.title,
    required this.tabDestination,
    super.key,
  });
  final bool big;
  final bool isMapActionString;
  final String title;
  final NavBarEnum tabDestination;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SubsectionHeader(
            title: title,
            actionTitle: isMapActionString
                ? context.localize.map_button
                : context.localize.list,
            onClick: () {
              ref.read(navigatorProvider).changeTabBar(tabDestination);
            }),
        big
            ? const BigScrollableSectionPlacehoder()
            : const ScrollableSectionPlaceholder()
      ],
    );
  }
}
