import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/determine_icon.dart";
import "../../../../utils/where_non_null_iterable.dart";
import "../../../current_sci_club/curr_sci_club_builder.dart";
import "../../../firebase/models/sci_club.dart";
import "../../../firebase/repositories/sci_clubs_repo.dart";
import "../../../form/model/form_model.dart";
import "../../config/ui_config.dart";
import "widgets/details_screen_about_us_section.dart";
import "widgets/details_screen_app_bar.dart";
import "widgets/details_screen_contact_section.dart";
import "widgets/details_screen_sliver_header_section.dart";

class StudyCircleDetails extends StatelessWidget {
  const StudyCircleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          DetailsScreenAppBar(context, title: context.localize.study_circles),
      body: const _CircleDetailsDataView(),
    );
  }
}

class _CircleDetailsDataView extends ConsumerWidget {
  const _CircleDetailsDataView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CurrentSciClubBuilder(
      builder: (context, sciClub) {
        final itemId = ModalRoute.of(context)!.settings.arguments! as String;
        final state = ref.watch(sciClubsRepoProvider.notifier).getClub(itemId);
        return switch (state) {
          null => _ViewWidget(sciClub),
          SciClub() => _ViewWidget(state.id == sciClub.id ? sciClub : state),
        };
      },
    );
  }
}

class _ViewWidget extends StatelessWidget {
  const _ViewWidget(this.state);

  final SciClub state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: SliverHeaderSection(
            logoImageUrl: state.logo?.url,
            backgroundImageUrl: state.cover?.url,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                state.name ?? context.localize.default_name,
                style: context.textTheme.headline,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.department ?? "",
              style: context.textTheme.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DetailsScreenConfig.spacerHeight),
            ContactSection(
              list: state.socialLinks.whereNonNull
                  .map(
                    (a) => ContactIconsModel(
                      text: a.name,
                      url: (a.url != null &&
                              a.url!.isUrlEmail &&
                              !a.url!.startsWith(FormConfig.mailto))
                          ? FormConfig.mailto + a.url!
                          : a.url,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: DetailsScreenConfig.spacerHeight),
            AboutUsSection(
              text: state.description ?? "",
            ),
          ]),
        ),
      ],
    );
  }
}
