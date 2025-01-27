import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontName,
    this.color,
    this.size,
    this.maxLines,
    this.onTap,
    this.fontWeight,
    this.fontStyle,
    this.textDecoration,
    this.height,
    this.textAlign, this.myStyle,
  });
  //initializing variables
  final String text;
  final String? fontName;
  final Color? color;
  final TextStyle? myStyle;
  final double? size;
  final int? maxLines;
  final void Function()? onTap;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? height;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
 
        textAlign: textAlign,
        text,
        maxLines: maxLines ?? 50,
        style: myStyle
      ),
    );
  }
}
