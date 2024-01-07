import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/module.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/header.dart';
import '../../../shared/main_drawer.dart';
import '../../../shared/utils.dart';
import '../controllers/new_home_controller.dart';
import 'statistics_chart.dart';
import 'statistics_dashboard2.dart';

class NewHomeView extends GetView<NewHomeController> {
  const NewHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
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
                                      text: "กกต ส่วนกลาง",
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
                                      label: const Text('รายงาน'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding),
                                const Responsive(
                                  smallScreen: CardInfo(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.0,
                                  ),
                                  largeScreen: CardInfo(
                                    childAspectRatio: 2.2,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                const StatisticsDashboard2(),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: StatisticsChart(),
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

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listSummaryInfoModel.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      // itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    getModuleByNameEn(listSummaryInfoModel[index].nameEn).icon,
                    color: primaryColor,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Text(
                    listSummaryInfoModel[index].name,
                    textScaler: const TextScaler.linear(1.3),
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              accentDivider,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatterItem.format(listSummaryInfoModel[index].value),
                    textScaler: const TextScaler.linear(1.8),
                    style: TextStyle(
                      color: Colors.black87.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
