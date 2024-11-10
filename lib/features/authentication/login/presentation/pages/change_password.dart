import 'package:bizflow/features/authentication/login/presentation/pages/password_changed.dart';
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool showError = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePasswords);
    confirmpasswordController.addListener(_validatePasswords);
  }

  void _validatePasswords() {
    setState(() {
      showError = confirmpasswordController.text.isNotEmpty &&
          passwordController.text != confirmpasswordController.text;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Set New Password',
            myStyle: headingheadingxl.copyWith(color: customColors.textDefault),
          ),
          Gap(8.h),
          CustomText(
            text: 'Enter your new password below',
            myStyle:
                bodybodymddefault.copyWith(color: customColors.textSecondary),
          ),
          Gap(32.h),
          CustomText(
            text: 'New Password',
            myStyle: bodybodymdmedium.copyWith(color: customColors.textDefault),
          ),
          Gap(4.h),
          KTextField(
            trailing: Icon(
              Icons.visibility,
              color: customColors.borderDefault,
            ),
            password: true,
            controller: passwordController,
            placeholder: 'Enter your new password',
          ),
          Gap(24.h),
          CustomText(
            text: 'Confirm Password',
            myStyle: bodybodymdmedium.copyWith(color: customColors.textDefault),
          ),
          Gap(4.h),
          KTextField(
            trailing: Icon(
              Icons.visibility,
              color: customColors.borderDefault,
            ),
            password: true,
            controller: confirmpasswordController,
            placeholder: 'Enter your confirm password',
            showError: showError,
          ),
          if (showError) // Show error message
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Passwords do not match',
                style: TextStyle(color: customColors.fillError),
              ),
            ),
          Gap(32.h),
          CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordChanged()));
              },
              title: 'Save New Password',
              titleColor: customColors.brandSecondary!,
              buttonColor: customColors.brandPrimary!),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }
}
