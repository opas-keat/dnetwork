import 'package:frontend/app/data/models/users.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final logTitle = "SettingController";
  var isLoading = true.obs;

  List provinceSettingList = listProvinceSetting;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  
}
