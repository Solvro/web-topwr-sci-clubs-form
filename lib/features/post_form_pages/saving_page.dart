import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:separate/separate.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../auth/widgets/pure_app_bar.dart';
import '../form/controller/form_widget_controller.dart';
import '../topwr_mockup/widgets/my_text_button.dart';

class SavingPage extends StatelessWidget {
  const SavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PureWebAppBar(context),
      body: Align(
        alignment: const Alignment(0, -0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              context.localize.saving,
              style: context.greetingTheme.boldTextStyle,
              textAlign: TextAlign.justify,
            ),
            const CircularProgressIndicator(),
            Text(
              context.localize.wait_here,
              style: context.textTheme.headline,
              textAlign: TextAlign.justify,
            ),
          ].separate(
            (i, e0, e1) => const SizedBox(height: 60),
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
