import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/member_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/member_controller.dart';

class MemberStatistics extends StatelessWidget {
  MemberStatistics({
    super.key,
  });
  final MemberController controller = Get.find<MemberController>();

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
                text: "ข้อมูลสมาชิก ศส.ปชต.",
                weight: FontWeight.bold,
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
                      controller.listMemberStatistics.obs.value.length,
                      (index) => MemberDataRow(index,
                          controller.listMemberStatistics.obs.value[index]),
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

DataRow MemberDataRow(int index, MemberStatisticsData memberStatisticsData) {
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
                  memberStatisticsData.name!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  memberStatisticsData.telephone!,
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
              memberStatisticsData.position!,
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
              memberStatisticsData.commissDate!,
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
              memberStatisticsData.commissLocation!,
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
              memberStatisticsData.address!,
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
