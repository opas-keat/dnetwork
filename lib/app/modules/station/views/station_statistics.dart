import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/responses/station_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/station_controller.dart';
import '../manageStation/controllers/manage_station_controller.dart';

class StationStatistics extends StatelessWidget {
  StationStatistics({
    super.key,
  });
  final StationController controller = Get.find<StationController>();
  final ManageStationController manageStationController =
      Get.put(ManageStationController());

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
                          controller.offset.value = 0;
                          controller.currentPage = 1;
                          controller.listStationStatistics.clear();
                          controller.name.text = '';
                          controller.addressController.selectedProvince.value =
                              '';
                          controller.addressController.selectedAmphure.value =
                              '';
                          controller.addressController.selectedTambol.value =
                              '';
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
                          (index) => stationDataRow(
                            index,
                            controller.listStationStatistics.obs.value[index],
                            manageStationController,
                          ),
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

DataRow stationDataRow(
  int index,
  StationData stationData,
  ManageStationController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    onSelectChanged: (value) {
      controller.stationList.clear();
      controller.stationList.add(stationData);
      Get.toNamed(Routes.MANAGE_STATION);
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
              stationData.name!,
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
              '${stationData.province!}/${stationData.amphure!}/${stationData.district!}',
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
              "${stationData.totalCommiss!}/${stationData.totalMember!}",
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
