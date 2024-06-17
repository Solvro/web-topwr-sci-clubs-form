import 'package:flutter/material.dart';
import 'package:topwr_sci_clubs_form/theme/app_theme.dart';
import 'package:topwr_sci_clubs_form/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          extensions: const [AppTheme()],
          colorScheme: const ColorScheme.light().copyWith(
            surface: ColorsConsts.whiteSoap,
          )),
      home: const Placeholder(),
    );
  }
}
