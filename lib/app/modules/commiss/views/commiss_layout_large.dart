import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../data/models/summary_chart.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/commiss_controller.dart';
import 'commiss_statistics.dart';

class CommissLayoutLarge extends StatelessWidget {
  const CommissLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommissController());
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
                      // command pdf , docx
                      // list_commiss_l_2 pdf,xlsx,docx
                      String reportName = 'command'; //
                      String output = 'pdf';
                      String province = 'จันทบุรี';
                      String tambol = 'เกาะขวาง';
                      String whereTambol = "";
                      // _tambol.isNotEmpty
                      //     ? whereTambol = "&TAMBOL=" + _tambol
                      //     : whereTambol = "";
                      String whereName = "";
                      // commissFirstName.text.isNotEmpty
                      //     ? whereName = "&NAME=" + commissFirstName.text
                      //     : whereName = "";
                      String whereLastName = "";
                      // commissSurName.text.isNotEmpty
                      //     ? whereLastName = "&LASTNAME=" + commissSurName.text
                      //     : whereLastName = "";
                      String wherePosition = "";
                      // _position.isNotEmpty
                      //     ? wherePosition = "&POSITION=" + _position
                      //     : wherePosition = "";
                      String whereTel = "";
                      // commissTelephone.text.isNotEmpty
                      //     ? whereTel = "&TEL=" + commissTelephone.text
                      //     : whereTel = "";
                      // reportUrl =
                      //     "https://d-network.ect.go.th/report/flow.html?_flowId=viewReportFlow&_flowId=viewReportFlow&ParentFolderUri=%2Freports%2FECT&reportUnit=%2Freports%2FECT%2F" +
                      //         reportName +
                      //         "&standAlone=true&j_username=jasperadmin&j_password=jasperadmin&decorate=no&output=" +
                      //         output +
                      //         "&PROVINCE=" +
                      //         _province +
                      //         whereTambol +
                      //         whereName +
                      //         whereLastName +
                      //         wherePosition +
                      //         whereTel +
                      //         "&INFO_NAME=" +
                      //         _infoName;
                      String reportUrl =
                          "https://d-network.ect.go.th/report/flow.html?_flowId=viewReportFlow&_flowId=viewReportFlow&ParentFolderUri=%2Freports%2FECT&reportUnit=%2Freports%2FECT%2Fcommand&standAlone=true&j_username=jasperadmin&j_password=jasperadmin&decorate=no&output=$output&PROVINCE=$province&TAMBOL=$tambol";
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
                      Get.toNamed(Routes.MANAGE_COMMISS);
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(),
              const SizedBox(height: defaultPadding / 2),
              CommissStatistics(),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.listCommiss();
                },
                label: "แสดงข้อมูลเพิ่ม",
                labelStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: MainChart(
              header: "สถิติข้อมูลกรรมกา ศส.ปชต.",
              subHeader: "ตำแหน่งกรรมการ",
              listSummaryChart: summaryCommissChart,
            ),
          ),
        ),
      ],
    );
  }
}
