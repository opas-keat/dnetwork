import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/commiss_statistics_data.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/commiss_service_response.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/commiss_controller.dart';

class CommissLayoutSmall extends StatelessWidget {
  CommissLayoutSmall({
    super.key,
  });
  final CommissController controller = Get.find<CommissController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ShowProvince(),
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
                Get.toNamed(Routes.MANAGE_COMMISS);
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listCommissSummaryInfo,
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
                const Row(
                  children: [
                    CustomText(
                      text: "ข้อมูลสถิติรายจังหวัด",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                accentDividerTop,
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.listCommissStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return CommissStatisticsSmallRow(
                          index, controller.listCommissStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        MainChart(
          header: "สถิติข้อมูลกรรมกา ศส.ปชต.",
          subHeader: "ตำแหน่งกรรมการ",
          listSummaryChart: summaryCommissChart,
        ),
      ],
    );
  }
}

Widget CommissStatisticsSmallRow(
  int index,
  CommissData commissData,
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
                text:
                    "ชื่อ-นามสกุล : ${commissData.commissFirstName!} ${commissData.commissSurName!} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทร : ${commissData.telephone}",
                scale: 0.9,
              ),
              CustomText(
                text: "ตำแหน่ง : ${commissData.position}",
                scale: 0.9,
              ),
              CustomText(
                text: "ว/ด/ป/ แต่งตั้ง : ${commissData.commissDate}",
                scale: 0.9,
              ),
              CustomText(
                text: "สังกัด ศส.ปชต. : ${commissData.commissLocation}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text:
                    "จังหวัด/อำเภอ/ตำบล : ${commissData.province}/${commissData.amphure}/${commissData.district}",
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
