import 'package:flutter/material.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import 'dashboard_statistics_small.dart';

class DashboardLayoutSmall extends StatelessWidget {
  DashboardLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
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
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          listSummaryInfo: listDashboardSummaryInfo,
        ),
        const SizedBox(height: defaultPadding / 2),
        DashboardStatisticsSmall(),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
          subHeader: "ประเภทการอบรม",
          listSummaryChart: summaryDashboardChart,
        ),
      ],
    );
  }
}
