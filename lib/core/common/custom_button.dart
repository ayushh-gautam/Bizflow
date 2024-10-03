import 'package:bizflow/config/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final Color buttonColor;
  final AlignmentGeometry? alignment;
  final bool busy;
  final Color titleColor;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;

  const CustomButton({
    super.key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
    required this.titleColor,
    required this.buttonColor,
    this.alignment,
  }) : outline = false;

  const CustomButton.outline({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    required this.titleColor,
    required this.buttonColor,
    this.alignment,
  })  : disabled = false,
        busy = false,
        outline = true;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: !outline ? buttonColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: outline
            ? Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 1,
              )
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.grey.shade300,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 56.h,
          alignment: alignment ?? Alignment.center,
          child: busy
              ? const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leading != null) leading!,
                    if (leading != null) Gap(5.w),
                    Text(
                      title,
                      style: bodybodylgsemibold.copyWith(
                        fontWeight:
                            !outline ? FontWeight.w600 : FontWeight.w400,
                        color: !outline
                            ? titleColor
                            : Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
























// class CustomButton extends StatelessWidget {
//   final String title;
//   final bool disabled;
//   final Color buttonColor;
//   final AlignmentGeometry? alignment;
//   final bool busy;
//   final Color titleColor;
//   final void Function()? onTap;
//   final bool outline;
//   final Widget? leading;

//   const CustomButton({
//     super.key,
//     required this.title,
//     this.disabled = false,
//     this.busy = false,
//     this.onTap,
//     this.leading,
//     required this.titleColor,
//     required this.buttonColor,
//     this.alignment,
//   }) : outline = false;

//   const CustomButton.outline({
//     super.key,
//     required this.title,
//     this.onTap,
//     this.leading,
//     required this.titleColor,
//     required this.buttonColor,
//     this.alignment,
//   })  : disabled = false,
//         busy = false,
//         outline = true;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         overlayColor: WidgetStatePropertyAll(Colors.grey.shade300),
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 350),
//           width: double.infinity,
//           height: 56.h,
//           alignment: alignment ?? Alignment.center,
//           decoration: !outline
//               ? BoxDecoration(
//                   color: !disabled ? buttonColor : Colors.grey,
//                   borderRadius: BorderRadius.circular(8),
//                 )
//               : BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Theme.of(context).primaryColorDark,
//                     width: 1,
//                   )),
//           child: !busy
//               ? Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (leading != null) leading!,
//                     if (leading != null) Gap(5.w),
//                     Text(
//                       title,
//                       style: bodybodylgsemibold.copyWith(
//                         fontWeight:
//                             !outline ? FontWeight.w600 : FontWeight.w400,
//                         color: !outline
//                             ? titleColor
//                             : Theme.of(context).primaryColorLight,
//                       ),
//                     ),
//                   ],
//                 )
//               : const CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation(Colors.white),
//                 ),
//         ),
//       ),
//     );
//   }
// }
