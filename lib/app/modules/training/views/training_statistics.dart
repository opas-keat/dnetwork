import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../data/models/training_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class TrainingStatistics extends StatelessWidget {
  TrainingStatistics({
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
                text: "ข้อมูลการฝึกอบรม",
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
                  listTrainingStatisticsData.length,
                  (index) => TraingingDataRow(
                      index, listTrainingStatisticsData[index]),
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
    label: Text("ชื่อโครงการฝึกอบรม"),
    size: ColumnSize.L,
  ),
  const DataColumn2(
    label: Text("ระหว่างวัน"),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: Text("ประเภทการฝีกอบรม"),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: Text("จังหวัด"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("จำนวนผู้ฝึกอบรม"),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow TraingingDataRow(
    int index, TrainingStatisticsData trainingStatisticsData) {
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
              trainingStatisticsData.name!,
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
              trainingStatisticsData.date!,
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
              trainingStatisticsData.type!,
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
              trainingStatisticsData.province!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(trainingStatisticsData.total),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
