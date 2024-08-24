import 'package:bizflow/common/components/text.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomText(text: 'Invoice Page'),
      ),
    );
  }
}
