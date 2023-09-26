import 'package:flutter/material.dart';
import 'package:frontend/app/shared/utils.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../training/controllers/training_controller.dart';
import '../controllers/station_controller.dart';
import 'station_search.dart';
import 'station_statistics.dart';

class StationLayoutLarge extends StatelessWidget {
  const StationLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stationController = Get.put(StationController());
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
                      Get.toNamed(Routes.MANAGE_STATION);
                    },
                  ),
                  const SizedBox(width: defaultPadding / 2),
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
                        StationSearch(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                  const SizedBox(width: defaultPadding / 2),
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
                            content:
                                const Text('กรุณาค้นหา จังหวัด/อำเภอ/ตำบล'),
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
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(),
              const SizedBox(height: defaultPadding / 2),
              StationStatistics(),
              const SizedBox(height: defaultPadding / 2),
              CustomFlatButton(
                onPressed: () {
                  stationController.currentPage++;
                  stationController.offset.value =
                      ((stationController.currentPage *
                              int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  stationController.listStation();
                },
                label: "แสดงข้อมูลเพิ่ม",
                labelStyle: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: Column(
              children: [
                GetBuilder<TrainingController>(
                  builder: (_) => controller.isLoadingChart.value
                      ? const Center(child: CircularProgressIndicator())
                      : MainChart(
                          header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                          subHeader: "ประเภทการอบรม",
                          listSummaryChart: controller.summaryChart.obs.value,
                        ),
                ),
              ],
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
