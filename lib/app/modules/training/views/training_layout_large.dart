import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../controllers/training_controller.dart';
import 'training_statistics.dart';

class TrainingLayoutLarge extends StatelessWidget {
  const TrainingLayoutLarge({
    super.key,
  });

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
                    text: "",
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
                  const SizedBox(width: defaultPadding / 2),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_sharp,
                    ),
                    label: const CustomText(
                      text: "เพิ่ม/แก้ไข",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding / 2),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.MANAGE_TRAINING);
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(
                childAspectRatio: 2.2,
                // listSummaryInfo: listTrainingSummaryInfo,
                textScale: 1.4,
              ),
              const SizedBox(height: defaultPadding / 2),
              TrainingStatistics(),
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
            //   listSummaryChart: summaryTrainingChart,
            // ),
          ),
        ),
      ],
    );
  }
}
