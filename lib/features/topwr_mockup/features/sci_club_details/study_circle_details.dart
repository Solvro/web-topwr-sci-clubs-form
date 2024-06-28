import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../firebase/models/sci_club.dart';
import '../../../firebase/repositories/sci_clubs_repo.dart';
import '../../config/ui_config.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../utils/where_non_null_iterable.dart';

import '../../widgets/my_error_widget.dart';
import 'models/contact_section_data.dart';

import 'widgets/details_screen_about_us_section.dart';
import 'widgets/details_screen_app_bar.dart';
import 'widgets/details_screen_contact_section.dart';
import 'widgets/details_screen_sliver_header_section.dart';

class StudyCircleDetails extends StatelessWidget {
  const StudyCircleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            DetailsScreenAppBar(context, title: context.localize.study_circles),
        body: const _CircleDetailsDataView());
  }
}

class _CircleDetailsDataView extends ConsumerWidget {
  const _CircleDetailsDataView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemId = ModalRoute.of(context)?.settings.arguments as String;
    final state = ref.watch(sciClubsRepoProvider.notifier).getClub(itemId);
    return switch (state) {
      null => const MyErrorWidget(null),
      SciClub() => CustomScrollView(slivers: [
          SliverPersistentHeader(
              delegate: SliverHeaderSection(
            logoImageUrl: state.logo,
            backgroundImageUrl: state.cover,
          )),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              Text(
                state.name,
                style: context.textTheme.headline,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Text(
                state.department ?? '',
                style: context.textTheme.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DetailsScreenConfig.spacerHeight),
              ContactSection(
                list: state.socialLinks.whereNonNull
                    .map((a) => ContactSectionData(
                          text: a.name,
                          url: a.url,
                        ))
                    .toList(),
              ),
              const SizedBox(height: DetailsScreenConfig.spacerHeight),
              AboutUsSection(
                text: state.description ?? '',
              )
            ]),
          ),
        ]),
    };
  }
}

// class _StudyCircleDetailsLoading extends StatelessWidget {
//   const _StudyCircleDetailsLoading();

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer(
//       linearGradient: shimmerGradient,
//       child: ListView(
//         physics: const NeverScrollableScrollPhysics(),
//         children: const [
//           HeaderSectionLoading(),
//           SizedBox(height: DetailsScreenConfig.spacerHeight),
//           ContactSectionLoading(),
//           SizedBox(height: DetailsScreenConfig.spacerHeight),
//           AboutUsSectionLoading()
//         ],
//       ),
//     );
//   }
// }
