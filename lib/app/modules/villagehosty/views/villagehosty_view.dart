import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/villagehosty_controller.dart';

class VillagehostyView extends GetView<VillagehostyController> {
  const VillagehostyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'หมู่บ้านไม่ขายเสียง',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
