import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_commiss_controller.dart';

class ManageCommissView extends GetView<ManageCommissController> {
  const ManageCommissView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageCommissView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageCommissView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
