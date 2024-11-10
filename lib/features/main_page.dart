import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/clients/presentation/pages/client_page.dart';
import 'package:bizflow/features/home/home_page.dart';
import 'package:bizflow/features/invoice/invoice_page.dart';
import 'package:bizflow/features/project/project_page.dart';
import 'package:bizflow/features/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexx = 0;
  bool istapped = false;
  List myList = const [
    HomePage(),
    ProjectPages(),
    ClientPage(),
    InvoicePage(),
    SettingPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppColors>()!;

    getSvgIcon(String assetName, bool isSelected) {
      return SvgPicture.asset(
        assetName,
        color:
            isSelected ? customColors.textDefault : customColors.textSecondary,
      );
    }

    return Scaffold(
      body: myList[indexx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: customColors.bgBackground,
        selectedItemColor: customColors.brandPrimary,
        currentIndex: indexx,
        onTap: (index) {
          setState(() {
            indexx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: getSvgIcon(SvgAsset.home, false),
              activeIcon: getSvgIcon(SvgAsset.home, true),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: getSvgIcon(SvgAsset.projects, false),
              activeIcon: getSvgIcon(SvgAsset.projects, true),
              label: 'Projects'),
          BottomNavigationBarItem(
              icon: getSvgIcon(SvgAsset.clients, false),
              activeIcon: getSvgIcon(SvgAsset.clients, true),
              label: 'Clients'),
          BottomNavigationBarItem(
              icon: getSvgIcon(SvgAsset.invoice, false),
              activeIcon: getSvgIcon(SvgAsset.invoice, true),
              label: 'Invoice'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: getSvgIcon(SvgAsset.settings, false),
            ),
            label: 'Settings',
            activeIcon: getSvgIcon(SvgAsset.settings, true),
          )
        ],
      ),
    );
  }
}
