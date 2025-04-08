import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/mail.svg',
              height: 98.h,
              width: 96.h,
            ),
            Gap(52.18.h),
            CustomText(
              text: 'Password Reset Email Successfully',
              myStyle:
                  headingheadingxl.copyWith(color: customColors.textDefault),
            ),
            Gap(8.h),
            CustomText(
              textAlign: TextAlign.center,
              text: 'Your password reset email has been sent \nsuccessfully.',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(32.h),
            CustomButton(
              onTap: () async {
                final Uri url = Uri.parse('https://mail.google.com/');
                try {
                  bool launched = await launchUrl(
                    url,
                    mode: LaunchMode.inAppBrowserView,
                  );
                  if (!launched) {
                    throw 'Could not launch Gmail';
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to open Gmail: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              title: "Open Gmail",
              titleColor: customColors.brandSecondary!,
              buttonColor: customColors.brandPrimary!,
            ),
            Gap(32.h),
            CustomButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              title: 'Login Now',
              titleColor: customColors.brandSecondary!,
              buttonColor: customColors.brandPrimary!,
            ),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
      ),
    );
  }
}
