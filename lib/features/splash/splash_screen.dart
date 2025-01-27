// import 'package:bizflow/config/constants/app_color.dart';
// import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
// import 'package:bizflow/features/home/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:bizflow/config/routes/imports.dart';
// import '../authentication/presentation/cubit/auth_cubit.dart';
// import '../authentication/presentation/pages/signup_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late Animation<double> _logoAnimation;
//   late AnimationController _textController;
//   late Animation<Offset> _textAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _logoFinalPositionAnimation;

//   @override
//   void initState() {
//     super.initState();
//     // Logo animation controller
//     _logoController = AnimationController(
//       duration: const Duration(seconds: 15),
//       vsync: this,
//     )..addStatusListener((status) {
//         debugPrint('Logo animation status: $status');
//         if (status == AnimationStatus.completed) {
//           _textController.forward();
//         }
//       });
//     // Text animation controller
//     _textController = AnimationController(
//       duration: const Duration(seconds: 14),
//       vsync: this,
//     );
//     // Logo animation
//     _logoAnimation = Tween<double>(begin: -2.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: Curves.ease,
//       ),
//     );

//     // Logo final position animation
//     _logoFinalPositionAnimation = Tween<double>(begin: 0.0, end: -0.6).animate(
//       CurvedAnimation(
//         parent: _textController,
//         curve: Curves.easeOut,
//       ),
//     );
//     // Text slide animation
//     _textAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: const Offset(0, 0),
//     ).animate(
//       CurvedAnimation(
//         parent: _textController,
//         curve: Curves.ease,
//       ),
//     );
//     // Text fade animation
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _textController,
//         curve: Curves.ease,
//       ),
//     );
//     _logoController.forward();
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthCubit>().checkUserState();

//     return BlocListener<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthLoggedIn) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomePage()),
//             );
//           } else if (state is AuthLoggedOut || state is AuthInitial) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//             );
//           }
//         },
//         child: Scaffold(
//           backgroundColor: AppDarkColor.bgBackground,
//           body: Stack(
//             children: [
//               Center(
//                 child: AnimatedBuilder(
//                   animation:
//                       Listenable.merge([_logoController, _textController]),
//                   builder: (context, child) {
//                     return Align(
//                       alignment: Alignment(
//                           0,
//                           _logoAnimation.value +
//                               _logoFinalPositionAnimation.value),
//                       child: child,
//                     );
//                   },
//                   child: const Object(),
//                 ),
//               ),
//               Positioned(
//                 bottom: 160, // Distance from the bottom
//                 left: 0,
//                 right: 0,
//                 child: SlideTransition(
//                   position: _textAnimation,
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Welcome to Bizflow\nManager',
//                           style: headingheading2xl.copyWith(
//                               color: AppDarkColor.baseWhite),
//                           textAlign: TextAlign.center,
//                         ),
//                         Gap(16.h),
//                         Text(
//                           'Your ultimate tool to manage clients, projects,\nand invoices efficiently.',
//                           style: bodybodysmdefault.copyWith(
//                               color: AppDarkColor.baseWhite),
//                           textAlign: TextAlign.center,
//                         ),
//                         Gap(31.h),
//                         CustomButton(
//                           buttonColor: AppDarkColor.brandPrimary,
//                           title: 'Get Started',
//                           titleColor: AppDarkColor.brandSecondary,
//                           onTap: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const CreateAccount()));
//                           },
//                         ),
//                         Gap(24.h),
//                         CustomButton(
//                           buttonColor: AppDarkColor.borderDefault,
//                           title: 'Explore Demo',
//                           titleColor: AppDarkColor.brandPrimary,
//                         ),
//                         Gap(31.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Have an account?',
//                               style: bodybodymddefault.copyWith(
//                                   color: AppDarkColor.baseWhite),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(context,
//                                     MaterialPageRoute(
//                                   builder: (context) {
//                                     return LoginPage();
//                                   },
//                                 ));
//                               },
//                               child: Text(
//                                 ' Login Now',
//                                 style: headingheadingsm.copyWith(
//                                     color: AppDarkColor.baseWhite),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
//         ));
//   }
// }

// class Object extends StatelessWidget {
//   const Object({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       'assets/logo.png',
//       height: 140,
//     );
//   }
// }

import 'package:bizflow/config/constants/app_color.dart';
import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
import 'package:bizflow/features/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/presentation/cubit/auth_cubit.dart';
import '../authentication/presentation/pages/signup_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _logoFinalPositionAnimation;
  late Animation<Offset> _textAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: -2.0, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.ease),
    );

    _logoFinalPositionAnimation = Tween<double>(begin: 0.0, end: -0.6).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.ease));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.ease),
    );

    // Start the animations
    _logoController.forward().then((_) => _textController.forward());

    // Check the user's authentication state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().checkUserState();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          // Navigate to HomePage if logged in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        } else if (state is AuthLoggedOut || state is AuthInitial) {
          // Navigate to LoginPage if not logged in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppDarkColor.bgBackground,
        body: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_logoController, _textController]),
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(
                      0,
                      _logoAnimation.value + _logoFinalPositionAnimation.value,
                    ),
                    child: child,
                  );
                },
                child: const _Logo(),
              ),
            ),
            Positioned(
              bottom: 160,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _textAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome to Bizflow\nManager',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppDarkColor.baseWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your ultimate tool to manage clients, projects,\n'
                        'and invoices efficiently.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppDarkColor.baseWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 31),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccount()),
                          );
                        },
                        child: const Text('Get Started'),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Explore Demo'),
                      ),
                      const SizedBox(height: 31),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account?',
                            style: TextStyle(color: AppDarkColor.baseWhite),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              ' Login Now',
                              style: TextStyle(
                                color: AppDarkColor.brandPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: 140,
    );
  }
}
