import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';

class ManageCommissController extends GetxController {
  final logTitle = "ManageCommissController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;




  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
  }
}
