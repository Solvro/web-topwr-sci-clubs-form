import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/firebase.dart';
import '../firebase/models/sci_club.dart';
import '../firebase/services/adapter_service.dart';
import '../form/model/form_model.dart';

class CurrentSciClubBuilder extends ConsumerWidget {
  const CurrentSciClubBuilder({this.loader, required this.builder, super.key});
  final Widget Function(BuildContext context, SciClub sciClub) builder;
  final Widget? loader;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterService = ref.watch(adapterServiceProvider);
    return SciClubFormModelFormBuilder(
      builder: (context, formModel, child) {
        return FutureBuilder(
          future: adapterService.fromForm(
            formModel.model,
            FirebaseConfig.secretCurrentAppID,
          ),
          builder: (context, snapshot) => snapshot.data == null
              ? loader ?? const _Loading()
              : builder(context, snapshot.requireData),
        );
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
