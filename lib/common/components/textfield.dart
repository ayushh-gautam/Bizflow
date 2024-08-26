import 'package:bizflow/config/themes/themeExtension/theme_extension.dart';
import 'package:bizflow/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final bool showError;
  final void Function()? trailingTapped;
  //

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  CustomTextField({
    super.key,
    required this.controller,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: ThemeData(primaryColor: customColors.borderSoft),
      child: TextField(
        controller: controller,
        style: const TextStyle(height: 1),
        obscureText: password,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle:
              bodybodymddefault.copyWith(color: customColors.textTeritary),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          filled: true,
          fillColor: customColors.baseWhite,
          prefixIcon: leading,
          suffixIcon: trailing != null
              ? GestureDetector(
                  onTap: trailingTapped,
                  child: trailing,
                )
              : null,
          border: circularBorder.copyWith(
            borderSide: BorderSide(color: customColors.borderSoft!),
          ),
          errorBorder: circularBorder.copyWith(
            borderSide: BorderSide(color: customColors.fillError!),
          ),
          focusedBorder: circularBorder.copyWith(
            borderSide: BorderSide(color: customColors.brandPrimary!),
          ),
          enabledBorder: circularBorder.copyWith(
            borderSide: BorderSide(
                color: showError
                    ? customColors.fillError!
                    : customColors.borderDefault!),
          ),
        ),
      ),
    );
  }
}
