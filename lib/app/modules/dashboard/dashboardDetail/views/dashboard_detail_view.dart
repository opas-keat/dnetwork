import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/header.dart';
import '../../../../shared/main_drawer.dart';
import '../../../budget/views/budget_layout_large.dart';
import '../../../budget/views/budget_layout_small.dart';
import '../controllers/dashboard_detail_controller.dart';
import 'dashboard_detail_layout_large.dart';

class DashboardDetailView extends StatelessWidget {
  const DashboardDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardDetailController());
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "รายละเอียด ศส.ปชต.",
                color: Colors.white,
                scale: 0.9,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // controller.currentPage = 1;
                    // controller.listBudgetStatistics.clear();
                    // controller.offset.value = int.parse(queryParamOffset);
                    Get.toNamed(Routes.DASHBOARD);
                  },
                  icon: const Icon(
                    Icons.add_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // talker.debug("search.");
                    // Get.dialog(
                    //   BudgetSearch(),
                    //   barrierDismissible: false,
                    // );
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
          // smallScreen: Container(
          //   padding: const EdgeInsets.all(defaultPadding / 2),
          //   // color: Colors.amber,
          //   child: SingleChildScrollView(
          //     primary: true,
          //     child: Column(
          //       children: [
          //         BudgetLayoutSmall(),
          //       ],
          //     ),
          //   ),
          // ),
          // mediumScreen: Container(
          //   padding: const EdgeInsets.all(defaultPadding),
          //   // color: Colors.amber,
          //   child: SingleChildScrollView(
          //     primary: true,
          //     child: Column(
          //       children: [
          //         BudgetLayoutSmall(),
          //       ],
          //     ),
          //   ),
          // ),
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
                    Header(moduleName: "dashboard"),
                    SizedBox(height: defaultPadding / 2),
                    // BudgetLayoutLarge(),
                    DashboardDetailLayoutLarge(),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             color: Colors.amber,
                    //             child: const CustomText(
                    //               text: "รายละเอียด ศส.ปชต.",
                    //               color: Colors.white,
                    //               scale: 0.9,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const Expanded(
                    //       child: Column(
                    //         children: [],
                    //       ),
                    //     ),
                    //     const Expanded(
                    //       child: Column(
                    //         children: [],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CustomText(
                      text: "รายละเอียด ศส.ปชต.",
                      color: Colors.white,
                      scale: 0.9,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
