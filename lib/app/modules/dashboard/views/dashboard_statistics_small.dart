import 'package:flutter/material.dart';

import '../../../../responsive.dart';
import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class DashboardStatisticsSmall extends StatelessWidget {
  const DashboardStatisticsSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Row(
              children: [
                CustomText(
                  text: "ข้อมูลสถิติรายจังหวัด",
                  weight: FontWeight.bold,
                ),
              ],
            ),
            accentDivider,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listProvinceSummaryData.length,
              itemBuilder: (context, index) {
                return DashboardStatisticsSmallRow(
                  context,
                  index,
                  listProvinceSummaryData[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget DashboardStatisticsSmallRow(
  BuildContext context,
  int index,
  ProvinceSummary provinceSummary,
) {
  return Row(
    children: [
      Image.network(
        "assets/images/seal/${provinceSummary.seal}",
        height: Responsive.isSmallScreen(context) ? 38 : 75,
      ),
      Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            // color: canvasColor,
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  CustomText(
                    text: "จังหวัด : ${provinceSummary.name}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "ศส.ปชต. : ${formatterItem.format(provinceSummary.totalStation!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                  CustomText(
                    text:
                        "กรรมการ : ${formatterItem.format(provinceSummary.totalCommiss!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                  CustomText(
                    text:
                        "สมาชิก : ${formatterItem.format(provinceSummary.totalMember!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "ภาคีเครือข่าย : ${formatterItem.format(provinceSummary.totalNetwork!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                  CustomText(
                    text:
                        "หมู่บ้าน : ${formatterItem.format(provinceSummary.totalVillage!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                  CustomText(
                    text:
                        "วิทยากร : ${formatterItem.format(provinceSummary.totalLectuter!)}",
                    scale: Responsive.isSmallScreen(context) ? 0.9 : 1.2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
