import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/responses/network_service_response.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/info_card.dart';
import '../../../shared/main_chart.dart';
import '../../../shared/show_province.dart';
import '../controllers/network_controller.dart';

class NetworkLayoutSmall extends StatelessWidget {
  const NetworkLayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NetworkController());
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShowProvince(),
            Spacer(flex: 2),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        InfoCard(
          crossAxisCount: Responsive.isSmallScreen(context) ? 2 : 4,
          childAspectRatio: 2.0,
          textScale: 1.0,
          // listSummaryInfo: listNetworkSummaryInfo,
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
                Row(
                  children: [
                    const CustomText(
                      text: "ข้อมูลภาคีเครือข่าย ศส.ปชต.",
                      weight: FontWeight.bold,
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.refresh_sharp,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                controller.offset.value = 0;
                                controller.currentPage = 1;
                                controller.listNetworkStatistics.clear();
                                controller.networkStationName.text = '';
                                controller.networkFirstName.text = '';
                                controller.networkSurName.text = '';
                                controller.networkIdCard.text = '';
                                controller.networkTelephone.text = '';
                                controller.addressController.selectedProvince
                                    .value = '';
                                controller.addressController.selectedAmphure
                                    .value = '';
                                controller.addressController.selectedTambol
                                    .value = '';
                                controller.listNetwork();
                              },
                              icon: const Icon(
                                Icons.refresh_sharp,
                              ),
                              color: primaryColor,
                            ),
                    ),
                  ],
                ),
                accentDividerTop,
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.listNetworkStatistics.obs.value.length,
                    itemBuilder: (context, index) {
                      return NetworkStatisticsSmallRow(
                          index, controller.listNetworkStatistics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        GetBuilder<NetworkController>(
          builder: (_) => controller.isLoadingChart.value
              ? const Center(child: CircularProgressIndicator())
              : MainChart(
                  header: "สถิติข้อมูลภาคีเครือข่าย ศส.ปชต.",
                  subHeader: "ตำแหน่งภาคีเครือข่าย ",
                  listSummaryChart: controller.summaryChart.obs.value,
                ),
        ),
        // MainChart(
        //   header: "สถิติข้อมูลภาคีเครือข่าย ศส.ปชต.",
        //   subHeader: "",
        //   listSummaryChart: summaryNetworkChart,
        // ),
      ],
    );
  }
}

Widget NetworkStatisticsSmallRow(
  int index,
  NetworkData networkData,
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
                    "ชื่อ-นามสกุล : ${networkData.networkFirstName!} ${networkData.networkSurName!} ",
                scale: 0.9,
              ),
              CustomText(
                text: "เบอร์โทร : ${networkData.networkTelephone}",
                scale: 0.9,
              ),
              CustomText(
                text: "ตำแหน่ง : ${networkData.networkPosition}",
                scale: 0.9,
              ),
              CustomText(
                text: "ว/ด/ป/ แต่งตั้ง : ${networkData.networkDate}",
                scale: 0.9,
              ),
              CustomText(
                text: "สังกัด ศส.ปชต. : ${networkData.networkLocation}",
                scale: 0.9,
                maxLine: 2,
              ),
              CustomText(
                text:
                    "จังหวัด/อำเภอ/ตำบล : ${networkData.province}/${networkData.amphure}/${networkData.district}",
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
