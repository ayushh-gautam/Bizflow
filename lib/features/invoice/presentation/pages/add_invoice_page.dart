import 'package:flutter/material.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import '../cubit/invoice_cubit.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  // Form controllers
  final TextEditingController _invoiceNameController = TextEditingController();
  final TextEditingController _invoiceIdController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _invoiceProjectController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _clientNameController =
      TextEditingController(text: 'New User');
  final TextEditingController _projectNameController =
      TextEditingController(text: 'Website Redesign');

  // Item form controllers
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  // State variables
  DateTime? _selectedDueDate;
  String _paymentMode = 'Cash';
  bool _isPaymentReceived = false;
  double _totalAmount = 0.0;
  double _receivedAmount = 0.0;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _invoiceDateController.text = _formatDate(DateTime.now());
  }

  @override
  void dispose() {
    _invoiceNameController.dispose();
    _invoiceIdController.dispose();
    _invoiceDateController.dispose();
    _invoiceProjectController.dispose();
    _noteController.dispose();
    _itemNameController.dispose();
    _unitsController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    final balanceDue = _totalAmount - _receivedAmount;

    return Scaffold(
      backgroundColor: customColors.bgSecondary,
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
                  _buildTopCard(customColors),
                  Gap(24.h),
                  _buildClientProjectCard(customColors),
                  Gap(24.h),
                  if (_items.isNotEmpty) _buildItemsList(customColors),
                  if (_items.isNotEmpty) Gap(24.h),
                  CustomButton(
                    onTap: () => _showAddItemSheet(context, customColors),
                    leading: const Icon(Icons.add),
                    title: 'Add Item',
                    titleColor: customColors.textDefault!,
                    buttonColor: customColors.bgBackground!,
                  ),
                  Gap(24.h),
                  _buildAmountCard(customColors, balanceDue),
                  Gap(16.h),
                  KTextField(
                    controller: _noteController,
                    placeholder: 'Note or Remarks',
                  ),
                  Gap(20.h),
                ],
              ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)),
            ),
          ),
          _buildCreateButton(customColors),
        ],
      ),
    );
  }

  Widget _buildCreateButton(AppColors customColors) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: CustomButton(
        width: 172.w,
        title: 'Create Invoice',
        titleColor: customColors.brandSecondary!,
        buttonColor: customColors.brandPrimary!,
        onTap: _createInvoice,
      ),
    );
  }

  void _createInvoice() {
    if (_selectedDueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a due date')));
      return;
    }

    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one item')));
      return;
    }

    final newInvoice = Invoice(
      fullName: _invoiceNameController.text.isNotEmpty
          ? _invoiceNameController.text
          : 'Invoice ${DateTime.now().millisecondsSinceEpoch}',
      amount: _totalAmount.toStringAsFixed(2),
      projectName: _invoiceProjectController.text.isNotEmpty
          ? _invoiceProjectController.text
          : _projectNameController.text,
      invoiceId: _invoiceIdController.text.isNotEmpty
          ? _invoiceIdController.text
          : DateTime.now().millisecondsSinceEpoch.toString(),
      issuedDate: DateTime.now(),
      dueDate: _selectedDueDate!,
    );

    context.read<InvoiceCubit>().addInvoice(newInvoice);
    Navigator.pop(context);
  }

  Widget _buildTopCard(AppColors customColors) {
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
            placeholder: 'e.g. January Invoice',
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Invoice ID',
                      myStyle: bodybodymdmedium.copyWith(
                          color: customColors.textDefault),
                    ),
                    Gap(4.h),
                    KTextField(
                      controller: _invoiceIdController,
                      placeholder: 'e.g. INV-001',
                    ),
                  ],
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Invoice Date',
                      myStyle: bodybodymdmedium.copyWith(
                          color: customColors.textDefault),
                    ),
                    Gap(4.h),
                    KTextField(
                      controller: _invoiceDateController,
                      placeholder: _formatDate(DateTime.now()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).addPadding(EdgeInsets.all(16.w)),
    );
  }

  Widget _buildClientProjectCard(AppColors customColors) {
    return Card(
      elevation: 0,
      color: customColors.bgBackground,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50.h,
                width: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: customColors.brandPrimary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CustomText(
                  text: _getInitials(_clientNameController.text),
                  myStyle: bodybodymdmedium.copyWith(
                      color: customColors.brandSecondary),
                ),
              ),
              Gap(8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: _clientNameController.text,
                    myStyle: bodybodymdmedium,
                  ),
                  Gap(4.h),
                  CustomText(
                    text: _projectNameController.text,
                    myStyle: bodybodysmdefault,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton.outline(
                leading: Icon(Icons.edit, size: 20.h),
                width: 94.w,
                title: 'Change',
                titleColor: customColors.brandPrimary!,
                buttonColor: Colors.transparent,
                onTap: () => _showChangeClientDialog(customColors),
              ),
            ],
          ),
        ],
      ).addPadding(EdgeInsets.all(12.w)),
    );
  }

  Widget _buildItemsList(AppColors customColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Items',
          myStyle: bodybodymdmedium.copyWith(color: customColors.textDefault),
        ),
        Gap(8.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return Dismissible(
              key: Key(item['name'] + index.toString()),
              background: Container(
                color: customColors.fillError,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.w),
                child: Icon(Icons.delete, color: customColors.textSecondary),
              ),
              onDismissed: (direction) {
                setState(() {
                  _totalAmount -= item['total'];
                  _items.removeAt(index);
                });
              },
              child: Card(
                color: customColors.bgBackground,
                elevation: 0,
                margin: EdgeInsets.only(bottom: 8.h),
                child: ListTile(
                  title: CustomText(text: item['name']),
                  subtitle:
                      CustomText(text: '${item['units']} × Rs.${item['rate']}'),
                  trailing: CustomText(
                      text: 'Rs.${item['total'].toStringAsFixed(2)}'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAmountCard(AppColors customColors, double balanceDue) {
    return Card(
      color: customColors.bgBackground,
      elevation: 0,
      child: Column(
        children: [
          _buildRow(
              title: 'Subtotal',
              value: 'Rs.${_totalAmount.toStringAsFixed(2)}'),
          Gap(12.h),
          Divider(height: 1.h, color: customColors.borderSoft),
          Gap(12.h),
          _buildRow(title: 'Tax (0%)', value: 'Rs.0.00'),
          Gap(12.h),
          _buildRow(
              title: 'Total Amount',
              value: 'Rs.${_totalAmount.toStringAsFixed(2)}',
              valueStyle:
                  bodybodymdmedium.copyWith(fontWeight: FontWeight.bold)),
          Gap(17.h),
          Row(
            children: [
              Checkbox(
                value: _isPaymentReceived,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isPaymentReceived = newValue!;
                    _receivedAmount = _isPaymentReceived ? _totalAmount : 0.0;
                  });
                },
              ),
              Gap(4.w),
              CustomText(
                text: 'Receive Amount',
                myStyle: bodybodysmdefault,
              ),
              const Spacer(),
              SizedBox(
                width: 100.w,
                child: KTextField(
                  controller: TextEditingController(
                      text: _receivedAmount.toStringAsFixed(2)),
                  onChanged: (value) {
                    final amount = double.tryParse(value) ?? 0.0;
                    setState(() {
                      _receivedAmount = amount.clamp(0.0, _totalAmount);
                      _isPaymentReceived = _receivedAmount == _totalAmount;
                    });
                  },
                ),
              ),
            ],
          ),
          Gap(17.h),
          _buildRow(
            title: 'Balance Due',
            value: 'Rs.${balanceDue.toStringAsFixed(2)}',
            valueStyle: bodybodymdmedium.copyWith(
                color: balanceDue > 0
                    ? customColors.fillError
                    : customColors.fillSuccess),
          ),
          Gap(17.h),
          GestureDetector(
            onTap: _pickDueDate,
            child: _buildRow(
              title: 'Due Date',
              value: _selectedDueDate != null
                  ? _formatDate(_selectedDueDate!)
                  : 'Set Date >',
            ),
          ),
          Gap(17.h),
          GestureDetector(
            onTap: _selectPaymentMode,
            child: _buildRow(
              title: 'Payment Mode',
              value: '$_paymentMode >',
            ),
          ),
        ],
      ).addPadding(EdgeInsets.all(16.w)),
    );
  }

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

  Future<void> _showAddItemSheet(BuildContext context, AppColors customColors) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: customColors.bgBackground,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              final units = int.tryParse(_unitsController.text) ?? 0;
              final rate = double.tryParse(_rateController.text) ?? 0.0;
              final itemTotal = units * rate;

              return Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: customColors.borderSoft,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                      ),
                    ),
                    Gap(12.h),
                    CustomText(
                      text: 'Add Item',
                      myStyle: headingheadingmd,
                    ),
                    Gap(16.h),
                    CustomText(
                      text: 'Item Name',
                      myStyle: bodybodysmmedium,
                    ),
                    Gap(4.h),
                    KTextField(
                      controller: _itemNameController,
                      placeholder: 'e.g. Web Development',
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'Units'),
                              Gap(4.h),
                              KTextField(
                                controller: _unitsController,
                                placeholder: '1',
                                onChanged: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                        Gap(16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'Rate (Rs.)'),
                              Gap(4.h),
                              KTextField(
                                controller: _rateController,
                                placeholder: '1000',
                                onChanged: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Card(
                      color: customColors.borderSoft,
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'Item Total'),
                            CustomText(text: 'Rs.$itemTotal'),
                          ],
                        ),
                      ),
                    ),
                    Gap(16.h),
                    CustomButton(
                      height: 48.h,
                      title: 'Add Item',
                      titleColor: itemTotal > 0
                          ? customColors.brandSecondary!
                          : customColors.textTeritary!,
                      buttonColor: itemTotal > 0
                          ? customColors.brandPrimary!
                          : customColors.borderSoft!,
                      onTap: itemTotal > 0
                          ? () {
                              setState(() {
                                _items.add({
                                  'name': _itemNameController.text,
                                  'units': units,
                                  'rate': rate,
                                  'total': itemTotal,
                                });
                                _totalAmount += itemTotal;
                                _itemNameController.clear();
                                _unitsController.clear();
                                _rateController.clear();
                              });
                              Navigator.pop(context);
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showChangeClientDialog(AppColors customColors) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        final clientController =
            TextEditingController(text: _clientNameController.text);
        final projectController =
            TextEditingController(text: _projectNameController.text);

        return AlertDialog(
          title: CustomText(text: 'Change Client'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KTextField(
                controller: clientController,
                placeholder: 'Client Name',
              ),
              Gap(16.h),
              KTextField(
                controller: projectController,
                placeholder: 'Project Name',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, {
                  'client': clientController.text,
                  'project': projectController.text,
                });
              },
              child: CustomText(text: 'Save'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _clientNameController.text = result['client'];
        _projectNameController.text = result['project'];
      });
    }
  }

  Future<void> _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedDueDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
    }
  }

  Future<void> _selectPaymentMode() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Cash'),
              onTap: () => Navigator.pop(context, 'Cash'),
            ),
            ListTile(
              title: const Text('Bank Transfer'),
              onTap: () => Navigator.pop(context, 'Bank Transfer'),
            ),
            ListTile(
              title: const Text('Credit Card'),
              onTap: () => Navigator.pop(context, 'Credit Card'),
            ),
            ListTile(
              title: const Text('Digital Wallet'),
              onTap: () => Navigator.pop(context, 'Digital Wallet'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _paymentMode = result;
      });
    }
  }

  String _getInitials(String name) {
    final names = name.split(' ');
    if (names.length > 1) {
      return '${names[0][0]}${names[1][0]}';
    } else if (name.isNotEmpty) {
      return name[0];
    }
    return '';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
