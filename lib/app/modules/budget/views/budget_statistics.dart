import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/budget_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/budget_controller.dart';

class BudgetStatistics extends StatelessWidget {
  BudgetStatistics({
    super.key,
  });
  BudgetController controller = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 250,
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              CustomText(
                text:
                    "ข้อมูลงบประมาณ รายรับ-รายจ่ายของสำนักพัฒนาภาคีเครือข่ายการเลือกตั้ง",
                weight: FontWeight.bold,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: defaultPadding / 2),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Obx(() => DataTable2(
                    showCheckboxColumn: false,
                    columnSpacing: defaultPadding,
                    // columns: listColumn,
                    sortArrowIcon: Icons.keyboard_arrow_up,
                    sortArrowAnimationDuration:
                        const Duration(milliseconds: 500),
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
                        fixedWidth: 10,
                      ),
                      DataColumn2(
                        label: Text("วันที่รับงบประมาณ"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("date", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("ประเภทงบประมาณ"),
                        size: ColumnSize.L,
                        onSort: (columnIndex, ascending) {
                          controller.sort("type", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("จังหวัด"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("province", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("งบต้น"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "budgetBegin", columnIndex, ascending);
                        },
                        numeric: true,
                      ),
                      DataColumn2(
                        label: Text("งบที่ใช้ไป"),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort("budgetUsed", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("คงเหลือ"),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "budgetRemain", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listBudgetStatistics.value.length,
                      (index) => BudgetDataRow(
                          index, controller.listBudgetStatistics.value[index]),
                    ),
                  )),
            ),
          ),
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

DataRow BudgetDataRow(int index, BudgetStatisticsData budgetStatisticsData) {
  return DataRow(
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
              budgetStatisticsData.date!,
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
              budgetStatisticsData.type!,
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
              budgetStatisticsData.province!,
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
              formatterItem.format(budgetStatisticsData.budgetBegin),
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
              formatterItem.format(budgetStatisticsData.budgetUsed),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(budgetStatisticsData.budgetRemain),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
