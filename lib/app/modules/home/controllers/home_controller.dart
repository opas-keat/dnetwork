import 'package:flutter/material.dart';
import 'package:frontend/app/data/models/module.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class HomeController extends GetxController {
  final logTitle = "HomeController";
  var isLoading = true.obs;

  final Rx<Module> selectedModule = Module(
    id: 1,
    nameTH: "ภาพรวม",
    nameEn: "dashboard",
    icon: Icons.dashboard_sharp,
    url: "",
  ).obs;
  // RxString title = "".obs;

  @override
  void onInit() {
    talker.info('HomeController is onInit');
    // title.value = selectedModule.value.nameTH;
    super.onInit();
  }

  @override
  void onReady() {
    talker.info('HomeController is onReady');
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
