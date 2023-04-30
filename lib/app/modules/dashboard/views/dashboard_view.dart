import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/dashboard_controller.dart';

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
              child: SafeArea(
                child: SingleChildScrollView(
                  primary: true,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Header(),
                      const SizedBox(height: defaultPadding),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 4,
                      //       child: Column(
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               const CustomText(
                      //                 text: "กกต ส่วนกลาง",
                      //                 weight: FontWeight.bold,
                      //                 size: 18,
                      //               ),
                      //               const Spacer(flex: 2),
                      //               ElevatedButton.icon(
                      //                 onPressed: () {},
                      //                 style: ElevatedButton.styleFrom(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       vertical: defaultPadding,
                      //                       horizontal: defaultPadding / 2),
                      //                 ),
                      //                 icon: const Icon(
                      //                   Icons.insert_drive_file_sharp,
                      //                 ),
                      //                 label: const Text('รายงาน'),
                      //               ),
                      //             ],
                      //           ),
                      //           const SizedBox(height: defaultPadding),
                      //           const Responsive(
                      //             smallScreen: CardInfo(
                      //               crossAxisCount: 2,
                      //               childAspectRatio: 2.0,
                      //             ),
                      //             largeScreen: CardInfo(
                      //               childAspectRatio: 2.2,
                      //             ),
                      //           ),
                      //           const SizedBox(height: defaultPadding),
                      //           StatisticsDashboard(),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: StatisticsChart(),
                      //     ),
                      //   ],
                      // ),
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

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: defaultPadding),
//           const DashboardHeader(header: "จำนวนรวม"),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           Responsive(
//             smallScreen: SummaryInfoCard(
//               crossAxisCount: 2,
//               childAspectRatio: 2.0,
//             ),
//             // tablet: FileInfoCardGridView(),
//             largeScreen: SummaryInfoCard(
//               childAspectRatio: 2.2,
//             ),
//           ),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           SummaryStation(),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           SummaryCommiss(),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           SummaryLectuter(),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           SummaryVillage(),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//         ],
//       ),
//     );
//   }
// }
