import 'package:flutter/material.dart';
import 'package:frontend/app/shared/custom_text.dart';
import 'package:get/get.dart';

import '../../../data/models/module.dart';
import '../../../data/models/summary_info.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils.dart';
import '../controllers/dashboard_controller.dart';

class SummaryInfoCard extends StatelessWidget {
  SummaryInfoCard({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });
  final DashboardController controller = Get.find<DashboardController>();

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: controller,
        builder: (controller) {
          // loading
          if (controller.isLoadingSummaryStation.value) {
            return Center(
              child: const CircularProgressIndicator().reactive(),
            );
          }
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
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          getModuleByNameEn(listSummaryInfoModel[index].nameEn)
                              .icon,
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
                        CustomText(
                          text: formatterItem
                              .format(listSummaryInfoModel[index].value),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
