import 'package:bizflow/config/constants/text_style.dart';
import 'package:bizflow/config/core/common/text.dart';
import 'package:bizflow/config/core/themes/themeExtension/theme_extension.dart';
import 'package:flutter/material.dart';

class ProjectPages extends StatelessWidget {
  const ProjectPages({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      appBar: AppBar(
          title: CustomText(
        text: 'Projects',
        myStyle: headingheadinglg.copyWith(color: customColors.textDefault),
      )),
      body: Center(
        child: CustomText(text: 'Project Page'),
      ),
    );
  }
}
