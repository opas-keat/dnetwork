import 'dart:html';

import 'package:flutter/material.dart';

import 'custom_text.dart';

class ShowProvince extends StatelessWidget {
  const ShowProvince({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: window.sessionStorage["province"]!,
      weight: FontWeight.bold,
    );
  }
}
