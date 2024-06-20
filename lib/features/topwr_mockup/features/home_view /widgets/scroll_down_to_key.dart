import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollDownKey = Provider.autoDispose((ref) => GlobalKey());

class ScrollDownToKey extends ConsumerStatefulWidget {
  const ScrollDownToKey({
    super.key,
    this.delay = Durations.extralong4,
    this.duration = const Duration(milliseconds: 500),
    this.alignment = 0.8,
    required this.child,
  });

  final Duration delay;
  final Duration duration;
  final double alignment;
  final Widget child;
  @override
  ConsumerState<ScrollDownToKey> createState() => _ScrollDownToKeyState();
}

class _ScrollDownToKeyState extends ConsumerState<ScrollDownToKey> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      Scrollable.ensureVisible(
        ref.read(scrollDownKey).currentContext ?? context,
        alignment: widget.alignment,
        duration: widget.duration,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
