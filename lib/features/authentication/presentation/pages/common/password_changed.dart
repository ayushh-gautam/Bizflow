import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bizflow/config/routes/imports.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

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
              text: 'Password Reset Succesfully',
              myStyle:
                  headingheadingxl.copyWith(color: customColors.textDefault),
            ),
            Gap(8.h),
            CustomText(
              textAlign: TextAlign.center,
              text:
                  'Your password has been updated\nsuccessfully. You can now log in with\nyour new password.',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(32.h),
            CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                title: 'Login Now',
                titleColor: customColors.brandSecondary!,
                buttonColor: customColors.brandPrimary!),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
      ),
    );
  }
}
