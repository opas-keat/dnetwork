import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_network_controller.dart';

class ManageNetworkView extends GetView<ManageNetworkController> {
  const ManageNetworkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageNetworkView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageNetworkView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
