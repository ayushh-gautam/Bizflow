import 'package:bizflow/config/themes/themeExtension/theme_extension.dart';
import 'package:bizflow/config/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



SystemUiOverlayStyle darkSystemUiOverlayStyle = const SystemUiOverlayStyle(
  statusBarColor: AppDarkColor.bgBackground,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: AppDarkColor.bgBackground,
  systemNavigationBarIconBrightness: Brightness.light,
);

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
  extensions: const [AppColors.dark],
);
