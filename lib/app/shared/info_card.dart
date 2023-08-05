import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/module.dart';
import '../data/models/summary_info.dart';
import 'constant.dart';
import 'controller/info_card_controller.dart';
import 'custom_text.dart';
import 'utils.dart';

class InfoCard extends StatelessWidget {
  InfoCard({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.textScale = 1.6,
    // required this.listSummaryInfo,
  });

  final InfoCardController controller = Get.put(InfoCardController());
  // final controller = Get.lazyPut(() => InfoCardController());

  final int crossAxisCount;
  final double childAspectRatio;
  final double textScale;
  // final List<SummaryInfo> listSummaryInfo;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.listSummaryInfo.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: canvasColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultPadding / 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding / 2,
                    top: defaultPadding / 2,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getModuleByNameEn(
                          controller.listSummaryInfo[index].nameEn,
                        ).icon,
                        color: primaryColor,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Expanded(
                        child: CustomText(
                          text: controller.listSummaryInfo[index].name,
                          weight: FontWeight.bold,
                          scale: textScale,
                        ),
                      ),
                    ],
                  ),
                ),
                accentDivider,
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: defaultPadding / 2,
                    right: defaultPadding / 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: formatterItem
                            .format(controller.listSummaryInfo[index].value),
                        scale: textScale,
                        weight: FontWeight.bold,
                        color: Colors.black87.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
