// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bizflow/config/routes/imports.dart';

class InvoiceCard extends StatelessWidget {
  final String invoiceName;
  final String amount;
  final String projectName;
  final String invoiceId;
  final DateTime? issuedDate;
  final DateTime? dueDate;
  const InvoiceCard({
    super.key,
    required this.invoiceName,
    required this.amount,
    required this.projectName,
    required this.invoiceId,
    required this.issuedDate,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Card(
      color: customColors.bgBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: invoiceName,
                    myStyle: bodybodymdsemibold,
                  ),
                  CustomText(
                    text: projectName,
                    myStyle: bodybodysmdefault,
                  ),
                  CustomText(
                      text: 'Issued ${issuedDate.toString().split(' ')[0]}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: amount,
                    myStyle: bodybodymdsemibold,
                  ),
                  CustomText(
                    text: invoiceId,
                    myStyle: bodybodysmdefault,
                  ),
                  CustomText(text: 'Due ${dueDate.toString().split(' ')[0]}'),
                ],
              )
            ],
          ),
        ],
      ).addMargin(EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
    );
  }
}
