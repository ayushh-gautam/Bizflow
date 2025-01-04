import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/widget/inactive_badge.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox(
      width: 180.h,
      child: Card(
        color: customColors.bgBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ActiveInactiveBadge(width: 56.h, title: 'Active'),
            Gap(12.h),
            CustomText(
              text: 'Project 1',
              myStyle:
                  headingheadingsm.copyWith(color: customColors.textDefault),
            ),
            Gap(4.h),
            CustomText(
              text: '11 September, 2024',
              myStyle:
                  bodybodyxsdefault.copyWith(color: customColors.textTeritary),
            )
          ],
        ).addPadding(EdgeInsets.all(16.h)),
      ),
    );
  }
}
