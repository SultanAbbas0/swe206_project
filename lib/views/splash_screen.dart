import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/loading_indicator.dart';
import 'package:swe206_project/views/landing_screen.dart';
import 'package:swe206_project/views/navigation_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) =>
          user != null ? const NavigationScreen() : const LandingScreen(),
      loading: () => const Scaffold(
        body: Center(child: CustomCircularProgressIndicator()),
      ),
      error: (_, __) => const LandingScreen(),
    );
  }
}
