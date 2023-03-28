import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/commiss_controller.dart';

class CommissView extends GetView<CommissController> {
  const CommissView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommissView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CommissView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
