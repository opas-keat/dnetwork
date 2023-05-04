import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_training_controller.dart';

class ManageTrainingView extends GetView<ManageTrainingController> {
  const ManageTrainingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageTrainingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageTrainingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
