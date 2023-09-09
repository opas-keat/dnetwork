import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/budget_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/budget_controller.dart';
import '../manageBudget/controllers/manage_budget_controller.dart';

class BudgetStatistics extends StatelessWidget {
  BudgetStatistics({
    super.key,
  });
  final BudgetController controller = Get.find<BudgetController>();
  final ManageBudgetController manageBudgetController =
      Get.put(ManageBudgetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: defaultPadding / 2),
                    child: CustomText(
                      text:
                          "ข้อมูลงบประมาณ รายรับ-รายจ่ายของสำนักพัฒนาภาคีเครือข่ายการเลือกตั้ง",
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
                              controller.addressController.selectedProvince
                                  .value = '';
                              controller
                                  .addressController.selectedAmphure.value = '';
                              controller
                                  .addressController.selectedTambol.value = '';
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
            ),
          ),
          Flexible(
            flex: 3,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 500,
              child: Obx(
                () => DataTable2(
                  columnSpacing: defaultPadding,
                  dividerThickness: 2,
                  showBottomBorder: true,
                  showCheckboxColumn: false,
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.shade200),
                  sortArrowIcon: Icons.keyboard_arrow_up,
                  sortArrowAnimationDuration: const Duration(milliseconds: 500),
                  sortColumnIndex: controller.sortColumnIndex.value,
                  sortAscending: controller.sortAscending.value,
                  empty: Center(
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.grey[200],
                          child: const Text('ไม่พบข้อมูล'))),
                  columns: [
                    const DataColumn2(
                      label: Text(""),
                      fixedWidth: 30,
                    ),
                    DataColumn2(
                      label: const Text("วันที่รับงบประมาณ"),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("date", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const Text("ประเภทงบประมาณ"),
                      size: ColumnSize.L,
                      onSort: (columnIndex, ascending) {
                        controller.sort("type", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const Text("จังหวัด"),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("province", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const Text("งบต้น"),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("budgetBegin", columnIndex, ascending);
                      },
                      numeric: true,
                    ),
                    DataColumn2(
                      label: const Text("งบที่ใช้ไป"),
                      size: ColumnSize.S,
                      numeric: true,
                      onSort: (columnIndex, ascending) {
                        controller.sort("budgetUsed", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const Text("คงเหลือ"),
                      size: ColumnSize.S,
                      numeric: true,
                      onSort: (columnIndex, ascending) {
                        controller.sort("budgetRemain", columnIndex, ascending);
                      },
                    ),
                  ],
                  rows: List.generate(
                    controller.listBudgetStatistics.obs.value.length,
                    (index) => budgetDataRow(
                      index,
                      controller.listBudgetStatistics.obs.value[index],
                      manageBudgetController,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: defaultPadding / 2),
          // Flexible(
          //   flex: 1,
          //   child: Container(
          //     // color: Colors.amber,
          //     height: 30,
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         CustomText(
          //           text: "โหลดเพิ่ม",
          //           color: Colors.blue,
          //           scale: 0.9,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// List<DataColumn> listColumn = [
//   const DataColumn2(
//     label: Text(""),
//     fixedWidth: 10,
//   ),
//   const DataColumn2(
//     label: Text("วันที่รับงบประมาณ"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("ประเภทงบประมาณ"),
//     size: ColumnSize.L,
//   ),
//   const DataColumn2(
//     label: Text("จังหวัด"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("งบต้น"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: Text("งบที่ใช้ไป"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: Text("คงเหลือ"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
// ];

DataRow budgetDataRow(
  int index,
  BudgetData budgetData,
  ManageBudgetController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    // color: MaterialStateProperty.resolveWith(
    //   (states) {
    //     if ((index) == controller.selectedIndexFromTable) {
    //       return Colors.amber.shade200;
    //     } else if (index % 2 == 0) {
    //       return Colors.blue[50];
    //     } else {
    //       return Colors.white;
    //     }
    //   },
    // ),
    onSelectChanged: (value) {
      controller.budgetList.clear();
      controller.budgetList.add(budgetData);
      Get.toNamed(Routes.MANAGE_BUDGET);
      // controller.selectDataFromTable(index, budgetData);
    },
    cells: [
      DataCell(
        Text(
          formatterItem.format(index + 1),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              budgetData.budgetDate!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              budgetData.budgetType!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              budgetData.province!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              formatterItem.format(budgetData.budgetBegin),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              formatterItem.format(budgetData.budgetUsed),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(budgetData.budgetRemain),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
