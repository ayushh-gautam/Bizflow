import 'package:bizflow/config/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import '../signup/create_account.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _logoFinalPositionAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _textController.forward();
        }
      });

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Logo animation
    _logoAnimation = Tween<double>(begin: -2.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.bounceIn,
      ),
    );

    // Logo final position animation
    _logoFinalPositionAnimation = Tween<double>(begin: 0.0, end: -0.6).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.ease,
      ),
    );

    // Text slide animation
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.ease,
      ),
    );

    // Text fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.ease,
      ),
    );

    _logoController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDarkColor.bgBackground,
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_logoController, _textController]),
              builder: (context, child) {
                return Align(
                  alignment: Alignment(0,
                      _logoAnimation.value + _logoFinalPositionAnimation.value),
                  child: child,
                );
              },
              child: const Object(),
            ),
          ),
          Positioned(
            bottom: 160, // Distance from the bottom
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
                      style: headingheading2xl,
                      textAlign: TextAlign.center,
                    ),
                    Gap(16.h),
                    Text(
                      'Your ultimate tool to manage clients, projects,\nand invoices efficiently.',
                      style: bodybodysmdefault.copyWith(
                          color: AppDarkColor.baseWhite),
                      textAlign: TextAlign.center,
                    ),
                    Gap(31.h),
                    CustomButton(
                      buttonColor: AppDarkColor.brandPrimary,
                      title: 'Get Started',
                      titleColor: AppDarkColor.brandSecondary,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccount()));
                      },
                    ),
                    Gap(24.h),
                    const CustomButton(
                      buttonColor: AppDarkColor.borderDefault,
                      title: 'Explore Demo',
                      titleColor: AppDarkColor.brandPrimary,
                    ),
                    Gap(31.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: bodybodymddefault.copyWith(
                              color: AppDarkColor.baseWhite),
                        ),
                        Text(
                          ' Login Now',
                          style: headingheadingsm.copyWith(),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }
}

class Object extends StatelessWidget {
  const Object({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: 140,
    );
  }
}
