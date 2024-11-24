import 'package:bizflow/core/common/custom_textfield_section.dart';
import 'package:bizflow/features/authentication/login/presentation/pages/login_page.dart';
import 'package:bizflow/features/authentication/signup/presentation/pages/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bizflow/config/routes/imports.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    final TextEditingController namecontroller = TextEditingController();
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'Create an Account',
                      myStyle: headingheadingxl.copyWith(
                        color: customColors.textDefault,
                      )),
                  Gap(8.h),
                  CustomText(
                    text: 'Let\'s create your account to get started.',
                    myStyle: bodybodymddefault.copyWith(
                        color: customColors.textSecondary),
                  ),
                  Gap(32.h),
                  TextFieldSection(
                      customColors: customColors,
                      title: 'Full Name',
                      controller: namecontroller,
                      placeholder: 'e.g: Sample Name'),
                  Gap(24.h),
                  TextFieldSection(
                      customColors: customColors,
                      title: 'Email',
                      controller: emailcontroller,
                      placeholder: 'samplegmail.com'),
                  Gap(24.h),
                  TextFieldSection(
                      customColors: customColors,
                      title: 'Password',
                      controller: passwordcontroller,
                      password: true,
                      trailingTapped: () {},
                      trailing: const Icon(Icons.visibility),
                      placeholder: 'Enter your password'),
                  Gap(24.h),
                  CustomButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OtpPage()));
                      },
                      title: 'Sign Up',
                      titleColor: customColors.brandSecondary!,
                      buttonColor: customColors.brandPrimary!),
                  Gap(24.h),
                  CustomButton(
                      leading: SvgPicture.asset(
                        SvgAsset.google,
                        height: 24.h,
                      ),
                      title: 'Continue with Google',
                      titleColor: customColors.brandPrimary!,
                      buttonColor: customColors.bgTeritary!),
                  //button
                ],
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Have an account?',
                myStyle: bodybodymddefault,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: CustomText(
                  text: ' Login Now',
                  myStyle: headingheadingsm.copyWith(
                      color: customColors.textDefault),
                ),
              )
            ],
          ).addMargin(EdgeInsets.only(bottom: 32.h)),
        ],
      ),
    );
  }
}
