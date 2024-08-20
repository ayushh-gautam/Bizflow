import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';


class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Verify OTP',
            myStyle: headingheadingxl.copyWith(color: customColors.textDefault),
          ),
          Gap(8.h),
          CustomText(
            text:
                'We just sent a verification code to your email\nsample@gmail.com',
            myStyle:
                bodybodymddefault.copyWith(color: customColors.textSecondary),
          ),
          Gap(32.h),
          CustomTextField(
            controller: emailController,
            placeholder: 'Enter Code',
          ),
          Gap(32.h),
          CustomButton(
              title: 'Continue',
              titleColor: customColors.brandSecondary!,
              buttonColor: customColors.brandPrimary!),
          Gap(32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Didn\'t receive a code?',
                myStyle: bodybodymddefault.copyWith(
                    color: customColors.textSecondary),
              ),
              CustomText(
                text: ' Resend Code',
                myStyle:
                    headingheadingsm.copyWith(color: customColors.textDefault),
              )
            ],
          )
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }
}
