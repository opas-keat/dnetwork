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
import '../controllers/network_controller.dart';
import 'network_layout_large.dart';
import 'network_layout_small.dart';
import 'network_statistics.dart';

class NetworkView extends GetView<NetworkController> {
  NetworkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "เครือข่าย",
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
                  NetworkLayoutSmall(),
                ],
              ),
            ),
          ),
          mediumScreen: Container(
            padding: const EdgeInsets.all(defaultPadding),
            // color: Colors.amber,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  NetworkLayoutSmall(),
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
                            const Header(moduleName: "เครือข่าย"),
                            const SizedBox(height: defaultPadding / 2),
                            NetworkLayoutLarge(),
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
  //                     const Header(moduleName: "เครือข่าย"),
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
  //                                       Get.toNamed(Routes.MANAGE_NETWORK);
  //                                     },
  //                                   ),
  //                                 ],
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               Responsive(
  //                                 smallScreen: InfoCard(
  //                                   crossAxisCount: 2,
  //                                   childAspectRatio: 2.0,
  //                                   listSummaryInfo: listNetworkSummaryInfo,
  //                                 ),
  //                                 largeScreen: InfoCard(
  //                                   childAspectRatio: 2.2,
  //                                   listSummaryInfo: listNetworkSummaryInfo,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               NetworkStatistics(),
  //                             ],
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: SizedBox(
  //                             height: MediaQuery.of(context).size.height - 120,
  //                             child: SingleChildScrollView(
  //                               child: MainChart(
  //                                 header: "สถิติข้อมูลเครือข่าย ศส.ปชต.",
  //                                 subHeader: "",
  //                                 listSummaryChart: summaryNetworkChart,
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
}
