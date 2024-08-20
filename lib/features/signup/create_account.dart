import 'package:bizflow/features/login/loginPages/login_page.dart';
import 'package:bizflow/features/signup/otp_page.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
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
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(32.h),
            CustomText(
              text: 'Full Name',
              myStyle:
                  bodybodymdmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(4.h),
            CustomTextField(
              controller: namecontroller,
              placeholder: 'eg. Ayush',
            ),
            // controller

            Gap(24.h),

            CustomText(
              text: 'Email',
              myStyle:
                  bodybodymdmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(4.h),

            CustomTextField(
              controller: emailcontroller,
              placeholder: 'sample@gmail.com',
            ),

            // controller

            Gap(24.h),

            Text(
              'Password',
              style: bodybodymdmedium.copyWith(color: customColors.textDefault),
            ),

            Gap(4.h),
            CustomTextField(
              controller: passwordcontroller,
              placeholder: 'Enter your password',
              password: true,
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.visibility,
                    color: customColors.textTeritary,
                  )),
            ),

            // controller
            Gap(24.h),
            CustomButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const OtpPage()));
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
            ).addMargin(EdgeInsets.only(bottom: 32.h, top: 120.h)),

            //button
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
      ),
    );
  }
}
