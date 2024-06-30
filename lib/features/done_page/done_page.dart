import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:separate/separate.dart';

import '../../../config/config.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../auth/widgets/pure_app_bar.dart';
import '../firebase/repositories/sci_clubs_repo.dart';
import '../form/controller/form_widget_controller.dart';
import '../topwr_mockup/widgets/my_text_button.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PureWebAppBar(context),
      body: SingleChildScrollView(
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
                        context.localize.done_page,
                        style: context.greetingTheme.boldTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        context.localize.done_page2,
                        style: context.textTheme.headline,
                        textAlign: TextAlign.justify,
                      ),
                    ].separate(
                      (i, e0, e1) => const SizedBox(height: 15),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 30,
                  children: [
                    _GoBackEditing(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: SvgPicture.asset(UndrawConfig.sent, height: 400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoBackEditing extends ConsumerWidget {
  const _GoBackEditing();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyTextButton(
      isOrange: true,
      actionTitle: context.localize.back_to_edit,
      onClick: () {
        ref.read(formWidgetControllerProvider.notifier).backToEditing();
      },
    );
  }
}
