import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:flutter/material.dart';

class ClientDetail extends StatelessWidget {
  const ClientDetail({super.key, required this.clientt});

  final Client clientt;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Client Detail',
          myStyle: headingheadingmd.copyWith(color: customColors.textDefault),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: customColors.textDefault,
          ).addMargin(EdgeInsets.only(right: 16.h)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Gap(16.h),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            elevation: 1,
            color: customColors.bgBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image

                    CircleAvatar(
                        radius: 39.38.r,
                        backgroundImage: const NetworkImage(
                            'https://i.pinimg.com/736x/6c/69/29/6c6929de52523d306903c1d331181c19.jpg')),

                    // user name and company name in column
                    Gap(16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Ayush Gautam',
                          myStyle: headingheadinglg.copyWith(
                              color: customColors.textDefault),
                        ),
                        CustomText(
                          text: 'Company Name',
                          myStyle: bodybodysmdefault.copyWith(
                              color: customColors.textSecondary),
                        )
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.more_vert,
                      color: customColors.textDefault,
                    )
                    //client type
                  ],
                ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
               
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Email',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textSecondary),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: 'Phone no',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textSecondary),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: 'Address',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textSecondary),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: 'Tags',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textSecondary),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: ': ${clientt.email}',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textDefault),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: ': ${clientt.phoneNumber}',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textDefault),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: ': ${clientt.address}',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textDefault),
                        ),
                        Gap(8.h),
                        CustomText(
                          text: ': Freelance',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textDefault),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ).addMargin(const EdgeInsets.all(16))
              ],
            ),
          ),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }
}
