import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? scale;

  const CustomText({
    Key? key,
    this.text = '',
    this.size = 16,
    this.color = Colors.black87,
    this.weight = FontWeight.normal,
    this.scale = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text!.tr,
      child: Text(
        text!.tr,
        textScaleFactor: scale,
        style: TextStyle(
          // fontSize: size,
          color: color,
          fontWeight: weight,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
