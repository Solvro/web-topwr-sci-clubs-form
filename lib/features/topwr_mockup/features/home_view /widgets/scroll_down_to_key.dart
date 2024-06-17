import 'package:flutter/material.dart';

class ScrollDownToKey extends StatefulWidget {
  const ScrollDownToKey(
    this.scrollDownToKey, {
    super.key,
    this.delay = Durations.medium1,
    this.duration = const Duration(milliseconds: 500),
    this.alignment = 0.8,
    required this.child,
  });

  final GlobalKey scrollDownToKey;
  final Duration delay;
  final Duration duration;
  final double alignment;
  final Widget child;
  @override
  State<ScrollDownToKey> createState() => _ScrollDownToKeyState();
}

class _ScrollDownToKeyState extends State<ScrollDownToKey> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      Scrollable.ensureVisible(
        widget.scrollDownToKey.currentContext ?? context,
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
