import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/config/core/common/custom_animated_expansion.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_state.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final Uuid uuid = Uuid();

  void tapped() {
    _isTapped = !_isTapped;
    setState(() {});
  }

//list of static tags
  final FocusNode _focusNode = FocusNode();
  final List<String> _allTags = [
    'Animation',
    '3D',
    'Logo',
    'Freelance',
    'Full Time'
  ];

  final List<String> _filterTags = [];
  final List<String> _selectedTags = [];

  void _onFocusChange() {
    if (_focusNode.hasFocus && _tagsController.text.isEmpty) {
      setState(() {
        _filterTags.clear();
        _filterTags.addAll(_allTags); // Show all jobs initially
      });
    }
  }

  void _filterTag() {
    setState(() {
      _filterTags.clear();
      String input = _tagsController.text.toLowerCase();
      if (input.isNotEmpty) {
        _filterTags.addAll(
          _allTags.where((job) => job.toLowerCase().contains(input)),
        );
        if (_filterTags.isEmpty) {
          _filterTags.add('Add "$input"');
        }
      } else if (_focusNode.hasFocus) {
        // Show all jobs if focused and input is empty
        _filterTags.addAll(_allTags);
      }
    });
  }

  void _addTag(String job) {
    setState(() {
      if (job.startsWith('Add "')) {
        job = job.substring(5, job.length - 1);
        _allTags.add(job);
      }
      if (!_selectedTags.contains(job)) {
        _selectedTags.add(job);
      }
      _tagsController.clear();
      _filterTags.clear();
    });
  }

  void _removeTag(String job) {
    setState(() {
      _selectedTags.remove(job);
    });
  }

  @override
  void initState() {
    super.initState();
    _tagsController.addListener(_filterTag);
    _focusNode.addListener(_onFocusChange);
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
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: CustomButton(
                onTap: () {
                  final newClient = Client(
                    clientId: uuid.v4(),
                    fullName: _fullNameController.text.trim(),
                    companyName: _companyNameController.text.trim(),
                    email: _emailController.text.trim(),
                    phoneNumber: _phoneNumberController.text.trim(),
                    address: _addressController.text.trim(),
                  );
                  context.read<ClientCubit>().addClient(newClient);
                  Navigator.pop(context);
                },
                title: 'Save',
                titleColor: customColors.brandSecondary!,
                buttonColor: customColors.brandPrimary!)
            .addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
        body:
            BlocConsumer<ClientCubit, ClientState>(listener: (context, state) {
          if (state is ClientAdded) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: CustomText(text: 'Client added succesfully')));
            Navigator.pop(context);
          } else if (state is ClientError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: CustomText(text: 'Error: ${state.error}')));
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          if (state is ClientLoading) {
            return CircularProgressIndicator();
          }

          return Column(
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
                        focusnode: _focusNode,
                        controller: _tagsController,
                        placeholder: 'Add New Tags',
                      ),
                      ///hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee//
                      if (_filterTags.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: _filterTags.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_filterTags[index]),
                                onTap: () => _addTag(_filterTags[index]),
                              );
                            },
                          ),
                        ),
                      Wrap(
                        spacing: 8.0,
                        children: _selectedTags.map((tag) {
                          return Chip(
                            backgroundColor: customColors.bgBackground,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: customColors.borderDefault!),
                                borderRadius: BorderRadius.circular(32)),
                            label: Text(tag),
                            labelStyle: bodybodysmdefault.copyWith(
                                color: customColors.textDefault),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeTag(tag),
                          );
                        }).toList(),
                      ),

                      Gap(18.h),
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
          );
        }));
  }
}
