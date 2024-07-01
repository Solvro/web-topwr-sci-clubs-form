import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:separate/separate.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/launch_url_util.dart';
import '../../topwr_mockup/widgets/my_text_button.dart';
import 'pure_app_bar.dart';

class WrongUrlPage extends ConsumerWidget {
  const WrongUrlPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PureWebAppBar(context),
      body: SizedBox(
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
                      context.localize.wrong_link,
                      style: context.greetingTheme.boldTextStyle,
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      context.localize.wrong_link_desc,
                      style: context.textTheme.headline,
                      textAlign: TextAlign.justify,
                    ),
                  ].separate(
                    (i, e0, e1) => const SizedBox(height: 15),
                  ),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 30,
              children: [
                MyTextButton(
                  isOrange: true,
                  actionTitle: context.localize.contact_landing,
                  onClick: () {
                    LaunchUrlUtil.launch(GuestPageConfig.contactLink);
                  },
                ),
                MyTextButton(
                  isOrange: true,
                  icon: Icons.mail,
                  actionTitle: context.localize.write_email,
                  onClick: () {
                    LaunchUrlUtil.launch(GuestPageConfig.solvroMailLink);
                  },
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: const Alignment(0, -0.6),
                child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 600, minHeight: 10),
                  padding: const EdgeInsets.all(40.0),
                  child: SvgPicture.asset(UndrawConfig.wrong),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
