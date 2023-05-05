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

class DetailStationView extends StatelessWidget {
  DetailStationView({Key? key}) : super(key: key);
  DetailStationController controller = Get.put(DetailStationController());
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
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Expanded(
                                    //   child: Container(
                                    //     // height: 120,
                                    //     // color: Colors.amber,
                                    //     child: Image.network(
                                    //       "assets/images/seal/Seal_Bangkok.png",
                                    //       fit: BoxFit.fill,
                                    //       // height: 100,
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      // flex: 8,
                                      child: Container(
                                        // color: Colors.blue,
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                            .symmetric(
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
                                            SizedBox(
                                              // color: Colors.amber,
                                              height: 120,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Image.network(
                                                    "assets/images/seal/Seal_Bangkok.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                          defaultPadding / 2),
                                                  Expanded(
                                                    flex: 8,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              defaultPadding /
                                                                  2),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: canvasColor,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: const [
                                                              CustomText(
                                                                text:
                                                                    "ชื่อ ศส.ปชต. : ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้ง สาขา 4",
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                scale: 0.9,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: const [
                                                              CustomText(
                                                                text:
                                                                    "ที่ตั้ง : 1434/14 ซ.พหลโยธิน 34",
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                scale: 0.9,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: const [
                                                              CustomText(
                                                                text:
                                                                    "จังหวัด กรุงเทพมหานคร / อำเภอ เขตจตุจักร / ตำบล เสนานิคม",
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                scale: 0.9,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: const [
                                                              CustomText(
                                                                text:
                                                                    "Facebook/Location : https://www.google.co.th/maps/@18.3170581,99.3986862,17z?hl=th",
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                scale: 0.9,
                                                              ),
                                                            ],
                                                          ),
                                                          // const SizedBox(
                                                          //     width:
                                                          //         defaultPadding / 2),
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
                                const SizedBox(height: defaultPadding),
                                Row(children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: defaultPadding),
                              ],
                            ),
                          ),
                          Expanded(
                            // child: StatisticsChart(),
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
            ),
          ],
        ),
      ),
    );
  }
}
