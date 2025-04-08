import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Separate states for each switch
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      appBar: AppBar(
        backgroundColor: customColors.bgSecondary,
        title: CustomText(
          text: 'Notifications',
          myStyle: headingheadinglg.copyWith(color: customColors.textDefault),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: customColors.bgBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationSwitch(
              title: 'Push notifications',
              description:
                  'Receive push notifications on mentions\nand comments',
              value: _pushNotificationsEnabled,
              onChanged: (value) {
                setState(() => _pushNotificationsEnabled = value);
                // Add your push notification logic here
              },
              customColors: customColors,
            ),
            Divider(height: 1.h, color: customColors.borderSoft),
            _buildNotificationSwitch(
              title: 'Email notifications',
              description: 'Toggle to enable or disable email\nnotifications',
              value: _emailNotificationsEnabled,
              onChanged: (value) {
                setState(() => _emailNotificationsEnabled = value);
                // Add your email notification logic here
              },
              customColors: customColors,
            ),
          ],
        ),
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
    required AppColors customColors,
  }) {
    return ListTile(
      title: CustomText(
        text: title,
        myStyle: bodybodymdsemibold.copyWith(color: customColors.textDefault),
      ),
      subtitle: CustomText(
        text: description,
        myStyle: bodybodysmdefault.copyWith(color: customColors.textSecondary),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: customColors.brandPrimary,
      ),
    );
  }
}
