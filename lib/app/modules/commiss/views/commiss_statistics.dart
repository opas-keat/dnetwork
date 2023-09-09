import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/api/api_params.dart';
import 'package:get/get.dart';

import '../../../data/responses/commiss_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/commiss_controller.dart';
import '../manageCommiss/controllers/manage_commiss_controller.dart';

class CommissStatistics extends StatelessWidget {
  CommissStatistics({
    super.key,
  });
  final CommissController controller = Get.find<CommissController>();
  final ManageCommissController manageCommissController =
      Get.put(ManageCommissController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 260,
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
                text: "ข้อมูลกรรมการ ศส.ปชต.",
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
                          controller.listCommissStatistics.clear();
                          controller.defaultCommissOrder = queryParamOrderBy;
                          controller.listCommiss();
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
                        label: const Text("ชื่อ-นามสกุล"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("ตำแหน่ง"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("position", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("ว/ด/ป/ แต่งตั้ง"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "commissDate", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("สังกัด ศส.ปชต."),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort(
                              "commissLocation", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("จังหวัด/อำเภอ/ตำบล"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("address", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listCommissStatistics.obs.value.length,
                      (index) => commissDataRow(
                        index,
                        controller.listCommissStatistics.obs.value[index],
                        manageCommissController,
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

DataRow commissDataRow(
  int index,
  CommissData commissData,
  ManageCommissController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    onSelectChanged: (value) {
      controller.commissList.clear();
      controller.commissList.add(commissData);
      Get.toNamed(Routes.MANAGE_COMMISS);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${commissData.commissPreName!}${commissData.commissFirstName!} ${commissData.commissSurName!}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  commissData.commissTelephone!,
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
              commissData.commissPosition!,
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
              commissData.commissDate!,
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
              commissData.commissStationName!,
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
              "${commissData.province}/${commissData.amphure}/${commissData.district}",
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
