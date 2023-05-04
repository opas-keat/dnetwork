import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/summary_info.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/main_drawer.dart';
import '../controllers/member_controller.dart';
import 'member_statistics.dart';

class MemberView extends GetView<MemberController> {
  MemberView({Key? key}) : super(key: key);
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
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Header(moduleName: "สมาชิก"),
                      const SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      text: "จังหวัด กรุงเทพมหานคร",
                                      weight: FontWeight.bold,
                                      size: 18,
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
                                    const SizedBox(width: defaultPadding / 2),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding / 2),
                                      ),
                                      icon: const Icon(
                                        Icons.add_sharp,
                                      ),
                                      label: const CustomText(
                                        text: "เพิ่ม/แก้ไข",
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Get.toNamed(Routes.MANAGE_MEMBER);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                Responsive(
                                  smallScreen: InfoCard(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.0,
                                    listSummaryInfo: listMemberSummaryInfo,
                                  ),
                                  largeScreen: InfoCard(
                                    childAspectRatio: 2.2,
                                    listSummaryInfo: listMemberSummaryInfo,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                MemberStatistics(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              child: SingleChildScrollView(
                                child: MainChart(
                                  header: "สถิติข้อมูลสมาชิก ศส.ปชต.",
                                  subHeader: "ตำแหน่งสมาชิก",
                                  listSummaryChart: summaryMemberChart,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
