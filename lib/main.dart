import 'package:bizflow/config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/features/splash/presentation/pages/splash_screen.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProviderClass(
      //deployyment
      BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final isDarkMode = theme.brightness == Brightness.dark;
            SystemChrome.setSystemUIOverlayStyle(
              isDarkMode ? darkSystemUiOverlayStyle : lightSystemUiOverlayStyle,
            );
          });
          return ScreenUtilInit(
            designSize: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
