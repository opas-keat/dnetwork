import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? scale;
  final int? maxLine;

  const CustomText({
    super.key,
    this.text = '',
    this.size = 16,
    this.color = Colors.black87,
    this.weight = FontWeight.normal,
    this.scale = 1.2,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text!.tr,
      child: Text(
        text!.tr,
        textScaler: TextScaler.linear(scale!),
        style: TextStyle(
          // fontSize: size,
          color: color,
          fontWeight: weight,
        ),
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
