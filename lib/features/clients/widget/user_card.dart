// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';

class UserCard extends StatelessWidget {
  final String userName;
  final String email;
  final String totalProjects;
  final String invoiceAmount;
  final String projectStatus;
  final String userImageUrl;

  const UserCard({
    super.key,
    required this.userName,
    required this.email,
    required this.totalProjects,
    required this.invoiceAmount,
    required this.projectStatus,
    required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      elevation: 1,
      color: customColors.bgBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // User Photo
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 48.h,
                  width: 48.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                  child: Image.network(
                      'https://i.pinimg.com/736x/6c/69/29/6c6929de52523d306903c1d331181c19.jpg'),
                ),

                Gap(12.w),

                // User Name and Email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: userName,
                          myStyle: bodybodymdsemibold.copyWith(
                              color: customColors.textDefault)),
                      Gap(4.h),
                      CustomText(
                          text: email,
                          myStyle: bodybodysmdefault.copyWith(
                              color: customColors.textSecondary)),
                    ],
                  ),
                ),

                // Three-dot menu icon
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: customColors.textDefault,
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            // Horizontal Line

            Divider(
              thickness: 1,
              color: customColors.borderSoft,
            ).addMargin(EdgeInsets.symmetric(vertical: 16.h)),

            // Bottom Row with Projects, Invoice, and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Projects
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: 'Projects',
                      myStyle: bodybodyxsdefault.copyWith(
                          color: customColors.textSecondary),
                    ),
                    Gap(4.h),
                    CustomText(
                        text: totalProjects,
                        myStyle: bodybodymdmedium.copyWith(
                            color: customColors.textDefault)),
                  ],
                ),

                // Invoice Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: 'Invoice Amount',
                      myStyle: bodybodyxsdefault.copyWith(
                          color: customColors.textSecondary),
                    ),
                    Gap(4.h),
                    CustomText(
                        text: invoiceAmount,
                        myStyle: bodybodymdmedium.copyWith(
                            color: customColors.textDefault)),
                  ],
                ),

                // Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: 'Status',
                      myStyle: bodybodyxsdefault.copyWith(
                          color: customColors.textSecondary),
                    ),
                    Gap(4.h),
                    CustomText(
                        text: projectStatus,
                        myStyle: bodybodymdmedium.copyWith(
                            color: customColors.textDefault)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
