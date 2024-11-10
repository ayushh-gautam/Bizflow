import 'package:bizflow/features/main_page.dart';
import 'package:bizflow/features/authentication/login/presentation/pages/forget_password.dart';
import 'package:bizflow/features/authentication/signup/presentation/pages/create_account.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool ischecked = true;
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customColors.bgBackground,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'Welcome Back!',
                      myStyle: headingheadingxl.copyWith(
                        color: customColors.textDefault,
                      )),
                  Gap(8.h),
                  CustomText(
                    text: 'Please enter your details to continue',
                    myStyle: bodybodymddefault,
                  ),
                  Gap(32.h),
                  CustomText(
                    text: 'Email',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  KTextField(
                    controller: emailcontroller,
                    placeholder: 'Enter your email address',
                  ),
                  // controller

                  Gap(24.h),

                  CustomText(
                    text: 'Password',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),

                  KTextField(
                    controller: passwordcontroller,
                    placeholder: 'Enter your password',
                    trailing: Icon(
                      Icons.visibility,
                      color: customColors.textTeritary,
                    ),
                  ),
                  Gap(24.h),

                  Row(
                    children: [
                      Checkbox(
                          visualDensity: VisualDensity.compact,
                          fillColor:
                              WidgetStatePropertyAll(customColors.borderSoft),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          checkColor: customColors.textDefault,
                          side: BorderSide.none,
                          value: ischecked,
                          onChanged: (value) {
                            setState(() {
                              ischecked = value!;
                            });
                          }),
                      Gap(8.w),
                      CustomText(
                        text: 'Remember Me',
                        myStyle: bodybodysmmedium.copyWith(
                            color: customColors.textDefault),
                      ),
                      Gap(111.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ForgetPassword()));
                        },
                        child: CustomText(
                            text: 'Forgot Password?',
                            myStyle: bodybodysmmedium.copyWith(
                              color: customColors.fillError,
                            )),
                      )
                    ],
                  ),
                  // controller

                  // controller
                  Gap(32.h),

                  CustomButton(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    title: 'Login',
                    titleColor: customColors.brandSecondary!,
                    buttonColor: customColors.brandPrimary!,
                  ),

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
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Don\'t have an account?',
                myStyle: bodybodymddefault.copyWith(
                    color: customColors.textSecondary),
              ),
              CustomText(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateAccount()));
                },
                text: ' Create Now',
                myStyle:
                    headingheadingsm.copyWith(color: customColors.textDefault),
              ),
            ],
          ).addMargin(EdgeInsets.only(bottom: 32.h, top: 120.h)),
        ],
      ),
    );
  }
}
