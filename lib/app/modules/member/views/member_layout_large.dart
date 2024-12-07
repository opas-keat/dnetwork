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
import '../controllers/member_controller.dart';
import 'member_search.dart';
import 'member_statistics.dart';

class MemberLayoutLarge extends StatelessWidget {
  const MemberLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
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
                      Get.toNamed(Routes.MANAGE_MEMBER);
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
                        MemberSearch(),
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
                      if (controller.reportStationName.isEmpty &&
                          controller.reportProvince.isEmpty &&
                          controller.reportAmphure.isEmpty &&
                          controller.reportDistrict.isEmpty) {
                        Get.dialog(
                          AlertDialog(
                            content: const Text(
                                'กรุณาค้นหา ศส.ปชต. และ จังหวัด/อำเภอ/ตำบล'),
                            actions: [
                              TextButton(
                                child: const Text("ปิด"),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                        );
                      } else {
                        String reportName = 'list_member_l';
                        if (value!.split(' ').first == 'รายงาน') {
                          reportName = 'list_member_l';
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
                          controller.reportStationName.value,
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
              MemberStatistics(),
              const SizedBox(height: defaultPadding / 2),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.listMember();
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
            child: GetBuilder<MemberController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
                      subHeader: "ตำแหน่งสมาชิก",
                      listSummaryChart: controller.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
            //   subHeader: "ตำแหน่งสมาชิก",
            //   listSummaryChart: summaryMemberChart,
            // ),
          ),
        ),
      ],
    );
  }
}
