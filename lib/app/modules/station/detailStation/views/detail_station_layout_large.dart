import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/summary_chart.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_chart.dart';
import 'detail_station.dart';
import 'detail_station_header.dart';

class DetailStationLayoutLarge extends StatelessWidget {
  const DetailStationLayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit_sharp,
                              ),
                              label: const CustomText(
                                text: "แก้ไข",
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding,
                                    horizontal: defaultPadding / 2),
                              ),
                              onPressed: () {
                                Get.toNamed(Routes.MANAGE_STATION);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        DetailStationHeader(name: Get.arguments!.name),
                        const SizedBox(height: defaultPadding / 2),
                        const DetailStation(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding / 2),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: defaultPadding / 2),
            child: MainChart(
              header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
              subHeader: "ประเภทการอบรม",
              listSummaryChart: summaryDashboardChart,
            ),
          ),
        ),
      ],
    );
  }
}
