import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';
import '../../../../shared/utils.dart';

class ManageStationController extends GetxController {
  final logTitle = "ManageStationController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;
  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // update();
    // getAddCommiss();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // getAddCommiss() async {
  //   talker.info('$logTitle:getAddStation:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }
}
