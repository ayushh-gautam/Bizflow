import 'package:bizflow/config/themes/themeExtension/theme_extension.dart';
import 'package:bizflow/core/constants/app_color.dart';
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppDarkColor.bgBackground,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppDarkColor.bgBackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppDarkColor.textDefault,
      unselectedItemColor: AppDarkColor.textSecondary,
      
      showUnselectedLabels: true),
  appBarTheme: const AppBarTheme(
      color: AppDarkColor.bgBackground,
      surfaceTintColor: AppDarkColor.bgBackground),
  extensions: [AppColors.dark],
);
