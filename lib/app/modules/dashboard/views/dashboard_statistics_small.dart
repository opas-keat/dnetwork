import 'package:flutter/material.dart';

import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class DashboardStatisticsSmall extends StatelessWidget {
  DashboardStatisticsSmall({
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
            Row(
              children: const [
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
              itemCount: listProvinceSummary.length,
              itemBuilder: (context, index) {
                return DashboardStatisticsSmallRow(
                    index, listProvinceSummary[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget DashboardStatisticsSmallRow(int index, ProvinceSummary provinceSummary) {
  return Row(
    children: [
      Image.network(
        "assets/images/seal/${provinceSummary.seal}",
        height: 38,
      ),
      Expanded(
        flex: 8,
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
                    scale: 0.9,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "ศส.ปชต. : ${formatterItem.format(provinceSummary.totalStation!)}",
                    scale: 0.9,
                  ),
                  CustomText(
                    text:
                        "กรรมการ : ${formatterItem.format(provinceSummary.totalCommiss!)}",
                    scale: 0.9,
                  ),
                  CustomText(
                    text:
                        "สมาชิก : ${formatterItem.format(provinceSummary.totalMember!)}",
                    scale: 0.9,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "เครือข่าย : ${formatterItem.format(provinceSummary.totalNetwork!)}",
                    scale: 0.9,
                  ),
                  CustomText(
                    text:
                        "หมู่บ้าน : ${formatterItem.format(provinceSummary.totalVillage!)}",
                    scale: 0.9,
                  ),
                  CustomText(
                    text:
                        "วิทยากร : ${formatterItem.format(provinceSummary.totalLectuter!)}",
                    scale: 0.9,
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
