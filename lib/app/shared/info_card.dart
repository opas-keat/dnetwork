import 'package:flutter/material.dart';
import 'package:frontend/app/shared/custom_text.dart';

import '../data/models/module.dart';
import '../data/models/summary_info.dart';
import 'constant.dart';
import 'utils.dart';

class InfoCard extends StatelessWidget {
  InfoCard({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.listSummaryInfo,
  });

  final int crossAxisCount;
  final double childAspectRatio;
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
                    getModuleByNameEn(listSummaryInfo[index].nameEn).icon,
                    color: primaryColor,
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Text(
                    listSummaryInfo[index].name,
                    textScaleFactor: 1.3,
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
                    text: formatterItem.format(listSummaryInfo[index].value),
                    scale: 1.6,
                    weight: FontWeight.bold,
                    color: Colors.black87.withOpacity(0.7),
                  ),
                  // Text(
                  //   formatterItem.format(listSummaryInfo[index].value),
                  //   textScaleFactor: 1.8,
                  //   style: TextStyle(
                  //     color: Colors.black87.withOpacity(0.7),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
