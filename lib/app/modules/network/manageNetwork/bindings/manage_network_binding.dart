import 'package:get/get.dart';

import '../controllers/manage_network_controller.dart';

class ManageNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageNetworkController>(
      () => ManageNetworkController(),
    );
  }
}
