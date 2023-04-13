import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';
import '../../../../shared/utils.dart';

class AddVillageController extends GetxController {
  final logTitle = "AddVillageController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getAddVillage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAddVillage() async {
    talker.info('$logTitle:getAddVillage:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
