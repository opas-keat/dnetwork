import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../data/models/budget_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class BudgetStatistics extends StatelessWidget {
  const BudgetStatistics({
    super.key,
  });

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
              child: DataTable2(
                columnSpacing: defaultPadding,
                columns: listColumn,
                // rows: [],
                rows: List.generate(
                  listBudgetStatisticsData.length,
                  (index) =>
                      BudgetDataRow(index, listBudgetStatisticsData[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<DataColumn> listColumn = [
  const DataColumn2(
    label: Text(""),
    fixedWidth: 10,
  ),
  const DataColumn2(
    label: Text("วันที่รับงบประมาณ"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("ประเภทงบประมาณ"),
    size: ColumnSize.L,
  ),
  const DataColumn2(
    label: Text("จังหวัด"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("งบต้น"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("งบที่ใช้ไป"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("คงเหลือ"),
    size: ColumnSize.S,
    numeric: true,
  ),
];

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
