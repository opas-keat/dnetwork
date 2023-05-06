import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/commiss_controller.dart';
import 'commiss_layout_large.dart';
import 'commiss_layout_small.dart';
import 'commiss_statistics.dart';

class CommissView extends GetView<CommissController> {
  CommissView({Key? key}) : super(key: key);
  CommissController controller = Get.find<CommissController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "หน้าจอหลัก",
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_sharp,
                  ),
                ),
              ],
            )
          : null,
      drawer: !Responsive.isLargeScreen(context) ? const MainDrawer() : null,
      body: SafeArea(
        child: Responsive(
          smallScreen: Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  CommissLayoutSmall(),
                ],
              ),
            ),
          ),
          mediumScreen: Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  CommissLayoutSmall(),
                ],
              ),
            ),
          ),
          largeScreen: Row(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => const MainDrawer(),
                ),
              ),
              Expanded(
                flex: Responsive.isLargeScreen(context) ? 6 : 1,
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 2),
                        primary: true,
                        child: Column(
                          children: [
                            const Header(moduleName: "กรรมการ"),
                            const SizedBox(height: defaultPadding / 2),
                            CommissLayoutLarge(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Row(
  //         children: [
  //           const Expanded(
  //             child: MainDrawer(),
  //           ),
  //           Expanded(
  //             flex: 5,
  //             child: SingleChildScrollView(
  //               primary: true,
  //               padding: const EdgeInsets.all(defaultPadding),
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     const Header(moduleName: "กรรมการ"),
  //                     const SizedBox(height: defaultPadding),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Expanded(
  //                           flex: 4,
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   const CustomText(
  //                                     text: "จังหวัด กรุงเทพมหานคร",
  //                                     weight: FontWeight.bold,
  //                                     size: 18,
  //                                   ),
  //                                   const Spacer(flex: 2),
  //                                   ElevatedButton.icon(
  //                                     onPressed: () {},
  //                                     style: ElevatedButton.styleFrom(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: defaultPadding,
  //                                           horizontal: defaultPadding / 2),
  //                                     ),
  //                                     icon: const Icon(
  //                                       Icons.insert_drive_file_sharp,
  //                                     ),
  //                                     label: const CustomText(
  //                                       text: "รายงาน",
  //                                       color: Colors.white,
  //                                     ),
  //                                   ),
  //                                   const SizedBox(width: defaultPadding / 2),
  //                                   ElevatedButton.icon(
  //                                     style: ElevatedButton.styleFrom(
  //                                       padding: const EdgeInsets.symmetric(
  //                                           vertical: defaultPadding,
  //                                           horizontal: defaultPadding / 2),
  //                                     ),
  //                                     icon: const Icon(
  //                                       Icons.add_sharp,
  //                                     ),
  //                                     label: const CustomText(
  //                                       text: "เพิ่ม/แก้ไข",
  //                                       color: Colors.white,
  //                                     ),
  //                                     onPressed: () {
  //                                       Get.toNamed(Routes.MANAGE_COMMISS);
  //                                     },
  //                                   ),
  //                                 ],
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               Responsive(
  //                                 smallScreen: InfoCard(
  //                                   crossAxisCount: 2,
  //                                   childAspectRatio: 2.0,
  //                                   listSummaryInfo: listCommissSummaryInfo,
  //                                 ),
  //                                 largeScreen: InfoCard(
  //                                   childAspectRatio: 2.2,
  //                                   listSummaryInfo: listCommissSummaryInfo,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               CommissStatistics(),
  //                             ],
  //                           ),
  //                         ),
  //                         Expanded(
  //                           // child: StatisticsChart(),
  //                           child: SizedBox(
  //                             height: MediaQuery.of(context).size.height - 120,
  //                             child: SingleChildScrollView(
  //                               child: MainChart(
  //                                 header: "สถิติข้อมูลกรรมกา ศส.ปชต.",
  //                                 subHeader: "ตำแหน่งกรรมการ",
  //                                 listSummaryChart: summaryCommissChart,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // final ScrollController _scrollController = ScrollController();
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
  //     child: GetBuilder<CommissController>(
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
  //             return AddCommissView();
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
  //                         size: ColumnSize.L,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("ชื่อ"),
  //                       size: ColumnSize.L,
  //                     ),
  //                     const DataColumn2(
  //                       label: Text("นามสกุล"),
  //                       size: ColumnSize.M,
  //                     ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("ตำแหน่ง"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("ว/ด/ป ที่แต่งตั้ง"),
  //                         size: ColumnSize.M,
  //                       ),
  //                     const DataColumn2(
  //                       label: Text("เบอร์โทรศัพท์"),
  //                       size: ColumnSize.M,
  //                       numeric: true,
  //                     ),
  //                     const DataColumn2(
  //                       label: Text("ศส.ปชต."),
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
