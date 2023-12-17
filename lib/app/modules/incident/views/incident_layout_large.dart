import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../controllers/incident_controller.dart';
import 'incident_add.dart';
import 'incident_statistics.dart';

class IncidentLayoutLarge extends StatelessWidget {
  const IncidentLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IncidentController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "",
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  const Spacer(flex: 2),
                  const SizedBox(width: defaultPadding / 2),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_sharp,
                    ),
                    label: const CustomText(
                      text: "แจ้งปัญหา",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding / 2),
                    ),
                    onPressed: () {
                      Get.dialog(
                        IncidentAdd(
                          editMode: false,
                        ),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              IncidentStatistics(),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.list();
                },
                label: "แสดงข้อมูลเพิ่ม",
                labelStyle: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: defaultPadding / 2),
        //     child: GetBuilder<IncidentController>(
        //       builder: (_) => controller.isLoadingChart.value
        //           ? const Center(child: CircularProgressIndicator())
        //           : MainChart(
        //               header: "สถิติข้อมูลวิทยากรของ ศส.ปชต.",
        //               subHeader: "ประเภทวิทยากร",
        //               listSummaryChart: controller.summaryChart.obs.value,
        //             ),
        //     ),
        //     // child: MainChart(
        //     //   header: "สถิติข้อมูลวิทยากรประชาธิปไตย",
        //     //   subHeader: "สังกัดวิทยากร",
        //     //   listSummaryChart: summaryIncidentChart,
        //     // ),
        //   ),
        // ),
      ],
    );
  }
}
