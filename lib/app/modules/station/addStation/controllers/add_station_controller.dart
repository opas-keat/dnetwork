import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';
import '../../../../shared/utils.dart';

class AddStationController extends GetxController {
  final logTitle = "AddStationController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getAddStation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAddStation() async {
    talker.info('$logTitle:getAddStation:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
