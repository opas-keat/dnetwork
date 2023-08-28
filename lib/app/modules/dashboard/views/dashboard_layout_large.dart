import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../training/controllers/training_controller.dart';
import 'dashboard_statistics.dart';

class DashboardLayoutLarge extends StatelessWidget {
  const DashboardLayoutLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const CustomText(
                    text: "กกต ส่วนกลาง",
                    weight: FontWeight.bold,
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
                    label: const CustomText(
                      text: "รายงาน",
                      color: Colors.white,
                    ),
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
