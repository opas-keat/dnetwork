import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/incident_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/show_province.dart';
import '../controllers/incident_controller.dart';

class IncidentLayoutSmall extends StatelessWidget {
  const IncidentLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IncidentController());
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShowProvince(),
            Spacer(flex: 2),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listIncidentSummaryInfo,
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
                      text: "แจ้งปัญหาการใช้งาน",
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
                                controller.listIncidentStatistics.clear();
                                controller.list();
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
                        controller.listIncidentStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return IncidentStatisticsSmallRow(
                          index, controller.listIncidentStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
      ],
    );
  }
}

Widget IncidentStatisticsSmallRow(
  int index,
  IncidentData incidentData,
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
                text: "วันที่แจ้ง : ${incidentData.incidentDate} ",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text: "ผู้แจ้ง : ${incidentData.createdBy}",
                scale: 0.9,
              ),
              CustomText(
                text: "ระบบ : ${incidentData.incidentModule}",
                scale: 0.9,
              ),
              CustomText(
                text: "ปัญหา : ${incidentData.incidentTitle}",
                scale: 0.9,
              ),
              CustomText(
                text: "รายละเอียด : ${incidentData.incidentDetail}",
                scale: 0.9,
              ),
              CustomText(
                text: "วันที่แก้ไข : ${incidentData.resolvedDate}",
                scale: 0.9,
              ),
              CustomText(
                text: "รายละเอียดการแก้ไข : ${incidentData.resolvedDetail}",
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
