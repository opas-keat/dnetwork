import 'package:get/get.dart';

import '../controllers/add_lectuter_controller.dart';

class AddLectuterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLectuterController>(
      () => AddLectuterController(),
    );
  }
}
