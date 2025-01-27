import 'package:bizflow/config/core/common/custom_textfield_section.dart';
import 'package:bizflow/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bizflow/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter_svg/svg.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthVerificationSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'A verification email has been sent to your email. Please verify your email to complete the signup process.',
                ),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
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
                          ),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: 'Let\'s create your account to get started.',
                          myStyle: bodybodymddefault.copyWith(
                            color: customColors.textSecondary,
                          ),
                        ),
                        Gap(32.h),
                        TextFieldSection(
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                          customColors: customColors,
                          title: 'Full Name',
                          controller: nameController,
                          placeholder: 'e.g: Sample Name',
                        ),
                        Gap(24.h),
                        TextFieldSection(
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          customColors: customColors,
                          title: 'Email',
                          controller: emailController,
                          placeholder: 'sample@gmail.com',
                        ),
                        Gap(24.h),
                        TextFieldSection(
                          customColors: customColors,
                          title: 'Password',
                          controller: passwordController,
                          password: true,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          placeholder: 'Enter your password',
                        ),
                        Gap(24.h),
                        CustomButton(
                          onTap: state is! AuthLoading
                              ? () {
                                  if (formKey.currentState?.validate() ??
                                      true) {
                                    context
                                        .read<AuthCubit>()
                                        .signUpAndSendVerification(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          nameController.text.trim(),
                                        );
                                  }
                                }
                              : null,
                          title: 'Sign Up',
                          titleColor: customColors.brandSecondary!,
                          buttonColor: customColors.brandPrimary!,
                          busy: state is AuthLoading,
                        ),
                        Gap(24.h),
                        CustomButton(
                          leading: SvgPicture.asset(
                            SvgAsset.google,
                            height: 24.h,
                          ),
                          title: 'Continue with Google',
                          titleColor: customColors.brandPrimary!,
                          buttonColor: customColors.bgTeritary!,
                        ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: CustomText(
                        text: ' Login Now',
                        myStyle: headingheadingsm.copyWith(
                          color: customColors.textDefault,
                        ),
                      ),
                    ),
                  ],
                ).addMargin(EdgeInsets.only(bottom: 32.h)),
              ],
            ),
          );
        },
      ),
    );
  }
}
