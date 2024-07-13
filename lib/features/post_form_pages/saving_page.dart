import 'package:flutter/material.dart';
import 'package:separate/separate.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../auth/widgets/pure_app_bar.dart';

class SavingPage extends StatelessWidget {
  const SavingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PureWebAppBar(context),
      body: Align(
        alignment: const Alignment(0, -0.5),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
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
      ),
    );
  }
}
