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
import '../../../shared/utils.dart';
import '../controllers/village_controller.dart';
import 'village_search.dart';
import 'village_statistics.dart';

class VillageLayoutLarge extends StatelessWidget {
  const VillageLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VillageController());
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
                      Get.toNamed(Routes.MANAGE_VILLAGE);
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
                        VillageSearch(),
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
                          text: 'รายงาน $value',
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
                        report(
                          'list_village_hosty_l',
                          value.toString().toLowerCase(),
                          controller.reportProvince.value,
                          controller.reportAmphure.value,
                          controller.reportDistrict.value,
                          controller.reportVillageName.value,
                          '',
                          '',
                          '',
                          '',
                          controller.reportVillageNo.value,
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
              VillageStatistics(),
              const SizedBox(height: defaultPadding / 2),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.listVillage();
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
            child: MainChart(
              header: "สถิติข้อมูลหมู่บ้าน วิถี ประชาธิปไตย",
              subHeader: "ระดับจังหวัด",
              listSummaryChart: summaryVillageChart,
            ),
          ),
        ),
      ],
    );
  }
}
