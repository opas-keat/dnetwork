import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/network_statistics.data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/network_controller.dart';

class NetworkStatistics extends StatelessWidget {
  NetworkStatistics({
    super.key,
  });
  final NetworkController controller = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 275,
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
                text: "ข้อมูลภาคีเครือข่าย ศส.ปชต.",
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
                        label: Text("ชื่อ-นามสกุล"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("ตำแหน่ง"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("position", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("ว/ด/ป/ แต่งตั้ง"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "commissDate", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("สังกัด ศส.ปชต."),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "commissLocation", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: Text("จังหวัด/อำเภอ/ตำบล"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("address", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listNetworkStatistics.obs.value.length,
                      (index) => NetworkDataRow(index,
                          controller.listNetworkStatistics.obs.value[index]),
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
//     label: Text("ชื่อ-นามสกุล"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("ตำแหน่ง"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("ว/ด/ป/ แต่งตั้ง"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("สังกัด ศส.ปชต."),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("จังหวัด/อำเภอ/ตำบล"),
//     size: ColumnSize.S,
//   ),
// ];

DataRow NetworkDataRow(int index, NetworkStatisticsData networkStatisticsData) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  networkStatisticsData.name!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  networkStatisticsData.telephone!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              networkStatisticsData.position!,
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
              networkStatisticsData.commissDate!,
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
              networkStatisticsData.commissLocation!,
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
              networkStatisticsData.address!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
