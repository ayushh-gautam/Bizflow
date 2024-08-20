import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/login/main/clients/client_page.dart';
import 'package:bizflow/features/login/main/home/home_page.dart';
import 'package:bizflow/features/login/main/invoice/invoice_page.dart';
import 'package:bizflow/features/login/main/project/project_page.dart';
import 'package:bizflow/features/login/main/settings/settings_page.dart';
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
    return Scaffold(
      body: myList[indexx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: customColors.bgBackground,
        currentIndex: indexx,
        onTap: (index) {
          setState(() {
            indexx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAsset.clients), label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAsset.projects), label: 'Projects'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAsset.clients), label: 'Clients'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(SvgAsset.invoice), label: 'Invoice'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(0),
              child: SvgPicture.asset(SvgAsset.projects),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
