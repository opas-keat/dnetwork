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
import '../../../shared/utils.dart';
import '../controllers/commiss_controller.dart';
import 'commiss_search.dart';
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
                        CommissSearch(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                  const SizedBox(width: defaultPadding / 2),
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
                        String reportName = 'command';
                        String district = controller.reportDistrict.value;
                        if (value!.split(' ').first == 'รายงาน') {
                          reportName = 'list_commiss_l_2';
                        }else{
                          district = 'ตำบล${controller.reportDistrict.value}';
                        }

                        report(
                          reportName,
                          value.split(' ').last.toString().toLowerCase(),
                          controller.reportProvince.value,
                          controller.reportAmphure.value,
                          district,
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
            child: GetBuilder<CommissController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลกรรมกา ศส.ปชต.",
                      subHeader: "ตำแหน่งกรรมการ ",
                      listSummaryChart: controller.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลกรรมกา ศส.ปชต.",
            //   subHeader: "ตำแหน่งกรรมการ",
            //   listSummaryChart: summaryCommissChart,
            // ),
          ),
        ),
      ],
    );
  }
}
