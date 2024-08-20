import 'package:bizflow/common/components/text.dart';
import 'package:flutter/material.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: 'Client Page'),
      ),
    );
  }
}
