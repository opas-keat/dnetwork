import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';

class LectuterStatistics extends StatelessWidget {
  LectuterStatistics({
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
                text: "ข้อมูลวิทยากรประชาธิปไตย",
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
    label: Text("ชื่อ-นามสกุล"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("หน่วยงาน"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("สังกัดวิทยากร"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("จังหวัด"),
    size: ColumnSize.S,
    numeric: true,
  ),
];
