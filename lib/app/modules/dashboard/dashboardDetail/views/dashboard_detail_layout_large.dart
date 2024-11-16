import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_chart.dart';
import '../../../../shared/show_province.dart';
import '../../../training/controllers/training_controller.dart';
import '../controllers/dashboard_detail_controller.dart';

class DashboardDetailLayoutLarge extends StatelessWidget {
  const DashboardDetailLayoutLarge({super.key});
  @override
  Widget build(BuildContext context) {
    final DashboardDetailController controller =
        Get.find<DashboardDetailController>();
    final trainingController = Get.put(TrainingController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowProvince(),
                  Spacer(flex: 2),
                  SizedBox(width: defaultPadding / 2),
                ],
              ),
              const SizedBox(height: defaultPadding),
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
              // DashboardStatistics(),
              // แถวบนสุด
              Row(
                children: [
                  Image.network(
                    "assets/images/seal/Seal_Bangkok.png",
                    height: 60,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Expanded(
                    child: Container(
                      height: 80, // ขนาดคงที่
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: defaultPadding / 2),
                            child: Wrap(
                              direction: Axis.vertical,
                              runAlignment: WrapAlignment.start,
                              children: [
                                Text(
                                  "ชื่อ ศส.ปชต. :กรุงเทพมหานตร",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ที่ตั้ง :กรุงเทพมหานตร",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ชื่อ ศส.ปชต. : กรุงเทพมหานตร",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Facebook/Location: กรุงเทพมหานตร",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<TrainingController>(
                        builder: (_) => trainingController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : MainChart(
                                header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                                subHeader: "ประเภทการอบรม",
                                listSummaryChart:
                                    trainingController.summaryChart.obs.value,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<TrainingController>(
                        builder: (_) => trainingController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : MainChart(
                                header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                                subHeader: "ประเภทการอบรม",
                                listSummaryChart:
                                    trainingController.summaryChart.obs.value,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100, // ขนาดคงที่
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "Top Row (Fixed Height)",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<TrainingController>(
              builder: (_) => trainingController.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                      subHeader: "ประเภทการอบรม",
                      listSummaryChart:
                          trainingController.summaryChart.obs.value,
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
