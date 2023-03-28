import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/commiss_controller.dart';

class CommissView extends GetView<CommissController> {
  const CommissView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'กรรมการ',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
