import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/village_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../controllers/village_controller.dart';

class VillageLayoutSmall extends StatelessWidget {
  VillageLayoutSmall({
    super.key,
  });
  final VillageController controller = Get.find<VillageController>();

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
                    text: 'รายงาน $value',
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
          // listSummaryInfo: listVillageSummaryInfo,
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
                      text: "ข้อมูลหมู่บ้านพลเมืองดีวิถีประชาธิปไตย",
                      weight: FontWeight.bold,
                      size: 16,
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
                                controller.listVillageStatistics.clear();
                                controller.villageName.text = '';
                                controller.villageNo.text = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.addressController.selectedAmphure
                                    .value = '';
                                controller.addressController.selectedTambol
                                    .value = '';
                                controller.listVillage();
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
                    itemCount:
                        controller.listVillageStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return VillageStatisticsSmallRow(
                          index, controller.listVillageStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลหมู่บ้าน วิถี ประชาธิปไตย",
          subHeader: "ระดับจังหวัด",
          listSummaryChart: summaryVillageChart,
        ),
      ],
    );
  }
}

Widget VillageStatisticsSmallRow(
  int index,
  VillageData villageData,
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
                text: "ชื่อหมู่บ้าน : ${villageData.villageName} ",
                scale: 0.9,
              ),
              CustomText(
                text: "หมู่ที่/บ้านเลขที่ : ${villageData.villageNo}",
                scale: 0.9,
              ),
              CustomText(
                text:
                    "จังหวัด/อำเภอ/ตำบล : ${villageData.province!}/${villageData.amphure!}/${villageData.district!}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text:
                    "จำนวนครัวเรือน : ${formatterItem.format(villageData.villageTotal)}",
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
