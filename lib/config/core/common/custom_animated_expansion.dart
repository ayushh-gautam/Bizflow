import 'package:bizflow/config/core/themes/themeExtension/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomAnimatedExpansion extends StatelessWidget {
  const CustomAnimatedExpansion(
      {super.key,
      required this.secondChild,
      required this.isTapped,
      this.firstChild});
  final Widget? firstChild;
  final Widget secondChild;
  final bool isTapped;

   

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return AnimatedCrossFade(
      reverseDuration: const Duration(milliseconds: 400),
      firstChild: firstChild ??
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
      secondChild: AnimatedContainer(
          color: customColors.bgBackground,
          duration: const Duration(milliseconds: 1000),
          // height: widget._isTapped ? 500 : 0,
          width: MediaQuery.of(context).size.width,
          child: secondChild),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isTapped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 400),
    );
  }
}
