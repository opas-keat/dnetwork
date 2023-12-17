import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../../training/controllers/training_controller.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_statistics_small.dart';

class DashboardLayoutSmall extends StatelessWidget {
  const DashboardLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainingController());
    final DashboardController dashboardController =
        Get.find<DashboardController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ShowProvince(),
            const Spacer(flex: 2),
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
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listDashboardSummaryInfo,
        ),
        const SizedBox(height: defaultPadding / 2),
        DashboardStatisticsSmall(),
        const SizedBox(height: defaultPadding / 2),
        GetBuilder<TrainingController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                  subHeader: "ประเภทการอบรม",
                  listSummaryChart: controller.summaryChart.obs.value,
                ),
        ),
        // MainChart(
        //   header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
        //   subHeader: "ประเภทการอบรม",
        //   listSummaryChart: summaryDashboardChart,
        // ),
      ],
    );
  }
}
