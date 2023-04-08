import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../shared/utils.dart';

class LectuterController extends GetxController {
  final logTitle = "LectuterController";
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getLectuter();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getLectuter() async {
    talker.info('$logTitle:getLectuter:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
