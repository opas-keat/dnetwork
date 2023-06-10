import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/province_summary.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class DashboardStatistics extends StatelessWidget {
  const DashboardStatistics({
    super.key,
  });

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
              child: DataTable2(
                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                columns: listColumn,
                // rows: [],
                rows: List.generate(
                  listProvinceSummary.length,
                  (index) =>
                      DashboardDataRow(index, listProvinceSummary[index]),
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
    fixedWidth: 40,
  ),
  const DataColumn2(
    label: CustomText(
      text: "จังหวัด",
      size: 14,
    ),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(
      text: "ศส.ปชต.",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(
      text: "กรรมการ",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(
      text: "สมาชิก",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(
      text: "ภาคีเครือข่าย",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(
      text: "หมู่บ้าน วิถี ประชาธิปไตย",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(
      text: "วิทยากรประชาธิปไตย",
      size: 14,
    ),
    size: ColumnSize.S,
    numeric: true,
  ),
];

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
