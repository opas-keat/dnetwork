import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/station_controller.dart';

class StationView extends GetView<StationController> {
  const StationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ศส.ปชต.',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
