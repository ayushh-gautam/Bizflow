import 'package:bizflow/config/routes/imports.dart';
import 'package:bizflow/features/invoice/presentation/pages/tab_pages/all_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/tab_pages/draft_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/tab_pages/paid_page.dart';
import 'package:bizflow/features/invoice/presentation/pages/tab_pages/unpaid_page.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabPages.length,
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(text: 'Invoice'),
            bottom: TabBar(
                isScrollable: false,
                labelStyle: bodybodymddefault,
                indicatorSize: TabBarIndicatorSize.tab,
                
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Paid',
                  ),
                  Tab(
                    text: 'Unpaid',
                  ),
                  Tab(
                    text: 'Draft',
                  ),
                ]),
          ),
          body: TabBarView(children: tabPages),
        ));
  }
}

List<Widget> tabPages = [
  AllPage(),
  PaidPage(),
  UnpaidPage(),
  DraftPage(),
];
