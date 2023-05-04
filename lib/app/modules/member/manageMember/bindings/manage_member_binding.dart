import 'package:get/get.dart';

import '../controllers/manage_member_controller.dart';

class ManageMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageMemberController>(
      () => ManageMemberController(),
    );
  }
}
