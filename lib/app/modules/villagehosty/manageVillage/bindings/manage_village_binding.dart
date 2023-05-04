import 'package:get/get.dart';

import '../controllers/manage_village_controller.dart';

class ManageVillageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageVillageController>(
      () => ManageVillageController(),
    );
  }
}
