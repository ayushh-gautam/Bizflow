import 'package:bizflow/features/authentication/presentation/pages/common/change_password.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:bizflow/config/routes/imports.dart';
import '../../../../../config/constants/app_color.dart';

class Code extends StatelessWidget {
  const Code({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Verify OTP',
            myStyle:
                headingheadingxl.copyWith(color: AppDarkColor.brandSecondary),
          ),
          Gap(8.h),
          const CustomText(
              text:
                  'We just sent a verification code to your email\nsample@gmail.com'),
          Gap(32.h),
          const Center(child: Pinput()),
          Gap(32.h),
          CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()));
              },
              title: 'Continue',
              titleColor: AppLightColor.primaryColor,
              buttonColor: AppLightColor.brandPrimary),
          Gap(32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Didn\'t receive a code?',
                myStyle: bodybodymddefault,
              ),
              CustomText(
                text: ' Resend Code',
                myStyle: headingheadingsm.copyWith(
                    color: AppLightColor.brandPrimary),
              )
            ],
          )
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
    );
  }
}
