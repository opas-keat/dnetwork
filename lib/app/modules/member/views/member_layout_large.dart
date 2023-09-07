
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/member_controller.dart';
import 'member_statistics.dart';

class MemberLayoutLarge extends StatelessWidget {
  const MemberLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
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
                  const ShowProvince(),
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
                  const SizedBox(width: defaultPadding / 2),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_sharp,
                    ),
                    label: const CustomText(
                      text: "เพิ่ม/แก้ไข",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding,
                          horizontal: defaultPadding / 2),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.MANAGE_MEMBER);
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
              const InfoCard(),
              const SizedBox(height: defaultPadding / 2),
              MemberStatistics(),
              const SizedBox(height: defaultPadding / 2),
              CustomFlatButton(
                onPressed: () {
                  controller.currentPage++;
                  controller.offset.value =
                      ((controller.currentPage * int.parse(queryParamLimit)) -
                          int.parse(queryParamLimit));
                  controller.listMember();
                },
                label: "แสดงข้อมูลเพิ่ม",
                labelStyle: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<MemberController>(
              builder: (_) => controller.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
                      subHeader: "ตำแหน่งสมาชิก",
                      listSummaryChart: controller.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
            //   subHeader: "ตำแหน่งสมาชิก",
            //   listSummaryChart: summaryMemberChart,
            // ),
          ),
        ),
      ],
    );
  }
}
