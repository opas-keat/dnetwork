import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';

class BudgetStatistics extends StatelessWidget {
  BudgetStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 300,
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomText(
                text: "ข้อมูลงบประมาณ รายรับ-รายจ่าย",
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
                rows: [],
                // rows: List.generate(
                //   listProvinceSummary.length,
                //   (index) => StationDataRow(
                //       context, index, listProvinceSummary[index]),
                // ),
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
    label: Text("วันที่รับงบประมาณ"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("ประเภทงบประมาณ"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("งบต้น"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("ใช้งบไป"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("คงเหลือ"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("จังหวัด"),
    size: ColumnSize.S,
    numeric: true,
  ),
];
