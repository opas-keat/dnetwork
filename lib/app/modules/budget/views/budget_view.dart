import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/budget_controller.dart';

class BudgetView extends GetView<BudgetController> {
  BudgetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              child: MainDrawer(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Header(moduleName: "งบประมาณ รายรับ-รายจ่าย"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "กกต ส่วนกลาง",
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    const Spacer(flex: 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.insert_drive_file_sharp,
                                      ),
                                      label: const Text('รายงาน'),
                                    ),
                                    const SizedBox(width: defaultPadding / 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.add_sharp,
                                      ),
                                      label: const Text('เพิ่ม'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                Responsive(
                                  smallScreen: InfoCard(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.0,
                                    listSummaryInfo: listBudgetSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listBudgetSummaryInfo,
                                  ),
                                ),
                                // const SizedBox(height: defaultPadding),
                                // StatisticsDashboard(),
                                // Spacer(),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
                            child: Container(
                              color: Colors.amber,
                              // height: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
