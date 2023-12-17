import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import 'training_layout_large.dart';
import 'training_layout_small.dart';
import 'training_search.dart';

class TrainingView extends StatelessWidget {
  const TrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "การฝึกอบรม",
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.MANAGE_TRAINING);
                  },
                  icon: const Icon(
                    Icons.add_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      TrainingSearch(),
                      barrierDismissible: false,
                    );
                  },
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
      drawer: !Responsive.isLargeScreen(context) ? MainDrawer() : null,
      body: SafeArea(
        child: Responsive(
          smallScreen: Container(
            padding: const EdgeInsets.all(defaultPadding / 2),
            // color: Colors.amber,
            child: const SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  TrainingLayoutSmall(),
                ],
              ),
            ),
          ),
          mediumScreen: Container(
            padding: const EdgeInsets.all(defaultPadding),
            // color: Colors.amber,
            child: const SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  TrainingLayoutSmall(),
                ],
              ),
            ),
          ),
          largeScreen: Row(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => MainDrawer(),
                ),
              ),
              Expanded(
                flex: Responsive.isLargeScreen(context) ? 6 : 1,
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    color: Colors.white,
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(left: defaultPadding / 2),
                        primary: true,
                        child: Column(
                          children: [
                            Header(moduleName: "training"),
                            SizedBox(height: defaultPadding / 2),
                            TrainingLayoutLarge(),
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
  //                     const Header(moduleName: "การฝึกอบรม"),
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
  //                                       Get.toNamed(Routes.MANAGE_TRAINING);
  //                                     },
  //                                   ),
  //                                 ],
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               Responsive(
  //                                 smallScreen: InfoCard(
  //                                   crossAxisCount: 2,
  //                                   childAspectRatio: 2.0,
  //                                   listSummaryInfo: listTrainingSummaryInfo,
  //                                 ),
  //                                 largeScreen: InfoCard(
  //                                   childAspectRatio: 2.2,
  //                                   listSummaryInfo: listTrainingSummaryInfo,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: defaultPadding),
  //                               TrainingStatistics(),
  //                             ],
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: MainChart(
  //                             header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
  //                             subHeader: "ประเภทการอบรม",
  //                             listSummaryChart: summaryTrainingChart,
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
