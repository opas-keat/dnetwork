import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/villagehosty_controller.dart';

class VillagehostyView extends GetView<VillagehostyController> {
  const VillagehostyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VillagehostyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VillagehostyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
