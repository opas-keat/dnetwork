import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../../training/controllers/training_controller.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_search.dart';
import 'dashboard_statistics.dart';

class DashboardLayoutLarge extends StatelessWidget {
  const DashboardLayoutLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.find<DashboardController>();
    final controller = Get.put(TrainingController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShowProvince(),
                  const Spacer(flex: 2),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search_sharp,
                    ),
                    label: const CustomText(
                      text: "ค้นหา",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding / 2),
                    ),
                    onPressed: () {
                      Get.dialog(
                        DashboardSearch(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  DropdownButton(
                    items: dashboardController.listReportType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomText(
                          text: 'รายงาน $value',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (dashboardController.reportProvince.value == "") {
                        dashboardController.reportProvince.value =
                            window.sessionStorage["province"]!;
                      }
                      report(
                        'main_info_l',
                        value.toString().toLowerCase(),
                        dashboardController.reportProvince.value,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        dashboardController.reportStationNo.value,
                      );
                      // if (dashboardController.reportProvince.isEmpty) {
                      //   Get.dialog(
                      //     AlertDialog(
                      //       content: const Text('กรุณาค้นหา จังหวัด'),
                      //       actions: [
                      //         TextButton(
                      //           child: const Text("ปิด"),
                      //           onPressed: () => Get.back(),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // } else {
                      //   report(
                      //     'main_info_l',
                      //     value.toString().toLowerCase(),
                      //     dashboardController.reportProvince.value,
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     '',
                      //     dashboardController.reportStationNo.value,
                      //   );
                      // }
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              const InfoCard(),
              // Responsive(
              //   smallScreen: InfoCard(
              //     crossAxisCount: 2,
              //     childAspectRatio: 2.0,
              //     listSummaryInfo: listDashboardSummaryInfo,
              //   ),
              //   largeScreen: InfoCard(
              //     childAspectRatio: 2.2,
              //     listSummaryInfo: listDashboardSummaryInfo,
              //   ),
              // ),
              const SizedBox(height: defaultPadding),
              DashboardStatistics(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<TrainingController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                      subHeader: "ประเภทการอบรม",
                      listSummaryChart: controller.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
            //   subHeader: "ประเภทการอบรม",
            //   listSummaryChart: summaryDashboardChart,
            // ),
          ),
        ),
      ],
    );
  }
}
