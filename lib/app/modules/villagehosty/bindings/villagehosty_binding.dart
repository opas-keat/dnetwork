import 'package:get/get.dart';

import '../controllers/villagehosty_controller.dart';

class VillagehostyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VillageController>(
      () => VillageController(),
    );
  }
}
