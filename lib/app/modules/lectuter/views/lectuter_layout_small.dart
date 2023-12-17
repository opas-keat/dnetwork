import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/lectuter_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../controllers/lectuter_controller.dart';

class LectuterLayoutSmall extends StatelessWidget {
  const LectuterLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectuterController());
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
                    'list_lectuter_info_l',
                    value.toString().toLowerCase(),
                    controller.reportProvince.value,
                    controller.reportAmphure.value,
                    controller.reportDistrict.value,
                    controller.reportLectuterName.value,
                    controller.reportLectuterSurName.value,
                    '',
                    controller.reportLectuterTel.value,
                    '',
                    '',
                    controller.reportLectuterAgency.value,
                    controller.reportLectuterAffiliate.value,
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
          // listSummaryInfo: listLectuterSummaryInfo,
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
                      text: "ข้อมูลวิทยากรประชาธิปไตย",
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
                                controller.listLectuterStatistics.clear();
                                controller.lectuterFirstName.text = '';
                                controller.lectuterSurName.text = '';
                                controller.lectuterTelephone.text = '';
                                controller.lectuterAgency.text = '';
                                controller.selectedLectuterAffiliate.value = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.addressController.selectedAmphure
                                    .value = '';
                                controller.addressController.selectedTambol
                                    .value = '';
                                controller.listLectuter();
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
                        controller.listLectuterStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return LectuterStatisticsSmallRow(
                          index, controller.listLectuterStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        GetBuilder<LectuterController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลวิทยากรของ ศส.ปชต.",
                  subHeader: "ประเภทวิทยากร",
                  listSummaryChart: controller.summaryChart.obs.value,
                ),
        ),
        // MainChart(
        //   header: "สถิติข้อมูลวิทยากรประชาธิปไตย",
        //   subHeader: "สังกัดวิทยากร",
        //   listSummaryChart: summaryLectuterChart,
        // ),
      ],
    );
  }
}

Widget LectuterStatisticsSmallRow(
  int index,
  LectuterData lectuterData,
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
                text: "ชื่อ-นามสกุล : ${lectuterData.name} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทรศัพท์ : ${lectuterData.lectuterTelephone} ",
                scale: 0.9,
              ),
              CustomText(
                text: "หน่วยงาน : ${lectuterData.lectuterAgency}",
                scale: 0.9,
              ),
              CustomText(
                text: "สังกัดวิทยากร : ${lectuterData.lectuterAffiliate}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text: "จังหวัด : ${lectuterData.province}",
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
