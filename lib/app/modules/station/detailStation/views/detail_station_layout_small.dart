import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/station_statistics_data.dart';
import '../../../../data/models/summary_chart.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_chart.dart';
import '../controllers/detail_station_controller.dart';
import 'detail_station.dart';
import 'detail_station_header.dart';

class DetailStationLayoutSmall extends StatelessWidget {
  DetailStationLayoutSmall({
    super.key,
  });
  DetailStationController controller = Get.put(DetailStationController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              child: CustomText(
                text: "จังหวัด: กรุงเทพมหานคร",
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              icon: const Icon(
                Icons.edit_sharp,
              ),
              label: const CustomText(
                text: "แก้ไข",
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              onPressed: () {
                Get.toNamed(Routes.MANAGE_STATION);
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        DetailStationHeader(name: Get.arguments!.name),
        // DetailStationHeader(name: "กรุงเทพ"),
        const SizedBox(height: defaultPadding / 2),
        DetailStation(),
        const SizedBox(height: defaultPadding / 2),
        // InfoCard(
        //   crossAxisCount: 2,
        //   childAspectRatio: 2.0,
        //   textScale: 1.0,
        //   listSummaryInfo: listStationSummaryInfo,
        // ),
        // const SizedBox(height: defaultPadding / 2),
        // Container(
        //   padding: const EdgeInsets.all(defaultPadding / 2),
        //   decoration: BoxDecoration(
        //     color: canvasColor,
        //     borderRadius: BorderRadius.circular(defaultPadding),
        //   ),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Row(
        //           children: const [
        //             CustomText(
        //               text: "ข้อมูลสถิติรายจังหวัด",
        //               weight: FontWeight.bold,
        //             ),
        //           ],
        //         ),
        //         accentDivider,
        //         ListView.builder(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemCount: listStationStatisticsData.length,
        //           itemBuilder: (context, index) {
        //             return DashboardStatisticsSmallRow(
        //                 index, listStationStatisticsData[index]);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
          subHeader: "ประเภทการอบรม",
          listSummaryChart: summaryStationChart,
        ),
      ],
    );
  }
}

Widget DashboardStatisticsSmallRow(
    int index, StationStatisticsData stationStatisticsData) {
  return Row(
    children: [
      // Image.network(
      //   "assets/images/seal/${provinceSummary.seal}",
      //   height: 38,
      // ),
      Expanded(
        flex: 8,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(
                    "ชื่อ : ${stationStatisticsData.name} ",
                  ),
                  Text(
                    "ที่อยู่ : ${stationStatisticsData.address}",
                  ),
                  Text(
                    "จำนวนกรรมการ/สมาชิก : ${stationStatisticsData.totalCommiss}/${stationStatisticsData.totalMember}",
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 4),
              accentDivider,
            ],
          ),
        ),
      ),
    ],
  );
}
