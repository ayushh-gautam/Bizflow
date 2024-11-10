import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/presentation/pages/add_client_page.dart';
import 'package:flutter/material.dart';

import '../../widget/user_card.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
        backgroundColor: customColors.bgSecondary,
        appBar: AppBar(
          title: CustomText(
            text: 'Clients',
            myStyle: headingheadinglg.copyWith(color: customColors.textDefault),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomButton(
          title: 'Add Client',
          width: 170.w,
          titleColor: customColors.brandSecondary!,
          buttonColor: customColors.brandPrimary!,
          leading: Icon(
            Icons.add,
            color: customColors.brandSecondary!,
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return const AddClientPage();
            }));
          },
        ),
        body: Column(
          children: <Widget>[
            Gap(16.h),

            //searchh icon

            const UserCard(
                userName: 'Yogesh',
                email: 'xyz@gmail.com',
                totalProjects: '10',
                invoiceAmount: '220000',
                projectStatus: 'Complete',
                userImageUrl: ''),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)));
  }
}
