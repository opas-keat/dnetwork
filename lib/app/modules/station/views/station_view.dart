import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/station_controller.dart';

class StationView extends StatelessWidget {
  StationView({Key? key}) : super(key: key);
  StationController controller = Get.find<StationController>();

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
                      const Header(moduleName: "ศส.ปชต."),
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
  //     child: GetBuilder<StationController>(
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
  //           if (!controller.isLoadingAddStation.value) {
  //             return AddStationView();
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
  //                       label: 'เพิ่ม',
  //                       onPressed: () {
  //                         // Get.toNamed(Routes.ADD_STATION);
  //                         controller.isLoadingAddStation.value = false;
  //                         controller.update();
  //                       },
  //                     ),
  //                     const SizedBox(width: defaultPadding),
  //                     CustomFlatButton(
  //                       color: Colors.redAccent.shade700,
  //                       overlayColor: Colors.redAccent,
  //                       padding: const EdgeInsets.all(defaultPadding),
  //                       isWrapped: true,
  //                       label: 'ลบ',
  //                       onPressed: () {},
  //                     ),
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
  //                       label: Text("ชื่อ"),
  //                       size: ColumnSize.L,
  //                     ),
  //                     const DataColumn2(
  //                       label: Text("ที่ตั้ง"),
  //                       size: ColumnSize.L,
  //                     ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("จังหวัด"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("อำเภอ"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("ตำบล"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("จำนวนกรรมการ"),
  //                       size: ColumnSize.M,
  //                       numeric: true,
  //                     ),
  //                   ],
  //                   rows: [],
  //                   // rows: List.generate(
  //                   //   listProvinceSummary.length,
  //                   //   (index) =>
  //                   //       StationDataRow(context, index, listProvinceSummary[index]),
  //                   // ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }),
  //   );
  // }
}

// DataRow StationDataRow(
//     BuildContext context, int index, ProvinceSummary provinceSummary) {
//   return DataRow(
//     cells: [
//       if (!Responsive.isSmallScreen(context))
//         DataCell(Text(
//           formatterItem.format(index + 1),
//         )),
//       DataCell(
//         Row(
//           children: [
//             // SvgPicture.asset(
//             //   fileInfo.icon!,
//             //   height: 30,
//             //   width: 30,
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//             //   child: Text(provinceSummary.name!),
//             // ),
//             Text(provinceSummary.name!),
//           ],
//         ),
//       ),
//       DataCell(Text(
//         formatterItem.format(provinceSummary.totalStation!),
//       )),
//       // DataCell(Text(fileInfo.size!)),
//     ],
//   );
// }
