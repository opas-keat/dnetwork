import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class StatisticsDashboard2 extends StatelessWidget {
  const StatisticsDashboard2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height,
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
                columns: const [
                  DataColumn2(
                    label: Text(""),
                    fixedWidth: 40,
                  ),
                  DataColumn2(
                    label: Text("จังหวัด"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text("ศส.ปชต."),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                  DataColumn2(
                    label: Text("กรรมการ"),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                  DataColumn2(
                    label: Text("สมาชิก"),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                  DataColumn2(
                    label: Text("เครือข่าย"),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                  DataColumn2(
                    label: Text("หมู่บ้าน..."),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                  DataColumn2(
                    label: Text("วิทยากร..."),
                    size: ColumnSize.S,
                    numeric: true,
                  ),
                ],
                rows: List.generate(
                  listProvinceSummary.length,
                  (index) => StationDataRow(
                      context, index, listProvinceSummary[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow StationDataRow(
    BuildContext context, int index, ProvinceSummary provinceSummary) {
  return DataRow(
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
        Row(
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
