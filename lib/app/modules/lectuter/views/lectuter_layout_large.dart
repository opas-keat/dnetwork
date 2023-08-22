import 'package:flutter/material.dart';
import 'package:frontend/app/modules/lectuter/controllers/lectuter_controller.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import 'lectuter_statistics.dart';

class LectuterLayoutLarge extends StatelessWidget {
  const LectuterLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectuterController());
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
                    text: "จังหวัด กรุงเทพมหานคร",
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
                      Get.toNamed(Routes.MANAGE_LECTUTER);
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(
                childAspectRatio: 2.2,
                // listSummaryInfo: listLectuterSummaryInfo,
                textScale: 1.4,
              ),
              const SizedBox(height: defaultPadding / 2),
              LectuterStatistics(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<LectuterController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลวิทยากรของ ศส.ปชต.",
                      subHeader: "ประเภทวิทยากร",
                      listSummaryChart: controller.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลวิทยากรประชาธิปไตย",
            //   subHeader: "สังกัดวิทยากร",
            //   listSummaryChart: summaryLectuterChart,
            // ),
          ),
        ),
      ],
    );
  }
}
