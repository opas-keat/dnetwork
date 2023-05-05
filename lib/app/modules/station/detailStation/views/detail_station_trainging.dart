import 'package:flutter/material.dart';

import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';

class DetailStationTraining extends StatelessWidget {
  DetailStationTraining({
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
                text: "การอบรมของ ศส.ปชต.",
                weight: FontWeight.bold,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                ),
                child: CustomText(
                  text: "ประเภทการอบรม",
                  weight: FontWeight.bold,
                  scale: 0.9,
                ),
              ),
              accentDivider,
              Row(
                children: [
                  Row(
                    children: const [
                      CustomText(
                        text: "1",
                        scale: 0.90,
                      ),
                      SizedBox(width: defaultPadding),
                      CustomText(
                        text: "การอบรมของภาครัฐ : 2565 อบรมการทำงานของภาครัฐ",
                        scale: 0.90,
                      ),
                    ],
                  ),
                ],
              ),
              accentDivider,
              Row(
                children: [
                  Row(
                    children: const [
                      CustomText(
                        text: "2",
                        scale: 0.90,
                      ),
                      SizedBox(width: defaultPadding),
                      CustomText(
                        text:
                            "การอบรมของสำนักงาน กกต. การอบรมระเบียบการสมัครกรรมการ",
                        scale: 0.90,
                      ),
                    ],
                  ),
                ],
              ),
              accentDivider,
              Row(
                children: [
                  Row(
                    children: const [
                      CustomText(
                        text: "3",
                        scale: 0.90,
                      ),
                      SizedBox(width: defaultPadding),
                      CustomText(
                        text:
                            "การอบรมของสำนักงาน กกต. การอบรมระเบียบการสมัครกรรมการ ครั้งที่ 2",
                        scale: 0.90,
                      ),
                    ],
                  ),
                ],
              ),
              accentDivider,
              Row(
                children: [
                  Row(
                    children: const [
                      CustomText(
                        text: "4",
                        scale: 0.90,
                      ),
                      SizedBox(width: defaultPadding),
                      CustomText(
                        text:
                            "การอบรมของสำนักงาน กกต. การอบรมระเบียบการสมัครกรรมการ ครั้งที่ 3",
                        scale: 0.90,
                      ),
                    ],
                  ),
                ],
              ),
              accentDivider,
              Row(
                children: [
                  Row(
                    children: const [
                      CustomText(
                        text: "5",
                        scale: 0.90,
                      ),
                      SizedBox(width: defaultPadding),
                      CustomText(
                        text:
                            "การอบรมของสำนักงาน กกต. การอบรมระเบียบการสมัครกรรมการ ครั้งที่ 4",
                        scale: 0.90,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
