import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    // Logger().e(error.toString());
    return switch (error) {
      // ParkingsOfflineException() => const OfflineParkings(),
      // GqlOfflineException(:final ttlKey) => OfflineGraphQLMessage(ttlKey),
      _ => Center(
          child: Text(
            error.toString(),
          ),
        )
    };
  }
}
