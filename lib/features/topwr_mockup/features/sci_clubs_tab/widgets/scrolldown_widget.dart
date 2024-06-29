import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../form/model/form_model.dart';

class ScrollUpSciClubList extends StatelessWidget {
  const ScrollUpSciClubList({super.key, required this.builder});
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;
  @override
  Widget build(BuildContext context) {
    return _ScrollUpSciClubList(
      ReactiveSciClubFormModelForm.of(context, listen: false),
      builder: builder,
    );
  }
}

class _ScrollUpSciClubList extends ConsumerStatefulWidget {
  const _ScrollUpSciClubList(this.form, {required this.builder});
  final SciClubFormModelForm? form;
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScrollDownSciClubListState();
}

class _ScrollDownSciClubListState extends ConsumerState<_ScrollUpSciClubList> {
  StreamSubscription<Map<String, Object?>?>? subscryption;
  final scrollController = ScrollController();

  @override
  void dispose() {
    subscryption?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(
      Durations.medium4,
      () {
        subscryption = widget.form?.form.valueChanges.listen(
          (event) => scrollController.animateTo(
            0,
            duration: Durations.medium2,
            curve: Curves.decelerate,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, scrollController);
  }
}
