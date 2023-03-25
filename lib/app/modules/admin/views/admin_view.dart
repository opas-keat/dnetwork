import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminView extends StatelessWidget {
  AdminView({Key? key}) : super(key: key);
  // AdminController controller = Get.put(AdminController(), permanent: false);
  AdminController controller = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return const Text(
      'AdminView is working',
      style: TextStyle(fontSize: 20),
    );
  }
}
