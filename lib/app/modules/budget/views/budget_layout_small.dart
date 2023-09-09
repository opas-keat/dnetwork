import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/budget_service_response.dart';
import '../../../routes/app_pages.dart';
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
            Expanded(
              child: ShowProvince(),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(
            //         vertical: defaultPadding, horizontal: defaultPadding / 2),
            //   ),
            //   icon: const Icon(
            //     Icons.insert_drive_file_sharp,
            //     size: 16,
            //   ),
            //   label: const CustomText(
            //     text: "รายงาน",
            //     color: Colors.white,
            //     scale: 0.9,
            //   ),
            // ),
            const SizedBox(width: defaultPadding / 2),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add_sharp,
                size: 16,
              ),
              label: const CustomText(
                text: "เพิ่ม/แก้ไข",
                color: Colors.white,
                scale: 0.9,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              onPressed: () {
                Get.toNamed(Routes.MANAGE_BUDGET);
              },
            ),
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
                    const CustomText(
                      text: "ข้อมูลสถิติรายจังหวัด",
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
                  header: "สถิติข้อมูล งบประมาณ รับ-จ่าย",
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
