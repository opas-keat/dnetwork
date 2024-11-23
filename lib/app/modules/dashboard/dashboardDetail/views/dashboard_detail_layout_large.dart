import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/responses/commiss_service_response.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_chart.dart';
import '../../../../shared/show_province.dart';
import '../../../../shared/utils.dart';
import '../../../commiss/controllers/commiss_controller.dart';
import '../../../member/controllers/member_controller.dart';
import '../../../training/controllers/training_controller.dart';

class DashboardDetailLayoutLarge extends StatelessWidget {
  const DashboardDetailLayoutLarge({super.key});
  @override
  Widget build(BuildContext context) {
    final trainingController = Get.put(TrainingController());
    final commissController = Get.put(CommissController());
    final memberController = Get.put(MemberController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowProvince(),
                  Spacer(flex: 2),
                  SizedBox(width: defaultPadding / 2),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: [
                  Image.network(
                    "assets/images/seal/Seal_Bangkok.png",
                    height: 60,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Expanded(
                    child: Container(
                      height: 80, // ขนาดคงที่
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: defaultPadding / 2),
                            child: const Wrap(
                              direction: Axis.vertical,
                              runAlignment: WrapAlignment.start,
                              children: [
                                Text(
                                  "ชื่อ ศส.ปชต. :กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ที่ตั้ง :กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ชื่อ ศส.ปชต. : กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Facebook/Location: กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<CommissController>(
                        builder: (_) => commissController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 600,
                                child: DashboardDetailCommiss(
                                  header: "ข้อมูลกรรมการ",
                                  subHeader: "",
                                  listCommiss: commissController
                                      .listCommissStatistics.obs.value,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<MemberController>(
                        builder: (_) => memberController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 600,
                                child: DashboardDetailNetwork(
                                  header: "ข้อมูลสมาชิก",
                                  subHeader: "",
                                  listMember: memberController
                                      .listMemberStatistics.obs.value,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 2),
                        child: const Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.start,
                          children: [
                            Text(
                              "ผลการดำเนินงาน ศส.ปชต.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "หัวข้อดำเนินการ",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "1.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "2.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "3.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "4.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "5.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<TrainingController>(
              builder: (_) => trainingController.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                      subHeader: "ประเภทการอบรม",
                      listSummaryChart:
                          trainingController.summaryChart.obs.value,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardDetailCommiss extends StatelessWidget {
  const DashboardDetailCommiss({
    super.key,
    this.header = "",
    this.subHeader = "",
    this.listCommiss = const [],
  });

  final String header;
  final String subHeader;
  final List<CommissData> listCommiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: header,
            weight: FontWeight.bold,
            size: 12,
          ),
          const SizedBox(height: defaultPadding / 2),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: DataTable2(
                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                sortArrowIcon: Icons.keyboard_arrow_up,
                sortArrowAnimationDuration: const Duration(milliseconds: 500),
                // sortColumnIndex: controller.sortColumnIndex.value,
                // sortAscending: controller.sortAscending.value,
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
                      // controller.sort("name", columnIndex, ascending);
                    },
                  ),
                  DataColumn2(
                    label: const Text("ตำแหน่ง"),
                    size: ColumnSize.S,
                    onSort: (columnIndex, ascending) {
                      // controller.sort("position", columnIndex, ascending);
                    },
                  ),
                ],
                // rows: [],
                rows: List.generate(
                  listCommiss.length,
                  (index) => commissDataRow(
                    index,
                    listCommiss[index],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.people_sharp,
                ),
                label: const CustomText(
                  text: "ไปยังรายชื่อ",
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                onPressed: () {
                  Get.toNamed(Routes.COMMISS);
                },
              ),
              const SizedBox(width: defaultPadding / 2),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.add_sharp,
                ),
                label: const CustomText(
                  text: "เพิ่มข้อมูล",
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                onPressed: () {
                  Get.toNamed(Routes.MANAGE_COMMISS);
                },
              ),
              const SizedBox(width: defaultPadding / 2),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardDetailNetwork extends StatelessWidget {
  const DashboardDetailNetwork({
    super.key,
    this.header = "",
    this.subHeader = "",
    this.listMember = const [],
  });

  final String header;
  final String subHeader;
  final List<MemberData> listMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: header,
            weight: FontWeight.bold,
            size: 12,
          ),
          const SizedBox(height: defaultPadding / 2),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: DataTable2(
                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                sortArrowIcon: Icons.keyboard_arrow_up,
                sortArrowAnimationDuration: const Duration(milliseconds: 500),
                // sortColumnIndex: controller.sortColumnIndex.value,
                // sortAscending: controller.sortAscending.value,
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
                      // controller.sort("name", columnIndex, ascending);
                    },
                  ),
                  DataColumn2(
                    label: const Text("ตำแหน่ง"),
                    size: ColumnSize.S,
                    onSort: (columnIndex, ascending) {
                      // controller.sort("position", columnIndex, ascending);
                    },
                  ),
                ],
                // rows: [],
                rows: List.generate(
                  listMember.length,
                  (index) => memberDataRow(
                    index,
                    listMember[index],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.people_sharp,
                ),
                label: const CustomText(
                  text: "ไปยังรายชื่อ",
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                onPressed: () {
                  Get.toNamed(Routes.MEMBER);
                },
              ),
              const SizedBox(width: defaultPadding / 2),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.add_sharp,
                ),
                label: const CustomText(
                  text: "เพิ่มข้อมูล",
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                onPressed: () {
                  Get.toNamed(Routes.MANAGE_MEMBER);
                },
              ),
              const SizedBox(width: defaultPadding / 2),
            ],
          ),
        ],
      ),
    );
  }
}

DataRow commissDataRow(
  int index,
  CommissData commissData,
) {
  return DataRow.byIndex(
    index: index + 1,
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
    ],
  );
}

DataRow memberDataRow(
  int index,
  MemberData memberData,
) {
  return DataRow.byIndex(
    index: index + 1,
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
                  "${memberData.memberPreName!}${memberData.memberFirstName!} ${memberData.memberSurName!}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  memberData.memberTelephone!,
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
              memberData.memberPosition!,
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
