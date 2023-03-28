import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lectuter_controller.dart';

class LectuterView extends GetView<LectuterController> {
  const LectuterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'วิทยากรประชาธิปไตย',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
