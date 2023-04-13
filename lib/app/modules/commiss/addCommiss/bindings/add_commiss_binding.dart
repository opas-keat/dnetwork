import 'package:get/get.dart';

import '../controllers/add_commiss_controller.dart';

class AddCommissBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCommissController>(
      () => AddCommissController(),
    );
  }
}
