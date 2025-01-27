import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import 'package:bizflow/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  bool ischecked = false;
  final TextEditingController _invoiceNameController = TextEditingController();
  final TextEditingController _invoiceIdController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();

  final TextEditingController _invoiceProjectController =
      TextEditingController();
  DateTime? _selectDueDate;
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          final newInvoice = Invoice(
              fullName: _invoiceNameController.text.isNotEmpty
                  ? _invoiceNameController.text
                  : 'Invoice 001',
              amount: '1000',
              projectName: _invoiceProjectController.text.isNotEmpty
                  ? _invoiceProjectController.text
                  : 'Sample Project',
              invoiceId: _invoiceIdController.text.isNotEmpty
                  ? _invoiceIdController.text
                  : '1',
              issuedDate: DateTime.now(),
              dueDate: _selectDueDate!);

          context.read<InvoiceCubit>().addInvoice(newInvoice);

          Navigator.pop(context);
        },
        child: CustomButton(
            width: 172.w,
            title: 'Create Invoice',
            titleColor: customColors.brandSecondary!,
            buttonColor: customColors.brandPrimary!),
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
      appBar: AppBar(
        title: CustomText(
          text: 'Create Invoice',
          myStyle: headingheadinglg,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(24.h),
                  topCard(customColors),
                  Gap(24.h),
                  clientProjectCard(customColors),
                  Gap(24.h),
                  CustomButton(
                      onTap: () {
                        _addItemSheet(context, customColors);
                      },
                      leading: Icon(Icons.add),
                      title: 'Add Item',
                      titleColor: customColors.textDefault!,
                      buttonColor: customColors.bgBackground!),
                  Gap(24.h),

                  //TODO:Billing Items

                  // CustomAnimatedExpansion(
                  //     secondChild: Card(
                  //       child: Column(
                  //         children: [],
                  //       ),
                  //     ),
                  //     isTapped: true)

                  amountCard(customColors),

                  Gap(16.h),

                  KTextField(
                    controller: TextEditingController(),
                    placeholder: 'Note or Remarks',
                  ),
                  Gap(20.h)
                ],
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> _addItemSheet(BuildContext context, AppColors customColors) {
    return showModalBottomSheet(
        backgroundColor: customColors.bgBackground,
        context: context,
        showDragHandle: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.infinity,
                height: 370.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Add Expense Item',
                      myStyle: headingheadingmd,
                    ),
                    Gap(16.h),
                    CustomText(
                      text: 'Item Name',
                      myStyle: bodybodysmmedium,
                    ),
                    Gap(4.h),
                    KTextField(
                      controller: TextEditingController(),
                      placeholder: 'E.g. Service A',
                    ),
                    Gap(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Units'),
                            Gap(4.h),
                            SizedBox(
                              width: 156.w,
                              child: KTextField(
                                controller: TextEditingController(),
                                placeholder: '2',
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Rate'),
                            Gap(4.h),
                            SizedBox(
                              width: 156.w,
                              child: KTextField(
                                controller: TextEditingController(),
                                placeholder: 'Rs.500',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gap(16.h),
                    Card(
                      elevation: 0,
                      color: customColors.borderSoft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: 'Total Amount'),
                          CustomText(text: 'Rs.0')
                        ],
                      ).addPadding(EdgeInsets.symmetric(
                          horizontal: 12.h, vertical: 12.h)),
                    ),
                    Gap(16.h),
                    CustomButton(
                        height: 48.h,
                        title: 'Save Item',
                        titleColor: customColors.textTeritary!,
                        buttonColor: customColors.borderSoft!)
                  ],
                ),
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.h));
            },
          );
        });
  }

  Card amountCard(AppColors customColors) {
    return Card(
      color: customColors.bgBackground,
      elevation: 0,
      child: Column(
        children: [
          _buildRow(title: 'Total Amount', value: 'Rs.1000'),
          Gap(17.h),
          Row(
            children: [
              Checkbox(
                  value: ischecked,
                  onChanged: (bool? newvalue) {
                    setState(() {
                      ischecked = newvalue!;
                    });
                  }),
              Gap(4.w),
              CustomText(
                text: 'Receive Amount',
                myStyle: bodybodysmdefault,
              ),
              Spacer(),
              CustomText(
                text: 'Rs.500',
                myStyle: bodybodymdmedium,
              )
            ],
          ),
          Gap(17.h),
          _buildRow(
              title: 'Balance Due',
              value: 'Rs.500',
              valueStyle:
                  bodybodymdmedium.copyWith(color: customColors.fillError)),
          Gap(17.h),
          GestureDetector(
              onTap: () {
                _pickDueDate();
              },
              child: _buildRow(
                title: 'Due Date',
                value: _selectDueDate != null
                    ? '${_selectDueDate!.day}/${_selectDueDate!.month}/${_selectDueDate!.year}'
                    : 'Set Date >',
              )),
          Gap(17.h),
          _buildRow(title: 'Payment Mode', value: 'Cash >')
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h)),
    );
  }

  Card topCard(AppColors customColors) {
    return Card(
      color: customColors.bgBackground,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Invoice Name',
            myStyle: bodybodymdmedium.copyWith(color: customColors.textDefault),
          ),
          Gap(4.h),
          KTextField(
            controller: _invoiceNameController,
            placeholder: 'eg. January Invoice',
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Invoice id',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  SizedBox(
                    width: 156.w,
                    child: KTextField(
                      controller: _invoiceIdController,
                      placeholder: '1',
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Invoice Date',
                    myStyle: bodybodymdmedium.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(4.h),
                  SizedBox(
                    width: 156.w,
                    child: KTextField(
                      controller: _invoiceDateController,
                      placeholder: 'Jan 20, 2025',
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h)),
    );
  }

/////////
  Widget _buildRow({
    required String title,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          myStyle: bodybodymdmedium,
        ),
        CustomText(
          text: value,
          myStyle: valueStyle ?? bodybodymdmedium,
        ),
      ],
    );
  }

  Future<void> _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectDueDate = pickedDate;
      });
    }
  }
}

/////

Card clientProjectCard(AppColors customColors) {
  return Card(
    elevation: 0,
    color: customColors.bgBackground,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(100)),
              child: CustomText(text: 'AD'),
            ),
            Gap(8.w),
            Column(
              children: [
                CustomText(
                  text: 'Anish Dahal',
                  myStyle: bodybodymdmedium,
                ),
                Gap(4.h),
                CustomText(
                  text: 'Project Name',
                  myStyle: bodybodysmdefault,
                ),
              ],
            ),
            Gap(87.w),
            CustomButton.outline(
                leading: Icon(Icons.recycling),
                width: 94,
                title: 'Change',
                titleColor: customColors.brandPrimary!,
                buttonColor: Colors.transparent)
          ],
        )
      ],
    ).addMargin(EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)),
  );
}
