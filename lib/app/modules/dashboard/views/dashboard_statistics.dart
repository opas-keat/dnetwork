import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/province_summary.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/dashboard_controller.dart';

class DashboardStatistics extends StatelessWidget {
  DashboardStatistics({
    super.key,
  });
  final DashboardController controller = Get.find<DashboardController>();

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
                text: "ข้อมูลสถิติรายจังหวัด",
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
                        fixedWidth: 40,
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "จังหวัด",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "ศส.ปชต.",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalStation", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "กรรมการ",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalCommiss", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "สมาชิก",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalMember", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "ภาคีเครือข่าย",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalNetwork", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "หมู่บ้าน วิถี ประชาธิปไตย",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalVillage", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const CustomText(
                          text: "วิทยากรประชาธิปไตย",
                          size: 14,
                        ),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "totalLectuter", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listProvinceSummary.obs.value.length,
                      (index) => DashboardDataRow(index,
                          controller.listProvinceSummary.obs.value[index]),
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
//     fixedWidth: 40,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "จังหวัด",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "ศส.ปชต.",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "กรรมการ",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "สมาชิก",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "ภาคีเครือข่าย",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "หมู่บ้าน วิถี ประชาธิปไตย",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
//   const DataColumn2(
//     label: CustomText(
//       text: "วิทยากรประชาธิปไตย",
//       size: 14,
//     ),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
// ];

DataRow DashboardDataRow(int index, ProvinceSummary provinceSummary) {
  return DataRow(
    onSelectChanged: (value) {
      talker.info("row selected: ${provinceSummary.name}");
      Get.toNamed(Routes.STATION);
    },
    cells: [
      // DataCell(Text(
      //   formatterItem.format(index + 1),
      // )),
      DataCell(
        Image.network(
          "assets/images/seal/${provinceSummary.seal!}",
          height: 38,
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(provinceSummary.name!),
          ],
        ),
      ),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalStation!),
      )),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalCommiss!),
      )),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalMember!),
      )),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalNetwork!),
      )),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalVillage!),
      )),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalLectuter!),
      )),
      // DataCell(Text(fileInfo.size!)),
    ],
  );
}
