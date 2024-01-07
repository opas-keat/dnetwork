import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/training_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../controllers/training_controller.dart';

class TrainingLayoutSmall extends StatelessWidget {
  const TrainingLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainingController());
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
                      text: "ข้อมูลการฝึกอบรม",
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
                                controller.listTrainingStatistics.clear();
                                controller.trainingName.text = '';
                                controller.trainingDateForm.text = '';
                                controller.trainingDateTo.text = '';
                                controller.trainingType.text = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.listTraining();
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
                        controller.listTrainingStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return TrainingStatisticsSmallRow(
                          index, controller.listTrainingStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        GetBuilder<TrainingController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                  subHeader: "ประเภทการอบรม",
                  listSummaryChart: controller.summaryChart.obs.value,
                ),
        ),
        // MainChart(
        //   header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
        //   subHeader: "ประเภทการอบรม",
        //   listSummaryChart: summaryTrainingChart,
        // ),
      ],
    );
  }
}

Widget TrainingStatisticsSmallRow(
  int index,
  TrainingData trainingData,
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
                text: "ชื่อโครงการฝึกอบรม : ${trainingData.trainingName} ",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text:
                    "ระหว่างวัน : ${trainingData.trainingDateForm!} ถึง ${trainingData.trainingDateTo!}",
                scale: 0.9,
              ),
              CustomText(
                text: "ประเภทการฝีกอบรม : ${trainingData.trainingType}",
                scale: 0.9,
              ),
              // CustomText(
              //   text:
              //       "สังกัด ศส.ปชต. : ${trainingStatisticsData.commissLocation}",
              //   scale: 0.9,
              //   maxLine: 2,
              // ),
              CustomText(
                text: "จังหวัด : ${trainingData.province}",
                scale: 0.9,
              ),
              CustomText(
                text:
                    "จำนวนผู้ฝึกอบรม : ${formatterItem.format(trainingData.trainingTotal)}",
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
