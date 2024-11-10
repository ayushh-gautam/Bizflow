import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/material.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(

                      text: 'Add New Client',
                      myStyle: headingheadingxl.copyWith(
                        color: customColors.textDefault,
                      )),
                  Gap(8.h),
                  CustomText(
                    text:
                        'Simply adding a client will not notify them in any\nway.',
                    myStyle: bodybodymddefault.copyWith(
                        color: customColors.textSecondary),
                  ),
                  Gap(32.h),
                  CustomText(
                    text: 'Full Name',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  KTextField(
                    controller: TextEditingController(),
                    placeholder: 'eg. John',
                  ),
                  Gap(24.h),
                  CustomText(
                    text: 'Company Name',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  KTextField(
                    controller: TextEditingController(),
                    placeholder: 'eg. Google',
                  ),
                  Gap(24.h),
                  Text(
                    'Email',
                    style: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  KTextField(
                    controller: TextEditingController(),
                    placeholder: 'eg. johndoe@xyz.com',
                  ),
                  Gap(24.h),
                  Text(
                    'Tags',
                    style: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  KTextField(
                    controller: TextEditingController(),
                    placeholder: 'Add New Tags',
                  ),
                  Gap(24.h),

                ],
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
            ),
          ),
        ],
      ),
    );
  }
}
