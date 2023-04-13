import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';
import '../../../../shared/utils.dart';

class AddLectuterController extends GetxController {
  final logTitle = "AddLectuterController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getAddLectuter();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAddLectuter() async {
    talker.info('$logTitle:getAddLectuter:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
