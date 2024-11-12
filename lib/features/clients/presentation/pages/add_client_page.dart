import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/core/common/custom_animated_expansion.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';
import 'package:flutter/material.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final _fullNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _tagsController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isTapped = false;

  void tapped() {
    _isTapped = !_isTapped;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    _tagsController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CustomButton(
              onTap: () {
                final newClient = Client(
                    fullName: _fullNameController.text.isNotEmpty
                        ? _fullNameController.text
                        : 'User001',
                    companyName: _companyNameController.text.isNotEmpty
                        ? _companyNameController.text
                        : 'Google',
                    email: _emailController.text.isNotEmpty
                        ? _emailController.text
                        : 'abc@gmail.com',
                    tags: _tagsController.text.isNotEmpty
                        ? _tagsController.text
                        : 'Developer',
                    phoneNumber: _phoneNumberController.text.isNotEmpty
                        ? _phoneNumberController.text
                        : '9811200210',
                    address: _addressController.text.isNotEmpty
                        ? _addressController.text
                        : 'Kathmandu');
                context.read<ClientCubit>().addClient(newClient);

                Navigator.pop(context);
              },
              title: 'Save',
              titleColor: customColors.brandSecondary!,
              buttonColor: customColors.brandPrimary!)
          .addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
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
                    controller: _fullNameController,
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
                    controller: _companyNameController,
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
                    controller: _emailController,
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
                    controller: _tagsController,
                    placeholder: 'Add New Tags',
                  ),
                  Gap(24.h),
                  GestureDetector(
                      onTap: tapped,
                      child: Row(
                        children: [
                          _isTapped
                              ? const Icon(Icons.remove)
                              : const Icon(Icons.add),
                          CustomText(
                            text: 'Additional Info',
                            myStyle: bodybodymdmedium.copyWith(
                                color: customColors.textDefault),
                          )
                        ],
                      )),
                  Gap(24.h),
                  CustomAnimatedExpansion(
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Phone Number',
                            myStyle: bodybodymdmedium.copyWith(
                                color: customColors.textDefault),
                          ),
                          Gap(4.h),
                          KTextField(
                            controller: _phoneNumberController,
                            placeholder: 'eg: 980000000',
                          ),
                          Gap(24.h),
                          CustomText(
                            text: 'Address',
                            myStyle: bodybodymdmedium.copyWith(
                                color: customColors.textDefault),
                          ),
                          Gap(4.h),
                          KTextField(
                            controller: _addressController,
                            placeholder: 'eg: Kathmandu',
                          ),
                          Gap(24.h),
                          CustomText(
                            text: 'Description',
                            myStyle: bodybodymdmedium.copyWith(
                                color: customColors.textDefault),
                          ),
                          Gap(4.h),
                          KTextField(
                            controller: _descriptionController,
                            placeholder: 'eg: designer',
                          ),
                          Gap(24.h)
                        ],
                      ),
                      isTapped: _isTapped),
                ],
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
            ),
          ),
        ],
      ),
    );
  }
}
