import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/village_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/village_controller.dart';
import '../manageVillage/controllers/manage_village_controller.dart';

class VillageStatistics extends StatelessWidget {
  VillageStatistics({
    super.key,
  });
  final VillageController controller = Get.find<VillageController>();
  final ManageVillageController manageVillageController =
      Get.put(ManageVillageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 250,
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
                text: "ข้อมูลหมู่บ้าน วิถี ประชาธิปไตย",
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
                          controller.listVillageStatistics.clear();
                          controller.addressController.selectedProvince.value =
                              '';
                          controller.addressController.selectedAmphure.value =
                              '';
                          controller.addressController.selectedTambol.value =
                              '';
                          controller.listVillage();
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
                        label: const Text("ชื่อหมู่บ้าน"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("name", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("หมู่ที่/บ้านเลขที่"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("no", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("จังหวัด/อำเภอ/ตำบล"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("address", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("จำนวนครัวเรือน"),
                        size: ColumnSize.S,
                        numeric: true,
                        onSort: (columnIndex, ascending) {
                          controller.sort("total", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listVillageStatistics.obs.value.length,
                      (index) => villageDataRow(
                        index,
                        controller.listVillageStatistics.obs.value[index],
                        manageVillageController,
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
//     label: Text("ชื่อหมู่บ้าน"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("หมู่ที่/บ้านเลขที่"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("จังหวัด/อำเภอ/ตำบล"),
//     size: ColumnSize.S,
//   ),
//   const DataColumn2(
//     label: Text("จำนวนครัวเรือน"),
//     size: ColumnSize.S,
//     numeric: true,
//   ),
// ];

DataRow villageDataRow(
  int index,
  VillageData villageData,
  ManageVillageController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    onSelectChanged: (value) {
      controller.villageList.clear();
      controller.villageList.add(villageData);
      Get.toNamed(Routes.MANAGE_VILLAGE);
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
              villageData.villageName!,
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
              villageData.villageNo!,
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
              '${villageData.province!}/${villageData.amphure!}/${villageData.district!}',
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
              formatterItem.format(villageData.villageTotal),
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
