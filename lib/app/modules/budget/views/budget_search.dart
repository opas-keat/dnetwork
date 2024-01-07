import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../address/views/address_view.dart';
import '../controllers/budget_controller.dart';

class BudgetSearch extends StatelessWidget {
  BudgetSearch({
    super.key,
  });
  final BudgetController controller = Get.find<BudgetController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ค้นหางบประมาณรายปี",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        height: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText(
                text: "ประเภทงบประมาณรายปี",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              Obx(
                () => DropdownButtonFormField<String>(
                  isDense: true,
                  isExpanded: true,
                  value: controller.selectedBudgetType.value,
                  onChanged: (newValue) {
                    controller.selectedBudgetType.value = newValue!;
                  },
                  items: controller.budgetTypeList.obs.value.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        textScaler: const TextScaler.linear(0.9),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: defaultPadding),
              CustomText(
                text: "วันที่รับงบประมาณ",
                color: Colors.black87.withOpacity(.9),
              ),
              const SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: controller.budgetDate,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: defaultPadding),
              AddressView(
                showAmphure: false,
                showTambol: false,
                showPostCode: false,
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("ค้นหา"),
          onPressed: () {
            controller.offset.value = 0;
            controller.currentPage = 1;
            controller.listBudgetStatistics.clear();
            controller.listBudget();
            // controller.selectedBudgetType.value = '';
            // controller.budgetDate.text = '';
            Get.back();
          },
        ),
        TextButton(
          child: const Text("ปิด"),
          onPressed: () {
            controller.selectedBudgetType.value = '';
            controller.addressController.selectedProvince.value = '';
            controller.budgetDate.text = '';
            Get.back();
          },
        ),
      ],
    );
  }
}
