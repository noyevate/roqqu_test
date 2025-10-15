import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.accentBlue,
      
      // Define the default font family.
      // fontFamily: 'YourFontFamily', // Add your custom font here

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryText),
        titleTextStyle: TextStyle(
          color: AppColors.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      textTheme: const TextTheme(
        // For large titles like "Do less, Win more"
        displayLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        // For subtitles
        bodyLarge: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 16,
          height: 1.5,
        ),
        // For button text
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}