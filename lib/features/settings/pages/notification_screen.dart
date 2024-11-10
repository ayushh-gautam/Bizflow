import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NofificationPage extends StatefulWidget {
  const NofificationPage({super.key});

  @override
  State<NofificationPage> createState() => _NofificationPageState();
}

class _NofificationPageState extends State<NofificationPage> {
  @override
  Widget build(BuildContext context) {
    final customColor = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColor.bgSecondary,
      appBar: AppBar(
        backgroundColor: customColor.bgSecondary,
        title: CustomText(
          text: 'Notifications',
          myStyle: headingheadinglg.copyWith(
            color: customColor.textDefault,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: customColor.bgBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            2,
            (index) {
              final title = [
                'Push notifications',
                'Email notifications',
              ];

              final titleDescription = [
                'Receive push notifications on mentions\nand comments',
                'Toggle to enable or disable email\nnotifications.'
              ];
              bool tapped = false;
              return ListTile(
                title: CustomText(
                  text: title[index],
                  myStyle: bodybodymdsemibold.copyWith(
                      color: customColor.textDefault),
                ),
                subtitle: CustomText(
                  text: titleDescription[index],
                  myStyle: bodybodysmdefault.copyWith(
                    color: customColor.textSecondary,
                  ),
                ),
                trailing: CupertinoSwitch(
                    value: tapped,
                    onChanged: (bool istapped) {
                      setState(() {
                        tapped = istapped;
                      });
                    }),
              );
            },
          ),
        ),
      ).addMargin(
        EdgeInsets.symmetric(horizontal: 16.w),
      ),
    );
  }
}
