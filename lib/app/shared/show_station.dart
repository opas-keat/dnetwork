import 'package:flutter/material.dart';

import 'custom_text.dart';

class ShowStation extends StatelessWidget {
  ShowStation({
    super.key,
    required this.header,
  });
  String header;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: header,
      weight: FontWeight.bold,
    );
  }
}
