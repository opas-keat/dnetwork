import 'package:get/get.dart';

import '../controllers/manage_commiss_controller.dart';

class ManageCommissBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageCommissController>(
      () => ManageCommissController(),
    );
  }
}
