import 'package:flutter/material.dart';

import '../../../../../responsive.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';

class DetailStationHeader extends StatelessWidget {
  DetailStationHeader({
    super.key,
    this.name = "",
    this.location = "",
    this.address = "",
    this.facebook = "",
  });
  final String name;
  final String location;
  final String address;
  final String facebook;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Responsive.isLargeScreen(context) ? 120 : 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(
            "assets/images/seal/Seal_Bangkok.png",
            fit: BoxFit.fill,
            height: Responsive.isLargeScreen(context) ? 100 : 60,
          ),
          const SizedBox(width: defaultPadding / 2),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: canvasColor,
                borderRadius: BorderRadius.circular(defaultPadding),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "ชื่อ ศส.ปชต. : $name",
                    // weight: FontWeight.bold,
                    scale: 0.9,
                    maxLine: 2,
                  ),
                  const CustomText(
                    text: "ที่ตั้ง : 1434/14 ซ.พหลโยธิน 34",
                    // weight: FontWeight.bold,
                    scale: 0.9,
                  ),
                  const CustomText(
                    text:
                        "จังหวัด กรุงเทพมหานคร / อำเภอ เขตจตุจักร / ตำบล เสนานิคม",
                    // weight: FontWeight.bold,
                    scale: 0.9,
                    maxLine: 2,
                  ),
                  const CustomText(
                    text:
                        "Facebook/Location : https://www.google.co.th/maps/@18.3170581,99.3986862,17z?hl=th",
                    // weight: FontWeight.bold,
                    scale: 0.9,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
