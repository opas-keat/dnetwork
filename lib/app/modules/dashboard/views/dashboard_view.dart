import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/dashboard_controller.dart';
// import 'statistics_chart.dart';
import 'dashboard_statistics.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);
  DashboardController controller = Get.find<DashboardController>();

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
                    children: [
                      const Header(moduleName: "หน้าจอหลัก"),
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
                                      text: "กกต ส่วนกลาง",
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
                                      label: const CustomText(
                                        text: "รายงาน",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                Responsive(
                                  smallScreen: InfoCard(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.0,
                                    listSummaryInfo: listDashboardSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listDashboardSummaryInfo,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                DashboardStatistics(),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
                            child: MainChart(
                              header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                              subHeader: "ประเภทการอบรม",
                              listSummaryChart: summaryDashboardChart,
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

// List<DataColumn> _createColumns() {
//   return [
//     const DataColumn2(
//       label: Text(""),
//       fixedWidth: 40,
//     ),
//     const DataColumn2(
//       label: Text("จังหวัด"),
//       size: ColumnSize.S,
//     ),
//     const DataColumn2(
//       label: Text("ศส.ปชต."),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//     const DataColumn2(
//       label: Text("กรรมการ"),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//     const DataColumn2(
//       label: Text("สมาชิก"),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//     const DataColumn2(
//       label: Text("เครือข่าย"),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//     const DataColumn2(
//       label: Text("หมู่บ้าน..."),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//     const DataColumn2(
//       label: Text("วิทยากร..."),
//       size: ColumnSize.S,
//       numeric: true,
//     ),
//   ];
// }
