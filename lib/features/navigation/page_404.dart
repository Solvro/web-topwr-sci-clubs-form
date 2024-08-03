import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../config/config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../auth/widgets/pure_app_bar.dart";
import "../topwr_mockup/widgets/my_text_button.dart";
import "router.dart";

@RoutePage()
class Page404View extends StatelessWidget {
  const Page404View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PureWebAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                context.localize.text404,
                style: context.greetingTheme.boldTextStyle,
                textAlign: TextAlign.justify,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: MyTextButton(
                  actionTitle: context.localize.take_me_home,
                  onClick: () async {
                    unawaited(context.router.navigate(const RootRoute()));
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(0, -0.6),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 400, minHeight: 10),
                    padding: const EdgeInsets.all(40),
                    child: SvgPicture.asset(
                      UndrawConfig.p404,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
