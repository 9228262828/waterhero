import 'package:flutter/material.dart';
import 'features/home_screen.dart';
import 'features/onboarding_screen.dart';
import 'state/app_controller.dart';
import 'state/app_scope.dart';
import 'theme/app_theme.dart';

class WaterHeroApp extends StatelessWidget {
  const WaterHeroApp({super.key, required this.controller});
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: controller,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WaterHero',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: controller.settings.themeMode,
          home: controller.settings.onboardingCompleted
              ? const HomeScreen()
              : const OnboardingScreen(),
        ),
      ),
    );
  }
}
