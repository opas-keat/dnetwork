import 'package:get/get.dart';

import '../controllers/lectuter_controller.dart';

class LectuterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectuterController>(
      () => LectuterController(),
    );
  }
}
