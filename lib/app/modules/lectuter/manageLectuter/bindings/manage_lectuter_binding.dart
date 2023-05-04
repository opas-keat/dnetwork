import 'package:get/get.dart';

import '../controllers/manage_lectuter_controller.dart';

class ManageLectuterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageLectuterController>(
      () => ManageLectuterController(),
    );
  }
}
