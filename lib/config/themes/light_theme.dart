import 'package:bizflow/config/themes/themeExtension/theme_extension.dart';
import 'package:bizflow/core/constants/app_color.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: AppLightColor.bgBackground,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppLightColor.bgBackground,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppLightColor.textDefault,
    unselectedItemColor: AppLightColor.textSecondary,
    showUnselectedLabels: true,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppLightColor.bgBackground,
    surfaceTintColor: AppLightColor.bgBackground,
  ),
  brightness: Brightness.light,
  extensions: const [AppColors.light],
);






















//  ThemeData(

//     useMaterial3: true,
    
  
//     scaffoldBackgroundColor: AppLightColor.bgBackground,
//     primaryColor: AppLightColor.brandPrimary,
    




//     colorScheme: const ColorScheme.light(
//       secondary: AppLightColor.bgSecondary,
//       tertiary: AppLightColor.bgTeritary,
//       surface: AppLightColor.surfaceSuccess,
      
//     ),
//     elevatedButtonTheme: const ElevatedButtonThemeData(
//         style:
//             ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red))));
