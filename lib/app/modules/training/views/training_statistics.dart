import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/training_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/training_controller.dart';

class TrainingStatistics extends StatelessWidget {
  TrainingStatistics({
    super.key,
  });
  final TrainingController controller = Get.find<TrainingController>();

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
                        label: Text("หลักสูตรอบรม"),
                        size: ColumnSize.L,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("วันที่อบรม"),
                        size: ColumnSize.M,
                        onSort: (columnIndex, ascending) {
                          controller.sort("date", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("ประเภทการฝีกอบรม"),
                        size: ColumnSize.M,
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
                        label: Text("จำนวนผู้ฝึกอบรม"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("total", columnIndex, ascending);
                        },
                        numeric: true,
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listTrainingStatistics.obs.value.length,
                      (index) => TraingingDataRow(index,
                          controller.listTrainingStatistics.obs.value[index]),
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
//     label: Text("หลักสูตรอบรม"),
//     size: ColumnSize.L,
//   ),
//   const DataColumn2(
//     label: Text("วันที่อบรม"),
//     size: ColumnSize.M,
//   ),
//   const DataColumn2(
//     label: Text("ประเภทการฝีกอบรม"),
//     size: ColumnSize.M,
//   ),
//   const DataColumn2(
//     label: Text("จังหวัด"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("จำนวนผู้ฝึกอบรม"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
// ];

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
