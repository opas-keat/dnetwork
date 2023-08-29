import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import 'budget_layout_large.dart';
import 'budget_layout_small.dart';
import 'budget_search.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "งบประมาณ รายรับ-รายจ่าย",
                color: Colors.white,
                scale: 0.9,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // talker.debug("search.");
                    Get.dialog(
                      BudgetSearch(),
                      barrierDismissible: false,
                    );
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_sharp,
                  ),
                ),
              ],
            )
          : null,
      drawer: !Responsive.isLargeScreen(context) ? MainDrawer() : null,
      body: SafeArea(
        child: Responsive(
          smallScreen: Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  BudgetLayoutSmall(),
                ],
              ),
            ),
          ),
          mediumScreen: Container(
            padding: const EdgeInsets.all(defaultPadding),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  BudgetLayoutSmall(),
                ],
              ),
            ),
          ),
          largeScreen: Row(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => MainDrawer(),
                ),
              ),
              Expanded(
                flex: Responsive.isLargeScreen(context) ? 6 : 1,
                child: const Column(
                  children: [
                    Header(moduleName: "budget"),
                    SizedBox(height: defaultPadding / 2),
                    BudgetLayoutLarge(),
                  ],
                ),
                // child: LayoutBuilder(
                //   builder: (context, constraints) => Container(
                //     color: Colors.white,
                //     child: Align(
                //       alignment: Alignment.topCenter,
                //       child: SingleChildScrollView(
                //         padding:
                //             const EdgeInsets.only(left: defaultPadding / 2),
                //         primary: true,
                //         child: Column(
                //           children: [
                //             const Header(moduleName: "budget"),
                //             const SizedBox(height: defaultPadding / 2),
                //             // BudgetLayoutLarge(),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
