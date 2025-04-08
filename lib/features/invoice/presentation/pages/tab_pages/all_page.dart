import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import 'package:bizflow/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:bizflow/features/invoice/presentation/pages/add_invoice_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/routes/imports.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  int? selectedStatus;
  final Set<String> selectedTags = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<InvoiceCubit>().fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoaded) {
            return Material(
              elevation: 0,
              child: CustomButton(
                title: 'New Invoice',
                width: 170.h,
                titleColor: customColors.brandSecondary!,
                buttonColor: customColors.brandPrimary!,
                leading: Icon(
                  Icons.add,
                  color: customColors.brandSecondary!,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddInvoicePage();
                  }));
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InvoiceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<InvoiceCubit>().fetchInvoices(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is InvoiceLoaded) {
            if (state.invoices.isEmpty) {
              return _buildEmptyState(customColors);
            } else {
              return _buildInvoiceList(customColors, state.invoices);
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyState(AppColors customColors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(40.h),
          SvgPicture.asset(SvgAsset.emptyInvoiceState),
          Gap(28.h),
          CustomText(
            text: 'Let\'s Create Your First Invoice',
            myStyle: headingheadingmd.copyWith(color: customColors.textDefault),
          ),
          Gap(6.h),
          CustomText(
            textAlign: TextAlign.center,
            text:
                'Add a new invoice to start tracking payments and managing your finances.',
            myStyle:
                bodybodymddefault.copyWith(color: customColors.textSecondary),
          ),
          Gap(8.h),
          CustomButton(
            height: 52.h,
            width: 120.h,
            style:
                bodybodymdmedium.copyWith(color: customColors.brandSecondary),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AddInvoicePage();
                },
              ));
            },
            leading: Icon(
              Icons.add,
              color: customColors.brandSecondary,
            ),
            title: 'New Invoice',
            titleColor: customColors.brandSecondary!,
            buttonColor: customColors.brandPrimary!,
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(AppColors customColors, List<Invoice> invoices) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: KTextField(
                controller: _searchController,
                leading: const Icon(Icons.search),
              ).addMargin(EdgeInsets.only(right: 10.w)),
            ),
            Container(
              alignment: Alignment.center,
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                color: customColors.bgBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () {
                  _showFilterModal(customColors);
                },
                icon: const Icon(Icons.filter, size: 20),
              ),
            ),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.w)),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoices[index];
              return GestureDetector(
                child: InvoiceCard(
                  invoiceName: invoice.fullName,
                  amount: invoice.amount,
                  projectName: invoice.projectName,
                  invoiceId: invoice.invoiceId,
                  issuedDate: invoice.issuedDate,
                  dueDate: invoice.dueDate,
                ).addMargin(EdgeInsets.only(bottom: 12.h)),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showFilterModal(AppColors customColors) {
    showModalBottomSheet(
      backgroundColor: customColors.bgBackground,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: double.infinity,
              height: 350.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(12.h),
                  const Center(child: Icon(Icons.remove)),
                  /*-----------------------FILTER BY STATUS----------------------------*/
                  CustomText(
                    text: 'Filter By Status',
                    myStyle: bodybodymdsemibold.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(12.h),
                  Row(
                    children: List.generate(
                      invoiceStatus.length,
                      (index) {
                        final isSelected = selectedStatus == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedStatus = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.h, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? customColors.brandPrimary
                                  : customColors.borderSolid,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isSelected)
                                  Icon(
                                    Icons.check,
                                    color: customColors.brandSecondary,
                                    size: 16,
                                  ).addMargin(const EdgeInsets.only(right: 4)),
                                CustomText(
                                  text: invoiceStatus[index],
                                  myStyle: TextStyle(
                                    color: isSelected
                                        ? customColors.brandSecondary
                                        : customColors.textDefault,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).addMargin(const EdgeInsets.only(right: 12));
                      },
                    ),
                  ),
                  Gap(24.h),
                  CustomText(
                    text: 'Tags',
                    myStyle: bodybodymdsemibold.copyWith(
                        color: customColors.textDefault),
                  ),
                  Gap(12.h),
                  Wrap(
                    spacing: 12.h,
                    runSpacing: 12.h,
                    children: List.generate(invoiceTags.length, (index) {
                      bool isSelectedd =
                          selectedTags.contains(invoiceTags[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelectedd) {
                              selectedTags.remove(invoiceTags[index]);
                            } else {
                              selectedTags.add(invoiceTags[index]);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.h, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isSelectedd
                                ? customColors.brandPrimary
                                : customColors.borderSolid,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelectedd)
                                Icon(
                                  Icons.check,
                                  color: customColors.brandSecondary,
                                  size: 16,
                                ).addMargin(const EdgeInsets.only(right: 4)),
                              CustomText(
                                text: invoiceTags[index],
                                myStyle: TextStyle(
                                    color: isSelectedd
                                        ? customColors.brandSecondary
                                        : customColors.textDefault),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Gap(32.h),
                  CustomButton(
                    onTap: () => Navigator.pop(context),
                    title: 'Apply Filter',
                    titleColor:
                        (selectedStatus != null || selectedTags.isNotEmpty)
                            ? customColors.brandSecondary!
                            : customColors.textTeritary!,
                    buttonColor:
                        (selectedStatus != null || selectedTags.isNotEmpty)
                            ? customColors.brandPrimary!
                            : customColors.borderSoft!,
                  ),
                ],
              ),
            ).addMargin(EdgeInsets.symmetric(horizontal: 16.h));
          },
        );
      },
    );
  }
}

const List<String> invoiceStatus = ['Paid', 'Unpaid', 'Overdue', 'Draft'];
const List<String> invoiceTags = [
  'Recurring',
  'One-time',
  'Project-based',
  'Hourly',
  'Fixed-price'
];
