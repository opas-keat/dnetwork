import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/list_report_controller.dart';

class ListReportView extends StatelessWidget {
  ListReportView({Key? key}) : super(key: key);

  final ListReportController controller = Get.find<ListReportController>();
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
                      const Header(moduleName: "listproblem"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const CustomText(
                                //       text: "กกต ส่วนกลาง",
                                //       weight: FontWeight.bold,
                                //       size: 18,
                                //     ),
                                //     const Spacer(flex: 2),
                                //     ElevatedButton.icon(
                                //       onPressed: () {},
                                //       style: ElevatedButton.styleFrom(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: defaultPadding,
                                //             horizontal: defaultPadding / 2),
                                //       ),
                                //       icon: const Icon(
                                //         Icons.insert_drive_file_sharp,
                                //       ),
                                //       label: const Text('รายงาน'),
                                //     ),
                                //     const SizedBox(width: defaultPadding / 2),
                                //     ElevatedButton.icon(
                                //       onPressed: () {},
                                //       style: ElevatedButton.styleFrom(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: defaultPadding,
                                //             horizontal: defaultPadding / 2),
                                //       ),
                                //       icon: const Icon(
                                //         Icons.add_sharp,
                                //       ),
                                //       label: const Text('เพิ่ม'),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: defaultPadding),
                                // Spacer(),
                                // const Responsive(
                                //   smallScreen: InfoCard(
                                //     crossAxisCount: 2,
                                //     childAspectRatio: 2.0,
                                //   ),
                                //   largeScreen: InfoCard(
                                //     childAspectRatio: 2.2,
                                //   ),
                                // ),
                                // const SizedBox(height: defaultPadding),
                                // StatisticsDashboard(),
                                // Spacer(),
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
  // final ScrollController _scrollController = ScrollController();
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //     child: GetBuilder<ListReportController>(
  //         init: controller,
  //         builder: (controller) {
  //           // loading
  //           if (controller.isLoading.value) {
  //             return Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: defaultPadding * 2),
  //               child: Center(
  //                 child: const CircularProgressIndicator().reactive(),
  //               ),
  //             );
  //           }
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: defaultPadding),
  //               SizedBox(
  //                 height: 50,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Expanded(
  //                       child: TextFormField(
  //                         textInputAction: TextInputAction.next,
  //                         cursorColor: primaryColor,
  //                         // controller: _textEmail,
  //                         decoration: const InputDecoration(
  //                           hintText: 'ค้นหา',
  //                           prefixIcon: Icon(Icons.search_sharp),
  //                         ),
  //                         // validator: (value) => validateNotEmpty(value!, 'Your Email'),
  //                       ),
  //                     ),
  //                     const SizedBox(width: defaultPadding),
  //                     CustomFlatButton(
  //                       color: primaryColor,
  //                       overlayColor: primaryLightColor,
  //                       padding: const EdgeInsets.all(defaultPadding),
  //                       isWrapped: true,
  //                       label: 'ค้นหา',
  //                       onPressed: () {},
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: defaultPadding),
  //               SizedBox(
  //                 height: 50,
  //                 child: Row(
  //                   children: [
  //                     CustomFlatButton(
  //                       color: Colors.green.shade700,
  //                       overlayColor: Colors.greenAccent,
  //                       padding: const EdgeInsets.all(defaultPadding),
  //                       isWrapped: true,
  //                       label: 'ปรับปรุงสถานะ',
  //                       onPressed: () {},
  //                     ),
  //                     const SizedBox(width: defaultPadding),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: defaultPadding,
  //               ),
  //               Container(
  //                 // color: Colors.amber,
  //                 height: MediaQuery.of(context).size.height -
  //                     (Responsive.isSmallScreen(context) ? 220 : 180),
  //                 child: DataTable2(
  //                   scrollController: _scrollController,
  //                   columnSpacing: defaultPadding,
  //                   // minWidth: 200,
  //                   columns: [
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("ลำดับที่"),
  //                         size: ColumnSize.S,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("การทำงาน"),
  //                       size: ColumnSize.S,
  //                     ),
  //                     const DataColumn2(
  //                       label: Text("รายละเอียด"),
  //                       size: ColumnSize.L,
  //                     ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("ผู้แจ้ง"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("สถานะ"),
  //                       size: ColumnSize.M,
  //                     ),
  //                   ],
  //                   // rows: [],
  //                   rows: List.generate(
  //                     controller.bugReportList.length,
  //                     (index) => BugReportDataRow(
  //                       context,
  //                       controller.bugReportList[index],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }),
  //   );
  // }
}

// DataRow BugReportDataRow(
//   BuildContext context,
//   BugReport bugReport,
// ) {
//   return DataRow(
//     cells: [
//       if (!Responsive.isSmallScreen(context))
//         DataCell(Text(
//           formatterItem.format(bugReport.id),
//         )),
//       DataCell(
//         Text(bugReport.module!),
//       ),
//       DataCell(
//         Text(bugReport.detail!),
//       ),
//       if (!Responsive.isSmallScreen(context))
//         DataCell(
//           Text(bugReport.userName!),
//         ),
//       DataCell(
//         Text(bugReport.status!),
//       ),
//     ],
//   );
// }
