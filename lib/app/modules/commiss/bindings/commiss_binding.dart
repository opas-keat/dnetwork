import 'package:get/get.dart';

import '../controllers/commiss_controller.dart';

class CommissBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommissController>(
      () => CommissController(),
    );
  }
}
