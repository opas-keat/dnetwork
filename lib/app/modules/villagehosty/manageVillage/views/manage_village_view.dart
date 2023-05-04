import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_village_controller.dart';

class ManageVillageView extends GetView<ManageVillageController> {
  const ManageVillageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageVillageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageVillageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
