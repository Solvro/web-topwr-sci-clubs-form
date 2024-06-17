import 'package:flutter/material.dart';

import '../../config/nav_bar_config.dart';
import '../../config/ui_config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import 'widgets/logo_app_bar.dart';
import 'widgets/placeholders/subsection_placeholder.dart';
import 'widgets/study_circles_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollDownToKey = GlobalKey();

    Future.delayed(Durations.medium1, () {
      Scrollable.ensureVisible(
        scrollDownToKey.currentContext ?? context,
        alignment: 0.8,
        duration: const Duration(milliseconds: 500),
      );
    });

    final List<Widget> sections = [
      // const Greeting(),
      const HorizontalPlaceholder(),
      // const ExamSessionCountdown(),
      const HorizontalPlaceholder(),
      // const ParkingSection(),
      SubsectionPlaceholder(
        title: context.localize.parkings_title,
        isMapActionString: true,
        tabDestination: NavBarEnum.parkings,
      ),
      // const NewsSection(),
      SubsectionPlaceholder(
        title: context.localize.whats_up,
        big: true,
        tabDestination: NavBarEnum.info,
      ),
      // const BuildingsSection(),
      SubsectionPlaceholder(
        title: context.localize.buildings_title,
        isMapActionString: true,
        tabDestination: NavBarEnum.mapp,
      ),
      StudyCirclesSection(
        key: scrollDownToKey,
      ),
      // const DepartmentSection(),
      SubsectionPlaceholder(
        title: context.localize.departments,
        tabDestination: NavBarEnum.faculties,
      ),
    ];
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 48),
        itemBuilder: (context, index) => sections[index],
        separatorBuilder: (context, index) =>
            const SizedBox(height: HomeScreenConfig.paddingMedium),
        itemCount: sections.length,
      ),
    );
  }
}

class HorizontalPlaceholder extends StatelessWidget {
  const HorizontalPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 69,
        child: Placeholder(),
      ),
    );
  }
}
