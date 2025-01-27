import 'package:bizflow/features/invoice/data/model/invoice_model.dart';
import 'package:bizflow/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:bizflow/features/invoice/presentation/pages/add_invoice_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/invoice_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/routes/imports.dart';

class AllPage extends StatelessWidget {
  const AllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: customColors.bgSecondary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<InvoiceCubit, List<Invoice>>(
        builder: (context, clients) {
          return clients.isEmpty
              ? const SizedBox()
              : Material(
                  elevation: 5,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AddInvoicePage();
                      }));
                    },
                  ),
                );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: <Widget>[
              Gap(16.h),
              BlocBuilder<InvoiceCubit, List<Invoice>>(
                builder: (context, invoice) {
                  if (invoice.isEmpty) {
                    return _buildEmptyState(customColors, context);
                  } else {
                    return _buildInvoiceLIst(customColors, context, invoice);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInvoiceLIst(
    AppColors customColors, BuildContext context, List<Invoice> invoice) {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: 301.h,
            child: KTextField(
              controller: TextEditingController(),
              leading: const Icon(Icons.search),
            ),
          ),
          Gap(10.h),
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
                return null;
              },
              icon: const Icon(Icons.add_circle_outline_outlined, size: 20),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10.h,
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: invoice.length,
        itemBuilder: (context, index) {
          final data = invoice[index];
          return GestureDetector(
            child: InvoiceCard(
                invoiceName: data.fullName,
                amount: data.amount,
                projectName: data.projectName,
                invoiceId: data.invoiceId,
                issuedDate: data.issuedDate,
                dueDate: data.dueDate),
          );
        },
      ),
    ],
  );
}

Widget _buildEmptyState(AppColors customColors, BuildContext context) {
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
          style: bodybodymdmedium.copyWith(color: customColors.brandSecondary),
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
