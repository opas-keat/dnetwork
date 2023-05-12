import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../shared/utils.dart';

class CommissController extends GetxController {
  final logTitle = "CommissController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    getCommiss();
  }



  getCommiss() async {
    talker.info('$logTitle:getCommiss:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
