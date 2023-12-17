import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/budget_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../../../shared/utils.dart';
import '../controllers/budget_controller.dart';

class BudgetLayoutSmall extends StatelessWidget {
  BudgetLayoutSmall({
    super.key,
  });
  final BudgetController controller = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
          // listSummaryInfo: listBudgetSummaryInfo,
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
                    const Padding(
                      padding: EdgeInsets.only(left: defaultPadding / 2),
                      child: CustomText(
                        text: "ข้อมูลงบประมาณรายปี",
                        weight: FontWeight.bold,
                        size: 16,
                      ),
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
                                controller.listBudgetStatistics.clear();
                                controller.selectedBudgetType.value = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.budgetDate.text = '';
                                controller.listBudget();
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
                    itemCount: controller.listBudgetStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return budgetStatisticsSmallRow(index,
                          controller.listBudgetStatistics.obs.value[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        // MainChart(
        //   header: "สถิติข้อมูล งบประมาณ รับ-จ่าย",
        //   subHeader: "ประเภทงบประมาณ",
        //   listSummaryChart: summaryBudgetChart,
        // ),
        GetBuilder<BudgetController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลงบประมาณรายปี",
                  subHeader: "ประเภทงบประมาณ",
                  listSummaryChart: controller.summaryBudgetChart.obs.value,
                ),
        ),
      ],
    );
  }
}

Widget budgetStatisticsSmallRow(
  int index,
  BudgetData budgetData,
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
                text: "วันที่รับงบประมาณ : ${budgetData.budgetDate} ",
                scale: 0.9,
              ),
              CustomText(
                text: "ประเภทงบประมาณ : ${budgetData.budgetType}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text: "จังหวัด : ${budgetData.province}",
                scale: 0.9,
              ),
              CustomText(
                text: "งบต้น : ${formatterItem.format(budgetData.budgetBegin)}",
                scale: 0.9,
              ),
              CustomText(
                text:
                    "ใช้งบไป : ${formatterItem.format(budgetData.budgetUsed)}",
                scale: 0.9,
              ),
              CustomText(
                text:
                    "คงเหลือ : ${formatterItem.format(budgetData.budgetRemain)}",
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
