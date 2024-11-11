import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final bool showError;
  final void Function()? trailingTapped;
  //

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
  );

  KTextField({
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
        style: TextStyle(height: 1, color: customColors.textDefault),
        obscureText: password,
        decoration: InputDecoration(
          hintText: placeholder,
          focusColor: customColors.baseWhite,
          hintStyle:
              bodybodymddefault.copyWith(color: customColors.textTeritary),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          filled: true,
          fillColor: customColors.bgBackground,
          prefixIcon: leading,
          suffixIcon: trailing != null
              ? GestureDetector(
                  onTap: trailingTapped,
                  child: trailing,
                )
              : null,
          border: circularBorder.copyWith(
            borderSide: BorderSide(color: customColors.borderSoft!, width: 1),
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
