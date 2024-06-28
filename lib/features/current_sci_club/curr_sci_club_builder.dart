import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/firebase.dart';
import '../firebase/models/sci_club.dart';
import '../firebase/services/adapter_service.dart';
import '../form/model/form_model.dart';
import 'utils/temp_image_url.dart';

class CurrentSciClubBuilder extends ConsumerStatefulWidget {
  const CurrentSciClubBuilder({this.loader, required this.builder, super.key});
  final Widget Function(BuildContext context, SciClub sciClub) builder;
  final Widget? loader;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CurrentSciClubBuilderState();
}

class _CurrentSciClubBuilderState extends ConsumerState<CurrentSciClubBuilder> {
  SciClub? model;

  @override
  void dispose() {
    super.dispose();
    TempImageUrl.revokeUrl(model?.logo);
    TempImageUrl.revokeUrl(model?.cover);
  }

  @override
  Widget build(BuildContext context) {
    final adapterService = ref.watch(adapterServiceProvider);
    return ReactiveSciClubFormModelFormConsumer(
      builder: (context, formModel, child) {
        return FutureBuilder(
            future: adapterService.fromFormToLocal(
              formModel.model,
              FirebaseConfig.secretCurrentAppID,
            ),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return widget.loader ?? const _Loading();
              }
              model = snapshot.requireData;
              return widget.builder(context, snapshot.requireData);
            });
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
