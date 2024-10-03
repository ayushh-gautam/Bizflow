import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final tempImage = File(image.path);

      setState(() => this.image = tempImage);
    } on PlatformException catch (e) {
      print('failedto pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

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

                  //--------------------- profile picturee--------------------//
                  profileEdit(context, customColors),
                  Gap(32.h),

                  //--------------------input field section-----------------//
                  CustomText(
                    text: 'Full Name',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  CustomTextField(
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
                    placeholder: '9811219209',
                  ),
                  Gap(24.h),
                ],
              ),
            ),
          ),

          //---------------------Update Profile Button------------------------//
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
              child: image == null
                  ? Image.network(
                      'https://i.pinimg.com/564x/ae/4e/29/ae4e29ce8a84f7b95d5f27faed37fc9c.jpg',
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      image!,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )),
          Positioned(
            top: 70,
            right: 0,
            left: 12,
            child: GestureDetector(
              onTap: () => _showEditDialog(
                context,
                customColors,
              ),
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
                        // ignore: deprecated_member_use
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

  void _showEditDialog(BuildContext context, AppColors customColors) {
    List<String> actionText = ['View Photo', 'Change Photo', 'Remove Photo'];

    List<Widget> leadingIcons = const [
      Icon(Icons.filter),
      Icon(Icons.edit),
      Icon(Icons.delete)
    ];

    List<VoidCallback> callbacks = [
      //viwew photo
      () {},

      //choose photo
      () {
        List<String> changeText = ['Take from Camera', 'Choose from gallery'];
        List<Widget> changeIcons = const [
          Icon(Icons.camera),
          Icon(Icons.filter)
        ];

        List<VoidCallback> actionCallback = [
          () {
            Navigator.pop(context);
            pickImage(ImageSource.camera);
          },
          () {
            Navigator.pop(context);
            pickImage(ImageSource.gallery);
          }
        ];
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: customColors.bgBackground,
                insetPadding: EdgeInsets.symmetric(horizontal: 18.w),
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(changeText.length, (index) {
                    return ListTile(
                      title: CustomText(
                        text: changeText[index],
                      ),
                      leading: changeIcons[index],
                      onTap: actionCallback[index],
                    );
                  }),
                ),
              );
            });
      },
      () {
        // Remove Photo action logic
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: customColors.bgBackground,
          insetPadding: EdgeInsets.symmetric(horizontal: 18.w),
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              actionText.length,
              (index) {
                return ListTile(
                  onTap: callbacks[index],
                  leading: leadingIcons[index],
                  title: CustomText(text: actionText[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
