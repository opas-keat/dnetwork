import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/models/summary_chart.dart';
import 'constant.dart';
import 'custom_text.dart';
import 'utils.dart';

class MainChart extends StatelessWidget {
  const MainChart({
    super.key,
    this.header = "",
    this.subHeader = "",
    this.listSummaryChart = const [],
  });

  final String header;
  final String subHeader;
  final List<SummaryChart> listSummaryChart;

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
          Chart(listSummaryChart: listSummaryChart),
          const SizedBox(height: defaultPadding / 2),
          CustomText(
            text: subHeader,
            weight: FontWeight.bold,
            scale: 0.8,
          ),
          for (var summaryChart in listSummaryChart)
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
                  SizedBox(
                    child: Icon(
                      summaryChart.icon,
                      size: 16,
                      color: summaryChart.color,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: summaryChart.name,
                            weight: FontWeight.bold,
                            scale: 0.8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomText(
                    text: formatterItem.format(summaryChart.value),
                    scale: 0.8,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    this.listSummaryChart = const [],
  }) : super(key: key);

  final List<SummaryChart> listSummaryChart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              // centerSpaceRadius: Responsive.isLargeScreen(context) ? 70 : 40,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: transformToPieChartData(listSummaryChart),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  formatterItem.format(
                    getSummaryValueFromListSummaryChart(listSummaryChart),
                  ),
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
