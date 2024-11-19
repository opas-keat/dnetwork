import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../data/responses/member_service_response.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_chart.dart';
import '../../../../shared/show_province.dart';
import '../../../member/controllers/member_controller.dart';
import '../../../training/controllers/training_controller.dart';
import '../controllers/dashboard_detail_controller.dart';

class DashboardDetailLayoutLarge extends StatelessWidget {
  const DashboardDetailLayoutLarge({super.key});
  @override
  Widget build(BuildContext context) {
    final DashboardDetailController controller =
        Get.find<DashboardDetailController>();
    final trainingController = Get.put(TrainingController());
    final memberController = Get.put(MemberController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShowProvince(),
                  Spacer(flex: 2),
                  SizedBox(width: defaultPadding / 2),
                ],
              ),
              const SizedBox(height: defaultPadding),
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
              // DashboardStatistics(),
              // แถวบนสุด
              Row(
                children: [
                  Image.network(
                    "assets/images/seal/Seal_Bangkok.png",
                    height: 60,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Expanded(
                    child: Container(
                      height: 80, // ขนาดคงที่
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: defaultPadding / 2),
                            child: const Wrap(
                              direction: Axis.vertical,
                              runAlignment: WrapAlignment.start,
                              children: [
                                Text(
                                  "ชื่อ ศส.ปชต. :กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ที่ตั้ง :กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "ชื่อ ศส.ปชต. : กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Facebook/Location: กรุงเทพมหานตร",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<TrainingController>(
                        builder: (_) => trainingController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : MainChart(
                                header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                                subHeader: "ประเภทการอบรม",
                                listSummaryChart:
                                    trainingController.summaryChart.obs.value,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding / 2),
                      child: GetBuilder<MemberController>(
                        builder: (_) => memberController.isLoadingChart.value
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 500,
                                child: DashboardDetailNetwork(
                                  header: "ข้อมูลสมาชิก",
                                  subHeader: "",
                                  listMember: memberController
                                      .listMemberStatistics.obs.value,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(defaultPadding),
                      ),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 2),
                        child: const Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.start,
                          children: [
                            CustomText(
                              text: "ผลการดำเนินงาน ศส.ปชต.",
                              weight: FontWeight.bold,
                              size: 20,
                            ),
                            CustomText(
                              text: "หัวข้อดำเนินการ",
                              weight: FontWeight.bold,
                              size: 18,
                            ),
                            Text(
                              "1.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "2.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "3.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "4.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "5.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: GetBuilder<TrainingController>(
              builder: (_) => trainingController.isLoadingChart.value
                  ? const Center(child: CircularProgressIndicator())
                  : MainChart(
                      header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                      subHeader: "ประเภทการอบรม",
                      listSummaryChart:
                          trainingController.summaryChart.obs.value,
                    ),
            ),
            // child: MainChart(
            //   header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
            //   subHeader: "ประเภทการอบรม",
            //   listSummaryChart: summaryDashboardChart,
            // ),
          ),
        ),
      ],
    );
  }
}

class DashboardDetailNetwork extends StatelessWidget {
  const DashboardDetailNetwork({
    super.key,
    this.header = "",
    this.subHeader = "",
    this.listMember = const [],
  });

  final String header;
  final String subHeader;
  final List<MemberData> listMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: header,
            weight: FontWeight.bold,
            size: 12,
          ),
          const SizedBox(height: defaultPadding / 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var member in listMember)
                    Container(
                      margin: const EdgeInsets.only(top: defaultPadding),
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: primaryColor.withOpacity(0.2),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(defaultPadding),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: member.memberFirstName,
                                    weight: FontWeight.bold,
                                    scale: 0.8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
