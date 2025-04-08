import 'package:bizflow/features/clients/presentation/cubit/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/data/model/client_model.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';
import 'package:bizflow/features/clients/presentation/pages/add_client_page.dart';
import 'package:bizflow/features/clients/presentation/pages/client_detail_page.dart';
import '../../widget/user_card.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientCubit>().fetchClients();
  }

  int? selectedStatus;
  final Set<String> selectedTags = {};

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
        floatingActionButton: BlocBuilder<ClientCubit, ClientState>(
          builder: (context, state) {
            if (state is ClientAdded) {
              if (state.clients.isEmpty) {
                return SizedBox();
              } else {
                return Material(
                    elevation: 0,
                    child: CustomButton(
                      title: 'Add Client',
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
                          return const AddClientPage();
                        }));
                      },
                    ));
              }
            }
            return SizedBox();
          },
        ),
        body: BlocBuilder<ClientCubit, ClientState>(
          builder: (context, state) {
            if (state is ClientAdded) {
              if (state.clients.isEmpty) {
                return _buildEmptyState(customColors);
              } else {
                return _buildClientList(customColors, state.clients);
              }
            }
            return SizedBox();
          },
        ));
  }

  Widget _buildEmptyState(AppColors customColors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(40.h),
          SvgPicture.asset(SvgAsset.emptyState),
          Gap(28.h),
          CustomText(
            text: 'Let\'s Add your first Client',
            myStyle: headingheadingmd.copyWith(color: customColors.textDefault),
          ),
          Gap(6.h),
          CustomText(
            textAlign: TextAlign.center,
            text: 'Add a new client to get started managing your projects.',
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
            buttonColor: customColors.brandPrimary!,
          ),
        ],
      ),
    );
  }

  Widget _buildClientList(AppColors customColors, List<Client> clients) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: KTextField(
              controller: TextEditingController(),
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
        ]),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final client = clients[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClientDetail(
                    clientt: client,
                  );
                }));
              },
              child: UserCard(
                userName: client.fullName,
                email: client.email,
                totalProjects: '10',
                invoiceAmount: '3000',
                projectStatus: 'Completed',
                userImageUrl: '',
              ),
            );
          },
        ),
      ],
    ).addMargin(EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.w));
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
                      projectStatus.length,
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
                                  text: projectStatus[index],
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
                    children: List.generate(tags.length, (index) {
                      bool isSelectedd = selectedTags.contains(tags[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelectedd) {
                              selectedTags.remove(tags[index]);
                            } else {
                              selectedTags.add(tags[index]);
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
                                text: tags[index],
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

const List<String> projectStatus = ['Active', 'Inactive', 'Archive'];
const List<String> tags = [
  'Freelance',
  'Upwork',
  'Referral Client',
  'Local Client',
  'Foreign Client'
];
