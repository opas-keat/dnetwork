import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/utils.dart';

class ManageLectuterController extends GetxController {
  final logTitle = "ManageLectuterController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
  }
}
