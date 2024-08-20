import 'package:bizflow/common/components/text.dart';
import 'package:flutter/material.dart';


class ProjectPages extends StatelessWidget {
  const ProjectPages({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CustomText(text: 'Project Page'),),
    );
  }
}