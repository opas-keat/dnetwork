import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../controllers/budget_controller.dart';
import 'budget_statistics.dart';

class BudgetLayoutLarge extends StatelessWidget {
  BudgetLayoutLarge({
    super.key,
  });
  // final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BudgetController());
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
                  const CustomText(
                    text: "จังหวัด กรุงเทพมหานคร",
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  const Spacer(flex: 2),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding / 2),
                    ),
                    icon: const Icon(
                      Icons.insert_drive_file_sharp,
                    ),
                    label: const CustomText(
                      text: "รายงาน",
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 2),
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
                      // addressController.selectedProvince.value = "";
                      // addressController.();
                      Get.toNamed(Routes.MANAGE_BUDGET);
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(
                childAspectRatio: 2.2,
                // listSummaryInfo: listBudgetSummaryInfo,
                textScale: 1.4,
              ),
              const SizedBox(height: defaultPadding / 2),
              BudgetStatistics(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<BudgetController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูล งบประมาณ รับ-จ่าย",
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
