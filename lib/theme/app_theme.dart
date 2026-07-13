import 'package:flutter/material.dart';

class AppColors {
  static const aqua = Color(0xFF00C6FF);
  static const blue = Color(0xFF0072FF);
  static const mint = Color(0xFF00E0B8);
  static const navy = Color(0xFF0D1B2A);
  static const dark = Color(0xFF07111D);
  static const panel = Color(0xFF11263B);
  static const danger = Color(0xFFFF5F6D);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5FBFF),
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue,
      secondary: AppColors.mint,
      surface: Colors.white,
      error: AppColors.danger,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.aqua,
      secondary: AppColors.mint,
      surface: AppColors.panel,
      error: AppColors.danger,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.panel,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
  );
}
