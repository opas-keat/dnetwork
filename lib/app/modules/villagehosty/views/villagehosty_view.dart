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
import '../controllers/villagehosty_controller.dart';
import 'village_statistics.dart';

class VillagehostyView extends StatelessWidget {
  VillagehostyView({Key? key}) : super(key: key);
  VillagehostyController controller = Get.find<VillagehostyController>();
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
                      const Header(moduleName: "หมู่บ้าน วิถี ประชาธิปไตย"),
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
                                    listSummaryInfo: listVillageSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listVillageSummaryInfo,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                VillageStatistics(),
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
  //     child: GetBuilder<VillagehostyController>(
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
  //             return AddVillageView();
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
  //                     const DataColumn2(
  //                       label: Text("ชื่อหมู่บ้าน"),
  //                       size: ColumnSize.L,
  //                     ),
  //                     if (!Responsive.isSmallScreen(context))
  //                       const DataColumn2(
  //                         label: Text("หมู่ที่"),
  //                         size: ColumnSize.L,
  //                       ),
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
  //                       label: Text("จำนวนครัวเรือน"),
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
