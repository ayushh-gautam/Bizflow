import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';
import 'package:bizflow/features/clients/presentation/pages/add_client_page.dart';
import 'package:bizflow/features/clients/presentation/pages/client_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        floatingActionButton:
            BlocBuilder<ClientCubit, List<Client>>(builder: (context, clients) {
          if (clients.isEmpty) {
            return SizedBox();
          } else {
            return CustomButton(
              title: 'Add Client',
              width: 170.h,
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
            );
          }
        }),
        body: Column(
          children: <Widget>[
            Gap(16.h),

            //searchh icon

            BlocBuilder<ClientCubit, List<Client>>(
              builder: (context, clients) {
                if (clients.isEmpty) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(40.h),
                        SvgPicture.asset(SvgAsset.emptyState),
                        Gap(28.h),
                        CustomText(
                          text: 'Let\'s Add your first Client',
                          myStyle: headingheadingmd.copyWith(
                              color: customColors.textDefault),
                        ),
                        Gap(6.h),
                        CustomText(
                          textAlign: TextAlign.center,
                          text:
                              'Add a new client to get started managing your projects.',
                          myStyle: bodybodymddefault.copyWith(
                              color: customColors.textSecondary),
                        ),
                        Gap(8.h),
                        CustomButton(
                            height: 52.h,
                            width: 120.h,
                            style: bodybodymdmedium.copyWith(
                                color: customColors.brandSecondary),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const AddClientPage();
                                },
                              ));
                            },
                            leading: Icon(
                              Icons.add,
                              color: customColors.brandSecondary,
                            ),
                            title: 'Add Client',
                            titleColor: customColors.brandSecondary!,
                            buttonColor: customColors.brandPrimary!)
                      ]).addMargin(EdgeInsets.symmetric(horizontal: 16.h));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: clients.length,
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ClientDetail(
                              clientt: client,
                            );
                          }));
                        },
                        child: UserCard(
                            userName: client.fullName,
                            email: client.email,
                            totalProjects: 10.toString(),
                            invoiceAmount: 3000.toString(),
                            projectStatus: 'Completed',
                            userImageUrl: ''),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ).addMargin(EdgeInsets.symmetric(horizontal: 16.w)));
  }
}
