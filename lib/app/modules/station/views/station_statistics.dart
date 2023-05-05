import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/models/station_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class StationStatistics extends StatelessWidget {
  StationStatistics({
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
                text: "ข้อมูล ศส.ปชต.",
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
                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                columns: listColumn,
                // rows: [],
                rows: List.generate(
                  listStationStatisticsData.length,
                  (index) =>
                      StationDataRow(index, listStationStatisticsData[index]),
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
    label: Text("ชื่อ ศส.ปชต."),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: Text("จังหวัด/อำเภอ/ตำบล"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("จำนวนกรรมการ/สมาชิก"),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow StationDataRow(int index, StationStatisticsData stationStatisticsData) {
  return DataRow(
    onSelectChanged: (value) {
      Get.toNamed(
        Routes.DETAIL_STATION,
        arguments: stationStatisticsData,
      );
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
              stationStatisticsData.name!,
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
              stationStatisticsData.address!,
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
              "${stationStatisticsData.totalCommiss}/${stationStatisticsData.totalMember}",
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
