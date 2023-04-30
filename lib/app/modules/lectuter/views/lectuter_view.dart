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
import '../controllers/lectuter_controller.dart';
import 'lectuter_statistics.dart';

class LectuterView extends StatelessWidget {
  LectuterView({Key? key}) : super(key: key);
  LectuterController controller = Get.find<LectuterController>();
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
                      const Header(moduleName: "วิทยากรประชาธิปไตย"),
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
                                      label: const CustomText(
                                        text: "รายงาน",
                                        color: Colors.white,
                                      ),
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
                                      label: const CustomText(
                                        text: "เพิ่ม/แก้ไข",
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
                                    listSummaryInfo: listLectuterSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listLectuterSummaryInfo,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                LectuterStatistics(),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              child: SingleChildScrollView(
                                child: MainChart(
                                  header: "สถิติข้อมูลวิทยากรประชาธิปไตย",
                                  subHeader: "สังกัดวิทยากร",
                                  listSummaryChart: summaryLectuterChart,
                                ),
                              ),
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
  //     child: GetBuilder<LectuterController>(
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
  //           if (!controller.isLoadingAdd.value) {
  //             return AddLectuterView();
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
  //                         controller.isLoadingAdd.value = false;
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
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("คำนำหน้า"),
  //                         size: ColumnSize.S,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("ชื่อ"),
  //                       size: ColumnSize.S,
  //                     ),
  //                     const DataColumn2(
  //                       label: Text("นามสกุล"),
  //                       size: ColumnSize.S,
  //                     ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("หน่วยงาน"),
  //                         size: ColumnSize.S,
  //                       ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("สังกัด"),
  //                         size: ColumnSize.S,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("เบอร์โทรศัพท์"),
  //                       size: ColumnSize.S,
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
