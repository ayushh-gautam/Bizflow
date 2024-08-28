import 'package:bizflow/features/login/main/settings/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      appBar: AppBar(
        title: CustomText(
          text: 'Home',
          myStyle: headingheadinglg.copyWith(
            color: customColors.textDefault,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NofificationPage();
              }));
            },
            child: SvgPicture.asset(
              SvgAsset.notification,
              color: customColors.textDefault,
            ).addMargin(EdgeInsets.only(right: 12.w)),
          )
        ],
      ),
      body: const Center(
        child: CustomText(text: 'HomePage'),
      ),
    );
  }
}
