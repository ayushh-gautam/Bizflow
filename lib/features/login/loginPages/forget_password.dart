import 'package:bizflow/features/login/loginPages/code.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import '../../../core/constants/app_color.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Forgot Your Password?',
            myStyle:
                headingheadingxl.copyWith(color: AppDarkColor.brandSecondary),
          ),
          Gap(8.h),
         const  CustomText(
              text:
                  'Enter your email address and we\'ll send you\ncode to reset your password.'),
          Gap(32.h),
          CustomTextField(
            controller: emailController,
            placeholder: 'Enter your email address',
          ),
          Gap(32.h),
          CustomButton(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (cxt) => Code()));
              },
              title: 'Send Code',
              titleColor: AppLightColor.primaryColor,
              buttonColor: AppLightColor.brandPrimary),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }
}
