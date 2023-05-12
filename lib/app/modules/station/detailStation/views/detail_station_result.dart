import 'package:flutter/material.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';

class DetailStationResult extends StatelessWidget {
  const DetailStationResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: canvasColor,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                text: "ผลการดำเนินงาน ศส.ปชต.",
                weight: FontWeight.bold,
              ),
              const SizedBox(height: defaultPadding / 2),
              const Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                ),
                child: CustomText(
                  text: "หัวข้อดำเนินการ",
                  weight: FontWeight.bold,
                  scale: 0.9,
                ),
              ),
              accentDivider,
              const CustomText(
                text: "1. -",
                scale: 0.90,
                maxLine: 2,
              ),
              accentDivider,
              const CustomText(
                text: "2. -",
                scale: 0.90,
                maxLine: 2,
              ),
              accentDivider,
              const CustomText(
                text: "3. -",
                scale: 0.90,
                maxLine: 2,
              ),
              accentDivider,
              const CustomText(
                text: "4. -",
                scale: 0.90,
                maxLine: 2,
              ),
              accentDivider,
              const CustomText(
                text: "5. -",
                scale: 0.90,
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
