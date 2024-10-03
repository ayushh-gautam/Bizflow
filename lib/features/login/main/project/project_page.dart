import 'package:bizflow/core/common/text.dart';
import 'package:flutter/material.dart';


class ProjectPages extends StatelessWidget {
  const ProjectPages({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(child: CustomText(text: 'Project Page'),),
    );
  }
}