import 'package:flutter/material.dart';
import 'package:frontend/app/shared/custom_text.dart';

import '../data/models/module.dart';
import '../data/models/summary_info.dart';
import 'constant.dart';
import 'utils.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.textScale = 1.6,
    required this.listSummaryInfo,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final double textScale;
  final List<SummaryInfo> listSummaryInfo;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listSummaryInfo.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      // itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
      itemBuilder: (context, index) {
        return Container(
          // padding: const EdgeInsets.all(defaultPadding / 2),
          decoration: const BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 2)),
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
                      getModuleByNameEn(listSummaryInfo[index].nameEn).icon,
                      color: primaryColor,
                    ),
                    const SizedBox(width: defaultPadding / 2),
                    Expanded(
                      child: CustomText(
                        text: listSummaryInfo[index].name,
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
                      text: formatterItem.format(listSummaryInfo[index].value),
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
    );
  }
}
