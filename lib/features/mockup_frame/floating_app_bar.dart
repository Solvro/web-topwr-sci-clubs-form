import 'package:flutter/material.dart';

import 'breakpoint.dart';

class FloatingAppBarScaffold extends StatelessWidget {
  const FloatingAppBarScaffold({
    super.key,
    required this.appBar,
    required this.child,
  });

  final AppBar appBar;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBarWrapper(
          appBar,
          floating: !context.showSplitView,
          pinned: context.showSplitView,
        ),
        SliverToBoxAdapter(child: child),
      ],
    );
  }
}

class SliverAppBarWrapper extends SliverAppBar {
  SliverAppBarWrapper(AppBar appBar, {super.key, super.pinned, super.floating})
      : super(
          actions: appBar.actions,
          primary: appBar.primary,
          leading: appBar.leading,
          elevation: appBar.elevation,
          backgroundColor: appBar.backgroundColor,
          title: appBar.title,
          centerTitle: appBar.centerTitle,
          scrolledUnderElevation: appBar.scrolledUnderElevation,
          automaticallyImplyLeading: appBar.automaticallyImplyLeading,
          titleSpacing: appBar.titleSpacing,
        );
}
