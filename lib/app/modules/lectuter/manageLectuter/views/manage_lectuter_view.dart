import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_lectuter_controller.dart';

class ManageLectuterView extends GetView<ManageLectuterController> {
  const ManageLectuterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageLectuterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageLectuterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
