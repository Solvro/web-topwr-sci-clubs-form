import "package:flutter/material.dart";

class HorizontalPlaceholder extends StatelessWidget {
  const HorizontalPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 69,
        child: Placeholder(),
      ),
    );
  }
}
