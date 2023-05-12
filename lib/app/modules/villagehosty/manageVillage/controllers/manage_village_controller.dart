import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';

class ManageVillageController extends GetxController {
  final logTitle = "ManageVillageController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle:onInit:');
  }



  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
  }
}
