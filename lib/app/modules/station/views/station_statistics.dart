import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/models/station_statistics_data.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/station_controller.dart';

class StationStatistics extends StatelessWidget {
  StationStatistics({
    super.key,
  });
  final StationController controller = Get.find<StationController>();

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
          Row(
            children: [
              const CustomText(
                text: "ข้อมูล ศส.ปชต.",
                weight: FontWeight.bold,
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
                          controller.listStation();
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
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : DataTable2(
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
                            fixedWidth: 30,
                          ),
                          DataColumn2(
                            label: const Text("ชื่อ ศส.ปชต."),
                            size: ColumnSize.M,
                            onSort: (columnIndex, ascending) {
                              controller.sort("name", columnIndex, ascending);
                            },
                          ),
                          DataColumn2(
                            label: const Text("จังหวัด/อำเภอ/ตำบล"),
                            size: ColumnSize.S,
                            onSort: (columnIndex, ascending) {
                              controller.sort(
                                  "address", columnIndex, ascending);
                            },
                          ),
                          DataColumn2(
                            label: const Text("จำนวนกรรมการ/สมาชิก"),
                            size: ColumnSize.S,
                            numeric: true,
                            onSort: (columnIndex, ascending) {
                              controller.sort(
                                  "totalCommiss", columnIndex, ascending);
                            },
                          ),
                        ],
                        // rows: [],
                        rows: List.generate(
                          controller.listStationStatistics.obs.value.length,
                          (index) => StationDataRow(
                              index,
                              controller
                                  .listStationStatistics.obs.value[index]),
                        ),
                      ),
              ),
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
//     label: Text("ชื่อ ศส.ปชต."),
//     size: ColumnSize.M,
//   ),
//   const DataColumn2(
//     label: Text("จังหวัด/อำเภอ/ตำบล"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("จำนวนกรรมการ/สมาชิก"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
// ];

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
