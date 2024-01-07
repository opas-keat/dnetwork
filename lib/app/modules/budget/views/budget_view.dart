import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../api/api_params.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/budget_controller.dart';
import 'budget_layout_large.dart';
import 'budget_layout_small.dart';
import 'budget_search.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BudgetController());
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "งบประมาณรายปี",
                color: Colors.white,
                scale: 0.9,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.currentPage = 1;
                    controller.listBudgetStatistics.clear();
                    controller.offset.value = int.parse(queryParamOffset);
                    Get.toNamed(Routes.MANAGE_BUDGET);
                  },
                  icon: const Icon(
                    Icons.add_sharp,
                  ),
                ),
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
