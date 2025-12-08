import 'package:flutter/material.dart';
import 'package:supreme/core/constants/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primarySeed,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
    brightness: Brightness.dark,
  );
}
