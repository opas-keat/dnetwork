import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/lectuter_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/lectuter_controller.dart';
import '../manageLectuter/controllers/manage_lectuter_controller.dart';

class LectuterStatistics extends StatelessWidget {
  LectuterStatistics({
    super.key,
  });
  final LectuterController controller = Get.find<LectuterController>();
  final ManageLectuterController manageLectuterController =
      Get.put(ManageLectuterController());

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
                text: "ข้อมูลวิทยากรประชาธิปไตย",
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
                          controller.listLectuterStatistics.clear();
                          controller.lectuterFirstName.text = '';
                          controller.lectuterSurName.text = '';
                          controller.lectuterTelephone.text = '';
                          controller.lectuterAgency.text = '';
                          controller.selectedLectuterAffiliate.value = '';
                          controller.addressController.selectedProvince.value =
                              '';
                          controller.addressController.selectedAmphure.value =
                              '';
                          controller.addressController.selectedTambol.value =
                              '';
                          controller.listLectuter();
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
                        label: const Text("หน่วยงาน"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("agency", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("สังกัดวิทยากร"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("affiliate", columnIndex, ascending);
                        },
                      ),
                      DataColumn2(
                        label: const Text("จังหวัด"),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          controller.sort("province", columnIndex, ascending);
                        },
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.listLectuterStatistics.obs.value.length,
                      (index) => lectuterDataRow(
                        index,
                        controller.listLectuterStatistics.obs.value[index],
                        manageLectuterController,
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

List<DataColumn> listColumn = [
  const DataColumn2(
    label: Text(""),
    fixedWidth: 10,
  ),
  const DataColumn2(
    label: Text("ชื่อ-นามสกุล"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("หน่วยงาน"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("สังกัดวิทยากร"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("จังหวัด"),
    size: ColumnSize.S,
  ),
];

DataRow lectuterDataRow(
  int index,
  LectuterData lectuterData,
  ManageLectuterController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    onSelectChanged: (value) {
      controller.lectuterList.clear();
      controller.lectuterList.add(lectuterData);
      Get.toNamed(Routes.MANAGE_LECTUTER);
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
                  lectuterData.name!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  lectuterData.lectuterTelephone!,
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
              lectuterData.lectuterAgency!,
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
              lectuterData.lectuterAffiliate!,
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
              lectuterData.province!,
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
