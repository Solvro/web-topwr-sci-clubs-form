import 'package:flutter/material.dart';
import 'package:separate/separate.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/launch_url_util.dart';
import '../../form/widgets/my_outline_button.dart';
import '../../mockup_frame/floating_app_bar.dart';
import '../../topwr_mockup/widgets/my_text_button.dart';
import 'pure_app_bar.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingAppBarScaffold(
        appBar: PureWebAppBar(context),
        child: SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          context.localize.guest_page,
                          style: context.greetingTheme.boldTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          context.localize.guest_page2,
                          style: context.textTheme.headline,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          context.localize.guest_page3,
                          style: context.textTheme.headline,
                          textAlign: TextAlign.justify,
                        ),
                      ].separate(
                        (i, e0, e1) => const SizedBox(height: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 30,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      MyTextButton(
                        isOrange: false,
                        actionTitle: context.localize.read_more_landing,
                        onClick: () {
                          LaunchUrlUtil.launch(GuestPageConfig.portfolioLink);
                        },
                      ),
                      MyOutlineButton(
                        isOrange: true,
                        actionTitle: context.localize.contact_landing,
                        onClick: () {
                          LaunchUrlUtil.launch(GuestPageConfig.contactLink);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset(GuestPageConfig.landingPng),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
