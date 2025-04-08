import 'package:bizflow/config/core/common/custom_textfield_section.dart';
import 'package:bizflow/features/authentication/presentation/pages/common/password_reset_page.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import '../../../../../config/constants/app_color.dart';
import 'package:bizflow/features/authentication/presentation/cubit/auth_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetEmailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return PasswordReset();
              },
            ));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Forgot Your Password?',
                myStyle: headingheadingxl.copyWith(
                    color: AppDarkColor.brandSecondary),
              ),
              Gap(8.h),
              const CustomText(
                  text:
                      'Enter your email address and we\'ll send you\ncode to reset your password.'),
              Gap(32.h),
              TextFieldSection(
                customColors: customColors,
                controller: emailController,
                placeholder: 'Enter your email address',
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
              Gap(32.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    onTap: () {
                      final email = emailController.text.trim();
                      if (_formKey.currentState?.validate() ?? true) {
                        context.read<AuthCubit>().sendPasswordResetEmail(email);
                        emailController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  CustomText(text: "Please enter your email"),
                              backgroundColor: customColors.surfaceError),
                        );
                      }
                    },
                    title: state is AuthLoading
                        ? "Sending..."
                        : "Send Reset Email",
                    titleColor: AppLightColor.primaryColor,
                    buttonColor: AppLightColor.brandPrimary,
                    // busy: state is AuthLoading, // You can add a loader if needed
                  );
                },
              ),
            ],
          ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
        ),
      ),
    );
  }
}
