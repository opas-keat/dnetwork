import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../shared/utils.dart';

class StationController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getStation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getStation() async {
    talker.info('$logTitle:getStation:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
