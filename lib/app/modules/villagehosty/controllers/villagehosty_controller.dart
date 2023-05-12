import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../shared/utils.dart';

class VillagehostyController extends GetxController {
  final logTitle = "VillagehostyController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getVillage();
  }



  getVillage() async {
    talker.info('$logTitle:getVillage:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
