import 'package:flutter/material.dart';
import 'package:frontend/app/api/api_params.dart';
import 'package:frontend/app/shared/custom_flat_button.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/budget_controller.dart';
import 'budget_search.dart';
import 'budget_statistics.dart';

class BudgetLayoutLarge extends StatelessWidget {
  const BudgetLayoutLarge({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BudgetController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
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
                      controller.currentPage = 1;
                      controller.listBudgetStatistics.clear();
                      controller.offset.value = int.parse(queryParamOffset);
                      Get.toNamed(Routes.MANAGE_BUDGET);
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
                        BudgetSearch(),
                        barrierDismissible: false,
                      );
                    },
                  ),
                  const SizedBox(width: defaultPadding / 2),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(),
              const SizedBox(height: defaultPadding / 2),
              BudgetStatistics(),
              const SizedBox(height: defaultPadding / 2),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.listBudget();
                },
                label: "แสดงข้อมูลเพิ่ม",
                labelStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<BudgetController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลงบประมาณรายปี",
                      subHeader: "ประเภทงบประมาณ",
                      listSummaryChart: controller.summaryBudgetChart.obs.value,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
