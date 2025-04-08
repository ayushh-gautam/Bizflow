import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final bool showError;
final void Function(String)? onChanged;
  FocusNode? focusnode;
  final FormFieldValidator<String>? validator;
  final void Function()? trailingTapped;

  KTextField({
    super.key,
    this.focusnode,
    this.onChanged,
    
    required this.controller,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
    this.showError = false,
    this.validator,
  });

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  var tapped = true;
  var icon = SvgAsset.eyeClosed;
  void isTapped() {
    tapped = !tapped;

    if (tapped) {
      icon = SvgAsset.eyeClosed;
    } else {
      icon = SvgAsset.eyeOpen;
    }
    setState(() {});
  }

  //
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
  );

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: ThemeData(primaryColor: customColors.borderSoft),
      child: TextFormField(
        onChanged: widget.onChanged,
        focusNode: widget.focusnode,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(height: 1, color: customColors.textDefault),
        obscureText: widget.password ? tapped : false,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          focusColor: customColors.baseWhite,
          hintStyle:
              bodybodymddefault.copyWith(color: customColors.textTeritary),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          filled: true,
          fillColor: customColors.bgBackground,
          prefixIcon: widget.leading,
          suffixIcon: widget.password
              ? GestureDetector(
                  onTap: isTapped,
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      icon,
                      height: 20,
                      width: 20,
                     
                    ),
                  ),
                )
              : widget.trailing,
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
                color: widget.showError
                    ? customColors.fillError!
                    : customColors.borderDefault!),
          ),
        ),
      ),
    );
  }
}
