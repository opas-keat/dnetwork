import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/main_drawer.dart';
import '../controllers/add_data_controller.dart';

class AddDataView extends GetView<AddDataController> {
  const AddDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddDataView'),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text(
          'AddDataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
