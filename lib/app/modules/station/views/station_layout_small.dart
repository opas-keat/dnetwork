import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/station_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ShowProvince(),
            const Spacer(flex: 2),
            DropdownButton(
              items: stationController.listReportType
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    text: 'รายงาน $value',
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (stationController.reportProvince.isEmpty) {
                  Get.dialog(
                    AlertDialog(
                      content: const Text('กรุณาค้นหา จังหวัด/อำเภอ/ตำบล'),
                      actions: [
                        TextButton(
                          child: const Text("ปิด"),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  );
                } else {
                  report(
                    'list_info_l',
                    value.toString().toLowerCase(),
                    stationController.reportProvince.value,
                    stationController.reportAmphure.value,
                    stationController.reportDistrict.value,
                    stationController.reportStationName.value,
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                  );
                }
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
                Row(
                  children: [
                    const CustomText(
                      text: "ข้อมูล ศส.ปชต.",
                      weight: FontWeight.bold,
                    ),
                    Obx(
                      () => stationController.isLoading.value
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.refresh_sharp,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                stationController.offset.value = 0;
                                stationController.currentPage = 1;
                                stationController.listStationStatistics.clear();
                                stationController.name.text = '';
                                stationController.addressController
                                    .selectedProvince.value = '';
                                stationController.addressController
                                    .selectedAmphure.value = '';
                                stationController.addressController
                                    .selectedTambol.value = '';
                                stationController.listStation();
                              },
                              icon: const Icon(
                                Icons.refresh_sharp,
                              ),
                              color: primaryColor,
                            ),
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
