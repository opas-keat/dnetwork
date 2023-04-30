import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/utils.dart';

class StatisticsChart extends StatelessWidget {
  StatisticsChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding / 2),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding, horizontal: defaultPadding / 2),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
              weight: FontWeight.bold,
              size: 12,
            ),
            const SizedBox(height: defaultPadding / 2),
            const Chart(),
            const SizedBox(height: defaultPadding / 2),
            const CustomText(
              text: "ประเภทการอบรม",
              weight: FontWeight.bold,
              size: 12,
            ),
            const SizedBox(height: defaultPadding / 2),
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
                  const SizedBox(
                    child: Icon(
                      Icons.edit_document,
                      size: 16,
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Tooltip(
                            message: "การอบรม ศส.ปชต.",
                            child: CustomText(
                              text: "การอบรม ศส.ปชต.",
                              weight: FontWeight.bold,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                    text: formatterItem.format(9999),
                    size: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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
                  const SizedBox(
                    child: Icon(
                      Icons.edit_document,
                      size: 16,
                      color: Color(0xFF26E5FF),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Tooltip(
                            message: "การอบรมของภาครัฐ",
                            child: CustomText(
                              text: "การอบรมของภาครัฐ",
                              weight: FontWeight.bold,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                    text: formatterItem.format(9999),
                    size: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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
                  const SizedBox(
                    child: Icon(
                      Icons.edit_document,
                      size: 16,
                      color: Color(0xFFFFCF26),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Tooltip(
                            message: "การอบรมของสำนักงาน กกต.",
                            child: CustomText(
                              text: "การอบรมของสำนักงาน กกต.",
                              weight: FontWeight.bold,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                    text: formatterItem.format(9999),
                    size: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
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
                  const SizedBox(
                    child: Icon(
                      Icons.edit_document,
                      size: 16,
                      color: Color(0xFFEE2727),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Tooltip(
                            message: "การอบรมการเลือกตั้ง",
                            child: CustomText(
                              text: "การอบรมการเลือกตั้ง",
                              weight: FontWeight.bold,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                    text: formatterItem.format(9999),
                    size: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  formatterItem.format(9999),
                  // style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  //       color: Colors.black87,
                  //       fontWeight: FontWeight.w600,
                  //       height: 0.5,
                  //     ),
                ),
                // Text("of 128GB")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: const Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: const Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: const Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
