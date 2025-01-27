import 'package:flutter/material.dart';
import '../../routes/imports.dart';


class TextFieldSection extends StatelessWidget {
  final String title;
  final String placeholder;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;
  final FocusNode? focusnode;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const TextFieldSection({
    super.key,
    this.focusnode,
    this.trailing,
    this.password = false,
    required this.customColors,
    required this.title,
    required this.controller,
    required this.placeholder,
    this.validator, this.trailingTapped,
  });

  final AppColors customColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          myStyle: bodybodymdmedium.copyWith(color: customColors.textDefault),
        ),
        Gap(4.h),
        KTextField(
          focusnode: focusnode,
          password: password,
          trailing: trailing,
          trailingTapped: trailingTapped,
          controller: controller,
          placeholder: placeholder,
          validator: validator,
          
        )
      ],
    );
  }
}