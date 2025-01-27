import 'package:bizflow/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bizflow/features/home/home_page.dart';
import 'package:bizflow/features/authentication/presentation/pages/common/forget_password.dart';
import 'package:bizflow/features/authentication/presentation/pages/signup_page.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/core/common/custom_textfield_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool ischecked = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: customColors.bgBackground,
        appBar: AppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedIn) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return MainPage();
                },
              ));
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: CustomText(text: state.message)));
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
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
                          TextFieldSection(
                              validator: (value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                              controller: emailcontroller,
                              title: 'Email',
                              placeholder: 'Enter your email',
                              customColors: customColors),
                          // controller
                          Gap(24.h),

                          TextFieldSection(
                              customColors: customColors,
                              title: 'Password',
                              validator: (value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                              password: true,
                              trailingTapped: () {},
                              trailing: const Icon(Icons.visibility),
                              controller: passwordcontroller,
                              placeholder: 'Enter your password'),
                          Gap(24.h),

                          Row(
                            children: [
                              Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  fillColor: WidgetStatePropertyAll(
                                      customColors.borderSoft),
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
                                          builder: (_) =>
                                              const ForgetPassword()));
                                },
                                child: CustomText(
                                    text: 'Forgot Password?',
                                    myStyle: bodybodysmmedium.copyWith(
                                      color: customColors.fillError,
                                    )),
                              )
                            ],
                          ),
                          Gap(32.h),
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? true) {
                                context.read<AuthCubit>().loginIfVerified(
                                      emailcontroller.text,
                                      passwordcontroller.text,
                                    );
                              }
                            },
                            title: 'Login',
                            busy: state is AuthLoading,
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
                        myStyle: headingheadingsm.copyWith(
                            color: customColors.textDefault),
                      ),
                    ],
                  ).addMargin(EdgeInsets.only(bottom: 32.h, top: 120.h)),
                ],
              ),
            );
          },
        ));
  }
}
