import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/models/summary_chart.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/header.dart';
import '../../../../shared/main_chart.dart';
import '../../../../shared/main_drawer.dart';
import '../controllers/detail_station_controller.dart';
import 'detail_station.dart';
import 'detail_station_header.dart';

class DetailStationView extends StatelessWidget {
  DetailStationView({Key? key}) : super(key: key);
  DetailStationController controller = Get.put(DetailStationController());

  @override
  Widget build(BuildContext context) {
    // talker.info(Get.arguments!.name);
    // StationStatisticsData stationData = Get.arguments!;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Header(moduleName: "รายละเอียด ศส.ปชต."),
                    const SizedBox(height: defaultPadding),
                    Row(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            defaultPadding,
                                                        horizontal:
                                                            defaultPadding / 2),
                                              ),
                                              onPressed: () {
                                                Get.toNamed(
                                                    Routes.MANAGE_STATION);
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: defaultPadding / 2),
                                        DetailStationHeader(
                                            name: Get.arguments!.name),
                                        const SizedBox(
                                            height: defaultPadding / 2),
                                        DetailStation(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: defaultPadding / 2),
                              const SizedBox(height: defaultPadding),
                            ],
                          ),
                        ),
                        Expanded(
                          child: MainChart(
                            header: "สถิติข้อมูลการอบรมของ ศส.ปชต.",
                            subHeader: "ประเภทการอบรม",
                            listSummaryChart: summaryStationChart,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
