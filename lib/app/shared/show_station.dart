import 'package:flutter/material.dart';

import 'custom_text.dart';

class ShowStation extends StatelessWidget {
  const ShowStation({
    super.key,
    required this.header,
  });
  final String header;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: header,
      weight: FontWeight.bold,
    );
  }
}
