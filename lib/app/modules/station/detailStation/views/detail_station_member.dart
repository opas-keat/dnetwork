import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/commiss_statistics_data.dart';
import '../../../../data/models/member_statistics_data.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/utils.dart';

class DetailStationMember extends StatelessWidget {
  DetailStationMember({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                text: "ข้อมูลสมาชิก",
                weight: FontWeight.bold,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.minWidth),
                  child: DataTable(
                    columns: listColumnMember,
                    rows: List.generate(
                      listMemberStatisticsData.length,
                      (index) => MemberDataRow(
                        index,
                        listMemberStatisticsData[index],
                      ),
                    ),
                  ),
                ),
              ),
              accentDivider,
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding,
                            horizontal: defaultPadding / 2),
                      ),
                      icon: const Icon(
                        Icons.supervisor_account_sharp,
                      ),
                      label: const CustomText(
                        text: "ไปยังรายชื่อ",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.MEMBER);
                      },
                    ),
                    const SizedBox(width: defaultPadding),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding,
                            horizontal: defaultPadding / 2),
                      ),
                      icon: const Icon(
                        Icons.add_sharp,
                      ),
                      label: const CustomText(
                        text: "เพิ่มข้อมูล",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.MANAGE_MEMBER);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DataColumn> listColumnMember = [
  const DataColumn2(
    label: Text(""),
    fixedWidth: 10,
  ),
  // const DataColumn2(
  //   label: Text(""),
  //   fixedWidth: 50,
  // ),
  const DataColumn2(
    label: CustomText(text: "ชื่อ-นามสกุล", scale: 0.9),
    size: ColumnSize.L,
  ),
  const DataColumn2(
    label: CustomText(text: "ตำแหน่ง", scale: 0.9),
    size: ColumnSize.M,
  ),
];

DataRow MemberDataRow(int index, MemberStatisticsData memberStatisticsData) {
  return DataRow(
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
                  memberStatisticsData.name!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  memberStatisticsData.telephone!,
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
              memberStatisticsData.position!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      // DataCell(
      //   Wrap(
      //     children: [
      //       Text(
      //         commissStatisticsData.commissDate!,
      //         style: const TextStyle(
      //           fontSize: 12,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // DataCell(
      //   Wrap(
      //     children: [
      //       Text(
      //         commissStatisticsData.commissLocation!,
      //         style: const TextStyle(
      //           fontSize: 12,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // DataCell(
      //   Wrap(
      //     children: [
      //       Text(
      //         commissStatisticsData.address!,
      //         style: const TextStyle(
      //           fontSize: 12,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
