import 'package:flutter/material.dart';

import '../../config/ui_config.dart';
import '../../theme/app_theme.dart';
import 'widgets/loading_widgets/horizontal_rectangular_section_loading.dart';
import 'widgets/logo_app_bar.dart';
import 'widgets/study_circles_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      // const Greeting(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: HorizontalRectangularSectionLoading(),
      ),
      // const ExamSessionCountdown(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: HorizontalRectangularSectionLoading(),
      ),
      // const ParkingSection(),
      // const NewsSection(),
      // const BuildingsSection(),
      const StudyCirclesSection(),
      // const DepartmentSection(),
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
