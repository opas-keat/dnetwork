import 'package:flutter/material.dart';

import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import 'dashboard_statistics.dart';

class DashboardLayoutLarge extends StatelessWidget {
  DashboardLayoutLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   // color: Colors.amber,
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const CustomText(
    //             text: "กกต ส่วนกลาง",
    //             weight: FontWeight.bold,
    //             size: 18,
    //           ),
    //           const Spacer(flex: 2),
    //           ElevatedButton.icon(
    //             onPressed: () {},
    //             style: ElevatedButton.styleFrom(
    //               padding: const EdgeInsets.symmetric(
    //                   vertical: defaultPadding, horizontal: defaultPadding / 2),
    //             ),
    //             icon: const Icon(
    //               Icons.insert_drive_file_sharp,
    //             ),
    //             label: const CustomText(
    //               text: "รายงาน",
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: defaultPadding / 2),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Container(
    //             color: Colors.blue,
    //             child: Container(
    //               padding: const EdgeInsets.all(defaultPadding / 2),
    //               decoration: const BoxDecoration(
    //                 color: canvasColor,
    //                 borderRadius:
    //                     BorderRadius.all(Radius.circular(defaultPadding / 2)),
    //               ),
    //               child: Column(
    //                 // crossAxisAlignment:
    //                 //     CrossAxisAlignment
    //                 //         .end,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Icon(
    //                         Icons.abc,
    //                         color: primaryColor,
    //                       ),
    //                       const SizedBox(width: defaultPadding / 2),
    //                       CustomText(
    //                         text: "รายงาน",
    //                         weight: FontWeight.bold,
    //                       ),
    //                     ],
    //                   ),
    //                   accentDivider,
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       CustomText(
    //                         text: formatterItem.format(9999),
    //                         // scale: textScale,
    //                         weight: FontWeight.bold,
    //                         color: Colors.black87.withOpacity(0.7),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Container(
    //             color: Colors.blue,
    //             child: CustomText(
    //               text: "รายงาน",
    //             ),
    //           ),
    //           Container(
    //             color: Colors.blue,
    //             child: CustomText(
    //               text: "รายงาน",
    //             ),
    //           ),
    //           Container(
    //             color: Colors.blue,
    //             child: CustomText(
    //               text: "รายงาน",
    //             ),
    //           ),
    //         ],
    //       ),
    //       // InfoCard(
    //       //   childAspectRatio: 2.2,
    //       //   listSummaryInfo:
    //       //       listDashboardSummaryInfo,
    //       // ),
    //       const SizedBox(height: defaultPadding),
    //       DashboardStatistics(),
    //     ],
    //   ),
    // );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "กกต ส่วนกลาง",
                    weight: FontWeight.bold,
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
              InfoCard(
                childAspectRatio: 2.2,
                listSummaryInfo: listDashboardSummaryInfo,
                textScale: 1.4,
              ),
              // Responsive(
              //   smallScreen: InfoCard(
              //     crossAxisCount: 2,
              //     childAspectRatio: 2.0,
              //     listSummaryInfo: listDashboardSummaryInfo,
              //   ),
              //   largeScreen: InfoCard(
              //     childAspectRatio: 2.2,
              //     listSummaryInfo: listDashboardSummaryInfo,
              //   ),
              // ),
              const SizedBox(height: defaultPadding),
              DashboardStatistics(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: MainChart(
              header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
              subHeader: "ประเภทการอบรม",
              listSummaryChart: summaryDashboardChart,
            ),
          ),
        ),
      ],
    );
  }
}
