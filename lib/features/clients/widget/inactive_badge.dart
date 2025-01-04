// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../config/routes/imports.dart';

// ignore: must_be_immutable
class ActiveInactiveBadge extends StatelessWidget {
  final String title;
  double? width;
  double? height;
  ActiveInactiveBadge({
    super.key,
    required this.title,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.green.shade300),
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(4.r)),
      child: Center(
        child: CustomText(
          text: title,
          myStyle: bodybodyxsmedium.copyWith(color: customColors.fillSuccess),
        ),
      ),
    );
  }
}
