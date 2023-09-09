import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../training/controllers/training_controller.dart';
import 'dashboard_statistics_small.dart';

class DashboardLayoutSmall extends StatelessWidget {
  const DashboardLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainingController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ShowProvince(),
            const Spacer(flex: 2),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              icon: const Icon(
                Icons.insert_drive_file_sharp,
              ),
              label: const CustomText(
                text: "รายงาน",
                color: Colors.white,
              ),
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
