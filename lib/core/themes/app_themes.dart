import 'package:flutter/material.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primarySeed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(17),
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
      displayMedium: TextStyle(
        fontSize: 13,
        color: Colors.green.shade400,
        fontWeight:FontWeight.w800,
      ),

      // Use bodyMedium for standard paragraph text
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
      // Use labelSmall for utility or caption text
      labelSmall: TextStyle(fontSize: 12, color: Colors.grey),
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarySeed),
    brightness: Brightness.dark,
  );
}
