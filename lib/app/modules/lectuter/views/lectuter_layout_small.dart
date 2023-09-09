import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/lectuter_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/lectuter_controller.dart';

class LectuterLayoutSmall extends StatelessWidget {
  const LectuterLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectuterController());
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ShowProvince(),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              icon: const Icon(
                Icons.insert_drive_file_sharp,
                size: 16,
              ),
              label: const CustomText(
                text: "รายงาน",
                color: Colors.white,
                scale: 0.9,
              ),
            ),
            const SizedBox(width: defaultPadding / 2),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add_sharp,
                size: 16,
              ),
              label: const CustomText(
                text: "เพิ่ม/แก้ไข",
                color: Colors.white,
                scale: 0.9,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              onPressed: () {
                Get.toNamed(Routes.MANAGE_LECTUTER);
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listLectuterSummaryInfo,
        ),
        const SizedBox(height: defaultPadding / 2),
        Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  children: [
                    CustomText(
                      text: "ข้อมูลวิทยากรประชาธิปไตย",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                accentDivider,
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.listLectuterStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return LectuterStatisticsSmallRow(
                          index, controller.listLectuterStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        GetBuilder<LectuterController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลวิทยากรของ ศส.ปชต.",
                  subHeader: "ประเภทวิทยากร",
                  listSummaryChart: controller.summaryChart.obs.value,
                ),
        ),
        // MainChart(
        //   header: "สถิติข้อมูลวิทยากรประชาธิปไตย",
        //   subHeader: "สังกัดวิทยากร",
        //   listSummaryChart: summaryLectuterChart,
        // ),
      ],
    );
  }
}

Widget LectuterStatisticsSmallRow(
  int index,
  LectuterData lectuterData,
) {
  return Row(
    children: [
      // Image.network(
      //   "assets/images/seal/${provinceSummary.seal}",
      //   height: 38,
      // ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "ชื่อ-นามสกุล : ${lectuterData.name} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทรศัพท์ : ${lectuterData.lectuterTelephone} ",
                scale: 0.9,
              ),
              CustomText(
                text: "หน่วยงาน : ${lectuterData.lectuterAgency}",
                scale: 0.9,
              ),
              CustomText(
                text: "สังกัดวิทยากร : ${lectuterData.lectuterAffiliate}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text: "จังหวัด : ${lectuterData.province}",
                scale: 0.9,
              ),
              const SizedBox(height: defaultPadding / 4),
              accentDivider,
            ],
          ),
        ),
      ),
    ],
  );
}
