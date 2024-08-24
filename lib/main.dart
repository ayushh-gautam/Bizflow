import 'package:bizflow/config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/features/login/loginPages/login_page.dart';
import 'package:bizflow/firebase_options.dart';
import 'package:bizflow/multibloc_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/services.dart';

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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              // theme: ThemeData.dark(),
              theme: theme,

              home: const LoginPage(),
            ),
          );
        },
      ),
    );
  }
}
