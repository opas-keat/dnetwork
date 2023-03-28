import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lectuter_controller.dart';

class LectuterView extends GetView<LectuterController> {
  const LectuterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LectuterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LectuterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
