import 'package:bizflow/features/authentication/login/presentation/pages/change_password.dart';
import 'package:bizflow/features/settings/pages/edit_profile.dart';
import 'package:bizflow/features/settings/pages/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/config/routes/imports.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customColors.bgSecondary,
        title: CustomText(
          text: 'Settings',
          myStyle: headingheadinglg.copyWith(color: customColors.textDefault),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            profileSection(customColors),
            Gap(32.h),
            /*------------------------General----------------------------------*/
            CustomText(
              text: 'General',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textSecondary),
            ),
            Gap(5.h),
            generalTiles(context, customColors),
            Gap(24.h),

            /*----------------------Others------------------------------------*/
            CustomText(
              text: 'Others',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textSecondary),
            ),
            Gap(5.h),
            otherTiles(customColors),
            Gap(24.h),
            /*-----------------------Logout-----------------------------------*/
            CustomButton(
                alignment: Alignment.centerLeft,
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                title: 'Logout',
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Icon(
                    Icons.logout,
                    color: customColors.fillError,
                  ),
                ),
                titleColor: customColors.fillError!,
                buttonColor: customColors.bgBackground!),
            Gap(32.h),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.h)),
      ),
    );
  }

  profileSection(AppColors customColors) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              'https://i.pinimg.com/564x/ae/4e/29/ae4e29ce8a84f7b95d5f27faed37fc9c.jpg',
              height: 100.h,
            ),
          ),
          Gap(16.h),
          CustomText(
            text: 'User',
            myStyle: headingheadinglg.copyWith(color: customColors.textDefault),
          ),
          Gap(4.h),
          CustomText(
            text: 'testing@gmail.com',
            myStyle:
                bodybodysmdefault.copyWith(color: customColors.textSecondary),
          ),
        ],
      ),
    );
  }

  otherTiles(AppColors customColors) {
    return Container(
        decoration: BoxDecoration(
            color: customColors.bgBackground,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: List.generate(
            4,
            (index) {
              final othersTitles = [
                'About App',
                'Help & Support',
                'Share this App',
                'Rate this App',
              ];
              return ListTile(
                title: CustomText(
                  text: othersTitles[index],
                  myStyle: bodybodymddefault.copyWith(
                      color: customColors.textDefault),
                ),
                trailing: const Icon(CupertinoIcons.forward),
              );
            },
          ),
        ));
  }

  Widget generalTiles(BuildContext context, AppColors customColors) {
    final List<Widget Function()> screens = [
      () => const EditProfile(),
      () => const ChangePassword(),
      () => const NofificationPage(),
    ];
    final generalTitles = [
      'Edit Profile',
      'Change Password',
      'Notification',
      'Dark Mode',
    ];
    return Container(
        decoration: BoxDecoration(
            color: customColors.bgBackground,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: List.generate(
            4,
            (index) {
              return ListTile(
                title: CustomText(
                  text: generalTitles[index],
                  myStyle: bodybodymddefault.copyWith(
                      color: customColors.textDefault),
                ),
                trailing: index == 3
                    ? BlocBuilder<ThemeCubit, ThemeData>(
                        builder: (context, theme) {
                        return CupertinoSwitch(
                          activeColor: customColors.textTeritary,
                          value: theme.brightness == Brightness.dark,
                          onChanged: (bool value) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                        );
                      })
                    : const Icon(CupertinoIcons.forward),
                onTap: index != 3
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => screens[index](),
                          ),
                        );
                      }
                    : null,
              );
            },
          ),
        ));
  }
}
