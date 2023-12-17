import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../api/api_params.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/commiss_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../controllers/commiss_controller.dart';

class CommissLayoutSmall extends StatelessWidget {
  CommissLayoutSmall({
    super.key,
  });
  final CommissController controller = Get.find<CommissController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ShowProvince(),
            const Spacer(flex: 2),
            DropdownButton(
              items: controller.listReportType
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    text: value,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (controller.reportProvince.isEmpty) {
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
                  String reportName = 'command';
                  if (value!.split(' ').first == 'รายงาน') {
                    reportName = 'list_commiss_l_2';
                  }
                  report(
                    reportName,
                    value.split(' ').last.toString().toLowerCase(),
                    controller.reportProvince.value,
                    controller.reportAmphure.value,
                    controller.reportDistrict.value,
                    controller.reportFirstName.value,
                    controller.reportSurName.value,
                    controller.reportPosition.value,
                    controller.reportTel.value,
                    controller.reportCommissAffiliateName.value,
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
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listCommissSummaryInfo,
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
                Row(
                  children: [
                    const CustomText(
                      text: "ข้อมูลกรรมการ ศส.ปชต.",
                      weight: FontWeight.bold,
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.refresh_sharp,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                controller.offset.value = 0;
                                controller.currentPage = 1;
                                controller.listCommissStatistics.clear();
                                controller.commissFirstName.text = '';
                                controller.commissSurName.text = '';
                                controller.commissTelephone.text = '';
                                controller.selectedCommissPosition.value = '';
                                controller.commissStationName.text = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.addressController.selectedAmphure
                                    .value = '';
                                controller.addressController.selectedTambol
                                    .value = '';
                                controller.defaultCommissOrder =
                                    queryParamOrderBy;
                                controller.listCommiss();
                              },
                              icon: const Icon(
                                Icons.refresh_sharp,
                              ),
                              color: primaryColor,
                            ),
                    ),
                  ],
                ),
                accentDividerTop,
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.listCommissStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return CommissStatisticsSmallRow(
                          index, controller.listCommissStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลกรรมการ ศส.ปชต.",
          subHeader: "ตำแหน่งกรรมการ",
          listSummaryChart: summaryCommissChart,
        ),
      ],
    );
  }
}

Widget CommissStatisticsSmallRow(
  int index,
  CommissData commissData,
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
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    "ชื่อ-นามสกุล : ${commissData.commissFirstName!} ${commissData.commissSurName!} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทร : ${commissData.telephone}",
                scale: 0.9,
              ),
              CustomText(
                text: "ตำแหน่ง : ${commissData.position}",
                scale: 0.9,
              ),
              CustomText(
                text: "ว/ด/ป/ แต่งตั้ง : ${commissData.commissDate}",
                scale: 0.9,
              ),
              CustomText(
                text: "สังกัด ศส.ปชต. : ${commissData.commissLocation}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text:
                    "จังหวัด/อำเภอ/ตำบล : ${commissData.province}/${commissData.amphure}/${commissData.district}",
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
