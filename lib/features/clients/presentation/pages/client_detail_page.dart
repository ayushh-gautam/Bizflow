import 'dart:ui';

import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/core/common/custom_animated_expansion.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:bizflow/features/clients/widget/inactive_badge.dart';
import 'package:bizflow/features/clients/widget/project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientDetail extends StatefulWidget {
  const ClientDetail({super.key, required this.clientt});
  final Client clientt;

  @override
  State<ClientDetail> createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  List<bool> _isTappedList = [false, false, false, false];

  void tapped(int index) {
    _isTappedList[index] = !_isTappedList[index];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      appBar: AppBar(
        title: CustomText(
          text: 'Client Detail',
          myStyle: headingheadingmd.copyWith(color: customColors.textDefault),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                              child: Container(
                                color: Colors.black.withOpacity(
                                    0), // Background becomes blurred
                              ),
                            ),
                          ),
                          Container(
                            width: 361.h,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: customColors.bgBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.edit),
                                    Gap(12.h),
                                    CustomText(
                                      text: 'Edit Client Detail',
                                      myStyle: bodybodymddefault.copyWith(
                                          color: customColors.textDefault),
                                    ),
                                  ],
                                ),
                                Gap(16.h),
                                Row(
                                  children: [
                                    const Icon(Icons.delete),
                                    Gap(12.h),
                                    CustomText(
                                      text: 'Delete Client ',
                                      myStyle: bodybodymddefault.copyWith(
                                          color: customColors.textDefault),
                                    ),
                                  ],
                                ),
                              ],
                            ).addMargin(EdgeInsets.symmetric(
                                horizontal: 16.h, vertical: 16.h)),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.more_vert,
              color: customColors.textDefault,
            ).addMargin(EdgeInsets.only(right: 16.h)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap(16.h),
            userCard(customColors),
            Gap(24.h),

            /*----------------PROJECTS SECTION------------------------*/
            CustomText(
              text: 'Projects',
              myStyle:
                  bodybodymdsemibold.copyWith(color: customColors.textDefault),
            ),
            Gap(12.h),
            SizedBox(
              height: 130.h,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const ProjectCard();
                },
              ),
            ),
            Gap(24.h),

            /*---------------INVOICE SECTION--------------------------*/
            CustomText(
              text: 'Invoices',
              myStyle: bodybodymdsemibold.copyWith(
                color: customColors.textDefault,
              ),
            ),
            Gap(12.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  color: customColors.bgBackground,
                  child: Column(
                    children: [
                      invoiceNameAndAmount(customColors, index).addMargin(
                          EdgeInsets.symmetric(
                              horizontal: 16.h, vertical: 16.h)),
                      expandedInvoiceDetails(customColors, index),
                    ],
                  ),
                );
              },
            )

            ////////////////////////////////////////////////////////////////////
          ],
        ).addMargin(EdgeInsets.symmetric(
          horizontal: 16.w,
        )),
      ),
    );
  }

  Card userCard(AppColors customColors) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      elevation: 1,
      color: customColors.bgBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          userGeneralInfo(customColors),
          Gap(16.h),
          userContactDetails(customColors),
        ],
      ).addMargin(EdgeInsets.all(16.h)),
    );
  }

  Row userContactDetails(AppColors customColors) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Email',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(8.h),
            CustomText(
              text: 'Phone no',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(8.h),
            CustomText(
              text: 'Address',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(8.h),
            CustomText(
              text: 'Tags',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textSecondary),
            )
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: ':  ${widget.clientt.email}',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textDefault),
            ),
            Gap(8.h),
            CustomText(
              text: ':  ${widget.clientt.phoneNumber} ',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textDefault),
            ),
            Gap(8.h),
            CustomText(
              text: ':  ${widget.clientt.address}',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textDefault),
            ),
            Gap(8.h),

            CustomText(
              text: ':  Developer',
              myStyle:
                  bodybodymddefault.copyWith(color: customColors.textDefault),
            )
            // Wrap(
            //   spacing: 8.h,
            //   children: widget.clientt.tags.map((tag) {
            //     return Chip(
            //       backgroundColor: customColors.bgBackground,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(color: customColors.borderDefault!),
            //         borderRadius: BorderRadius.circular(32),
            //       ),
            //       padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 0),
            //       label: Text(
            //         'Developer',
            //         style: bodybodysmdefault.copyWith(
            //             color: customColors.textDefault),
            //       ),
            //     );
            //   }).toList(),
            // )
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Row userGeneralInfo(AppColors customColors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //image

        Container(
          clipBehavior: Clip.antiAlias,
          height: 64.h,
          width: 64.h,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(39.38.r)),
          child: Image.network(
              'https://i.pinimg.com/736x/6c/69/29/6c6929de52523d306903c1d331181c19.jpg'),
        ),
        // user name and company name in column
        Gap(16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: widget.clientt.fullName,
              myStyle:
                  headingheadinglg.copyWith(color: customColors.textDefault),
            ),
            CustomText(
              text: widget.clientt.address,
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            )
          ],
        ),
        const Spacer(),

        ActiveInactiveBadge(
          title: 'Active',
        ),

        //client type
      ],
    );
  }

  Row invoiceNameAndAmount(AppColors customColors, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'INV-100',
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            ),
            Row(
              children: [
                CustomText(
                  text: 'Rs 1,0000',
                  myStyle: bodybodymdsemibold.copyWith(
                      color: customColors.textDefault),
                ),
                Gap(12.h),
                ActiveInactiveBadge(title: 'Inactive')
              ],
            )
          ],
        ),
        IconButton(
            onPressed: () => tapped(index),
            icon: const Icon(CupertinoIcons.arrow_down))
      ],
    );
  }

  CustomAnimatedExpansion expandedInvoiceDetails(
      AppColors customColors, int index) {
    return CustomAnimatedExpansion(
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 0.9,
              color: customColors.borderSoft,
            ),
            Gap(16.h),
            CustomText(
              text: 'Project Name',
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(4.h),
            CustomText(
              text: 'Project 1',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(16.h),
            CustomText(
              text: 'Created DATE',
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(4.h),
            CustomText(
              text: 'Sep 14, 2024 04:44 PM',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(16.h),
            CustomText(
              text: 'Payment DATE',
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(4.h),
            CustomText(
              text: 'Sep 14, 2024 04:44 PM',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(16.h),
            CustomText(
              text: 'Notes (Optional)',
              myStyle:
                  bodybodysmdefault.copyWith(color: customColors.textSecondary),
            ),
            Gap(4.h),
            CustomText(
              text: 'Done',
              myStyle:
                  bodybodysmmedium.copyWith(color: customColors.textDefault),
            ),
            Gap(16.h)
          ],
        ).addPadding(EdgeInsets.symmetric(horizontal: 16.h)),
        isTapped: _isTappedList[index]);
  }
}
