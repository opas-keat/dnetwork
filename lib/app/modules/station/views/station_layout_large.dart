import 'dart:html';

import 'package:flutter/material.dart';
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
                    onPressed: () {
                      // list_info_l pdf,xlsx,docx
                      String reportName = 'list_info_l';
                      String output = 'pdf'; //pdf xlsx docx
                      String province = 'จันทบุรี';
                      String tambol = 'เกาะขวาง';
                      String whereName = "";
                      // infoNameController.text.isNotEmpty
                      //     ? whereName = "&NAME=" + infoNameController.text
                      //     : whereName = "";
                      String whereLocation = "";
                      // infoLocationController.text.isNotEmpty
                      //     ? whereLocation =
                      //         "&LOCATION=" + infoLocationController.text
                      //     : whereLocation = "";
                      String whereAmphure = "";
                      // _amphure.isNotEmpty
                      //     ? whereAmphure = "&AMPHURE=" + _amphure
                      //     : whereAmphure = "";
                      String whereTambol = "";
                      // _district.isNotEmpty
                      //     ? whereTambol = "&TAMBOL=" + _district
                      //     : whereTambol = "";
                      String reportUrl =
                          "https://d-network.ect.go.th/report/flow.html?_flowId=viewReportFlow&_flowId=viewReportFlow&ParentFolderUri=%2Freports%2FECT&reportUnit=%2Freports%2FECT%2F$reportName&standAlone=true&j_username=jasperadmin&j_password=jasperadmin&decorate=no&output=$output&PROVINCE=$province$whereName$whereLocation$whereAmphure$whereTambol";
                      window.open(reportUrl, "report");
                    },
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
                      Get.toNamed(Routes.MANAGE_STATION);
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
