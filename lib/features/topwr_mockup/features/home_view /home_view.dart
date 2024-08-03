import "dart:async";

import "package:flutter/material.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../form/model/form_model.dart";
import "../../config/nav_bar_config.dart";
import "../../config/ui_config.dart";
import "widgets/logo_app_bar.dart";
import "widgets/placeholders/horizontal_placeholder.dart";
import "widgets/placeholders/subsection_placeholder.dart";
import "widgets/study_circles_section.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeView(ReactiveSciClubFormModelForm.of(context, listen: false));
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView(this.form);
  final SciClubFormModelForm? form;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final itemScrollController = ItemScrollController();
  late final studyCirclesSections = const StudyCirclesSection();
  late final List<Widget> sections = [
    const HorizontalPlaceholder(),
    const HorizontalPlaceholder(),
    SubsectionPlaceholder(
      title: context.localize.parkings_title,
      isMapActionString: true,
      tabDestination: NavBarEnum.parkings,
    ),
    SubsectionPlaceholder(
      title: context.localize.whats_up,
      big: true,
      tabDestination: NavBarEnum.info,
    ),
    SubsectionPlaceholder(
      title: context.localize.buildings_title,
      isMapActionString: true,
      tabDestination: NavBarEnum.mapp,
    ),
    studyCirclesSections,
    SubsectionPlaceholder(
      title: context.localize.departments,
      tabDestination: NavBarEnum.faculties,
    ),
  ];

  StreamSubscription<Map<String, Object?>?>? subscryption;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Durations.medium4,
      () {
        unawaited(scrollDownToTarget());
        subscryption = widget.form?.form.valueChanges.listen(
          (event) async => scrollDownToTarget(),
        );
      },
    );
  }

  @override
  void dispose() {
    unawaited(subscryption?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: LogoAppBar(context),
      body: ScrollablePositionedList.separated(
        itemScrollController: itemScrollController,
        padding: const EdgeInsets.only(bottom: 48),
        itemCount: sections.length,
        itemBuilder: (BuildContext context, int index) => sections[index],
        separatorBuilder: (context, index) =>
            const SizedBox(height: HomeScreenConfig.paddingMedium),
      ),
    );
  }

  Future<void> scrollDownToTarget() async {
    if (itemScrollController.isAttached) {
      await itemScrollController.scrollTo(
        index: sections.indexOf(studyCirclesSections),
        duration: Durations.medium4,
        alignment: 0.01,
        curve: Curves.decelerate,
      );
    }
  }
}
