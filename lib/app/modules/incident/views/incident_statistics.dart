import 'dart:html';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/responses/incident_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';
import '../controllers/incident_controller.dart';
import 'incident_add.dart';

class IncidentStatistics extends StatelessWidget {
  IncidentStatistics({super.key});

  final IncidentController controller = Get.put(IncidentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      height: MediaQuery.of(context).size.height - 460,
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
                text: "แจ้งปัญหาการใช้งาน",
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
                          controller.listIncidentStatistics.clear();
                          controller.list();
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
          Flexible(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable2(
                  showCheckboxColumn: false,
                  columnSpacing: defaultPadding,
                  sortArrowIcon: Icons.keyboard_arrow_up,
                  sortArrowAnimationDuration: const Duration(milliseconds: 500),
                  sortColumnIndex: controller.sortColumnIndex.value,
                  sortAscending: controller.sortAscending.value,
                  isHorizontalScrollBarVisible: true,
                  isVerticalScrollBarVisible: true,
                  bottomMargin: 10,
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
                      label: const CustomText(
                        text: "วันที่แจ้ง",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("incidentDate", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "ผู้แจ้ง",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("createdBy", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "ระบบ",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort(
                            "incidentModule", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "ปัญหา",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort(
                            "incidentTitle", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "รายละเอียด",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort(
                            "incidentDetail", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "วันที่แก้ไข",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort("resolvedDate", columnIndex, ascending);
                      },
                    ),
                    DataColumn2(
                      label: const CustomText(
                        text: "รายละเอียดการแก้ไข",
                        weight: FontWeight.bold,
                        scale: 1.0,
                      ),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) {
                        controller.sort(
                            "resolvedDetail", columnIndex, ascending);
                      },
                    ),
                  ],
                  // rows: [],
                  rows: List.generate(
                    controller.listIncidentStatistics.obs.value.length,
                    (index) => incidentDataRow(
                      index,
                      controller.listIncidentStatistics.obs.value[index],
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

  DataRow incidentDataRow(
    int index,
    IncidentData incidentData,
  ) {
    return DataRow.byIndex(
      index: index + 1,
      onSelectChanged: (value) {
        if (window.sessionStorage["roles"].toString() != "user") {
          if (incidentData.resolvedDate!.isEmpty) {
            controller.selectedId = incidentData.id!;
            controller.incidentCreatedBy.text = incidentData.createdBy!;
            controller.incidentModule.text = incidentData.incidentModule!;
            controller.incidentTitle.text = incidentData.incidentTitle!;
            controller.incidentDetail.text = incidentData.incidentDetail!;
            Get.dialog(
              IncidentAdd(editMode: true),
              barrierDismissible: false,
            );
          }
        }
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
                    incidentData.incidentDate!,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  // Text(
                  //   incidentData.lectuterTelephone!,
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: incidentData.createdBy!,
                    scale: 0.8,
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Wrap(
            children: [
              CustomText(
                text: incidentData.incidentModule!,
                scale: 0.8,
              ),
            ],
          ),
        ),
        DataCell(
          Wrap(
            children: [
              CustomText(
                text: incidentData.incidentTitle!,
                scale: 0.8,
              ),
            ],
          ),
        ),
        DataCell(
          Wrap(
            children: [
              CustomText(
                text: incidentData.incidentDetail!,
                scale: 0.8,
              ),
            ],
          ),
        ),
        DataCell(
          Wrap(
            children: [
              Text(
                incidentData.resolvedDate!,
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
              CustomText(
                text: incidentData.resolvedDetail!,
                scale: 0.8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
