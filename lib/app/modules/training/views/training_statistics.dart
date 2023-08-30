import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/training_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/training_controller.dart';
import '../manageTraining/controllers/manage_training_controller.dart';

class TrainingStatistics extends StatelessWidget {
  TrainingStatistics({
    super.key,
  });
  final TrainingController controller = Get.find<TrainingController>();
  final ManageTrainingController manageTrainingController =
      Get.put(ManageTrainingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 350,
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CustomText(
                text: "ข้อมูลการฝึกอบรม",
                weight: FontWeight.bold,
                size: 16,
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
                          controller.listTrainingStatistics.clear();
                          controller.listTraining();
                        },
                        icon: const Icon(
                          Icons.refresh_sharp,
                        ),
                        color: primaryColor,
                      ),
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
                        fixedWidth: 30,
                      ),
                      DataColumn2(
                        label: const Text("หลักสูตรอบรม"),
                        size: ColumnSize.L,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("วันที่อบรม"),
                        size: ColumnSize.M,
                        onSort: (columnIndex, ascending) {
                          controller.sort("date", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("ประเภทการฝีกอบรม"),
                        size: ColumnSize.M,
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
                        label: const Text("จำนวนผู้ฝึกอบรม"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("total", columnIndex, ascending);
                        },
                        numeric: true,
                      ),
                    ],
                    rows: List.generate(
                      controller.listTrainingStatistics.obs.value.length,
                      (index) => trainingDataRow(
                        index,
                        controller.listTrainingStatistics.obs.value[index],
                        manageTrainingController,
                      ),
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

DataRow trainingDataRow(
  int index,
  TrainingData trainingData,
  ManageTrainingController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    onSelectChanged: (value) {
      controller.trainingList.clear();
      controller.trainingList.add(trainingData);
      Get.toNamed(Routes.MANAGE_TRAINING);
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
              trainingData.trainingName!,
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
              '${trainingData.trainingDateForm!} ถึง ${trainingData.trainingDateTo!}',
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
              trainingData.trainingType!,
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
              trainingData.province!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(trainingData.trainingTotal),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
