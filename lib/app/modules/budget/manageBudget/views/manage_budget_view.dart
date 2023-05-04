import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_budget_controller.dart';

class ManageBudgetView extends GetView<ManageBudgetController> {
  const ManageBudgetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageBudgetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageBudgetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
