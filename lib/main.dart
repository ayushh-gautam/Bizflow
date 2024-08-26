import 'package:bizflow/config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/features/login/loginPages/login_page.dart';
import 'package:bizflow/firebase_options.dart';
import 'package:bizflow/multibloc_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/services.dart';

import 'config/themes/dark_theme.dart';
import 'config/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MultiBlocProviderClass(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          
 WidgetsBinding.instance.addPostFrameCallback((_) {
      final isDarkMode = theme.brightness == Brightness.dark;
      SystemChrome.setSystemUIOverlayStyle(
        isDarkMode ? darkSystemUiOverlayStyle : lightSystemUiOverlayStyle,
      );
    });
          return ScreenUtilInit(
            designSize: Size(width, height),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: const LoginPage(),
            ),
          );
        },
      ),
    );
  }
}
