import 'package:bizflow/features/settings/pages/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/routes/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
        backgroundColor: customColors.bgSecondary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  return NotificationPage();
                }));
              },
              child: SvgPicture.asset(
                SvgAsset.notification,
                color: customColors.textDefault,
              ).addMargin(EdgeInsets.only(right: 12.w)),
            )
          ],
        ),
        body: Center());
  }
}
