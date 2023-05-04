import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';

class ManageLectuterController extends GetxController {
  final logTitle = "ManageLectuterController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;
  
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

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
  }
}
