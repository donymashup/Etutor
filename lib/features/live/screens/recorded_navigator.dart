import 'package:etutor/features/live/screens/recorded_years_screen.dart';
import 'package:flutter/material.dart';

class RecordedNavigator extends StatelessWidget {
  const RecordedNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: navigatorKey, // ✅ Separate from main app navigator
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => const RecordedYearsScreen(),
          );
        },
      ),
    );
  }
}

