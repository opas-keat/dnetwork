import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/member_statistics_data.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';

class MemberLayoutSmall extends StatelessWidget {
  MemberLayoutSmall({
    super.key,
  });
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              icon: const Icon(
                Icons.insert_drive_file_sharp,
                size: 16,
              ),
              label: const CustomText(
                text: "รายงาน",
                color: Colors.white,
                scale: 0.9,
              ),
            ),
            const SizedBox(width: defaultPadding / 2),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add_sharp,
                size: 16,
              ),
              label: const CustomText(
                text: "เพิ่ม/แก้ไข",
                color: Colors.white,
                scale: 0.9,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding / 2),
              ),
              onPressed: () {
                Get.toNamed(Routes.MANAGE_MEMBER);
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          listSummaryInfo: listMemberSummaryInfo,
        ),
        const SizedBox(height: defaultPadding / 2),
        Container(
          padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: const [
                    CustomText(
                      text: "ข้อมูลสถิติรายจังหวัด",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                accentDividerTop,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listMemberStatisticsData.length,
                  itemBuilder: (context, index) {
                    return CommissStatisticsSmallRow(
                        index, listMemberStatisticsData[index]);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
          subHeader: "ตำแหน่งสมาชิก",
          listSummaryChart: summaryMemberChart,
        ),
      ],
    );
  }
}

Widget CommissStatisticsSmallRow(
  int index,
  MemberStatisticsData memberStatisticsData,
) {
  return Row(
    children: [
      // Image.network(
      //   "assets/images/seal/${provinceSummary.seal}",
      //   height: 38,
      // ),
      Expanded(
        flex: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "ชื่อ-นามสกุล : ${memberStatisticsData.name} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทร : ${memberStatisticsData.telephone}",
                scale: 0.9,
              ),
              CustomText(
                text: "ตำแหน่ง : ${memberStatisticsData.position}",
                scale: 0.9,
              ),
              CustomText(
                text: "ว/ด/ป/ แต่งตั้ง : ${memberStatisticsData.commissDate}",
                scale: 0.9,
              ),
              CustomText(
                text:
                    "สังกัด ศส.ปชต. : ${memberStatisticsData.commissLocation}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text: "จังหวัด/อำเภอ/ตำบล : ${memberStatisticsData.address}",
                scale: 0.9,
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
