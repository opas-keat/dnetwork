import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/station_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../training/controllers/training_controller.dart';
import '../controllers/station_controller.dart';

class StationLayoutSmall extends StatelessWidget {
  StationLayoutSmall({
    super.key,
  });
  final StationController stationController = Get.find<StationController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainingController());
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
                Get.toNamed(Routes.MANAGE_STATION);
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        const InfoCard(
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listStationSummaryInfo,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Row(
                  children: [
                    CustomText(
                      text: "ข้อมูลสถิติรายจังหวัด",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                accentDivider,
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stationController
                        .listStationStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return DashboardStatisticsSmallRow(index,
                          stationController.listStationStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
        //   listSummaryChart: summaryStationChart,
        // ),
      ],
    );
  }
}

Widget DashboardStatisticsSmallRow(
  int index,
  StationData stationData,
) {
  return Row(
    children: [
      // Image.network(
      //   "assets/images/seal/${provinceSummary.seal}",
      //   height: 38,
      // ),
      Expanded(
        flex: 8,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(
                    "ชื่อ : ${stationData.name} ",
                  ),
                  Text(
                    "ที่อยู่ : ${stationData.province!}/${stationData.amphure!}/${stationData.district!}",
                  ),
                  Text(
                    "จำนวนกรรมการ/สมาชิก : ${stationData.totalCommiss}/${stationData.totalMember}",
                  ),
                ],
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
