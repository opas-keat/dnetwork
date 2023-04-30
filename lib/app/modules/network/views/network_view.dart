import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_drawer.dart';
import '../../../shared/main_statistics.dart';
import '../controllers/network_controller.dart';

class NetworkView extends GetView<NetworkController> {
  NetworkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              child: MainDrawer(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Header(moduleName: "เครือข่าย"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "จังหวัด กรุงเทพมหานคร",
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    const Spacer(flex: 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.insert_drive_file_sharp,
                                      ),
                                      label: const Text('รายงาน'),
                                    ),
                                    const SizedBox(width: defaultPadding / 2),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.add_sharp,
                                      ),
                                      label: const Text('เพิ่ม'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                Responsive(
                                  smallScreen: InfoCard(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.0,
                                    listSummaryInfo: listNetworkSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listNetworkSummaryInfo,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                MainStatistics(
                                  header: "ข้อมูลเครือข่าย ศส.ปชต.",
                                  listColumn: listColumn,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
                            child: Container(
                              color: Colors.amber,
                              // height: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DataColumn> listColumn = [
  const DataColumn2(
    label: Text("ชื่อ-นามสกุล"),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: Text("ตำแหน่ง"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("ว/ด/ป/ แต่งตั้ง"),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("สังกัด ศส.ปชต."),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: Text("จังหวัด/อำเภอ/ตำบล"),
    size: ColumnSize.S,
    numeric: true,
  ),
];
