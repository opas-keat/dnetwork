import 'package:flutter/material.dart';

import '../../../shared/constant.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    this.header = "",
  });

  final String header;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      textScaler: const TextScaler.linear(1.5),
      style: const TextStyle(
        color: canvasColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
