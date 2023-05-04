import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_member_controller.dart';

class ManageMemberView extends GetView<ManageMemberController> {
  const ManageMemberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageMemberView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageMemberView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
