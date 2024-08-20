import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter_svg/svg.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Edit Profile',
          myStyle: headingheadinglg.copyWith(
            color: customColors.textDefault,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(16.h),
                  profileEdit(context, customColors),
                  Gap(32.h),
                  CustomText(
                    text: 'Full Name',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  CustomTextField(
                    controller: nameController,
                    placeholder: 'Ayush Gautam',
                  ),
                  Gap(24.h),
                  CustomText(
                    text: 'Email',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  CustomTextField(
                    
                    controller: nameController,
                    placeholder: 'ayushgautam88@gmail.com',
                    
                  ),
                  Gap(24.h),
                  CustomText(
                    text: 'Phone Number (Optional)',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  CustomTextField(
                    controller: nameController,
                    placeholder: '9811219209',
                  ),
                  Gap(24.h),
                ],
              ),
            ),
          ),
          CustomButton(
            title: 'Update Profile',
            titleColor: customColors.brandSecondary!,
            buttonColor: customColors.brandPrimary!,
          ),
          Gap(24.h),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
    );
  }

  Center profileEdit(context, AppColors customColors) {
    return Center(
        child: SizedBox(
      height: 100.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: Image.network(
              'https://i.pinimg.com/564x/ae/4e/29/ae4e29ce8a84f7b95d5f27faed37fc9c.jpg',
              height: 100.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            right: 0,
            left: 12,
            child: GestureDetector(
              onTap: () => _showEditDialog(context, customColors),
              child: Container(
                  height: 32.h,
                  width: 71.w,
                  decoration: BoxDecoration(
                      color: customColors.bgBackground!,
                      borderRadius: BorderRadius.circular(58.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgAsset.pen,
                        color: customColors.textDefault,
                      ),
                      Gap(8.w),
                      CustomText(
                        text: 'Edit',
                        myStyle: bodybodyxsmedium.copyWith(
                            color: customColors.textDefault),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}

void _showEditDialog(BuildContext context, AppColors customColors) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 18.w),
        alignment: Alignment.center,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (index) {
              return const ListTile(
                leading: Icon(Icons.photo),
                title: CustomText(text: 'Hahahahh'),
              );
            },
          ),
        ),
      );
    },
  );
}
