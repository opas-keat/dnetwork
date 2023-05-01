import 'package:get/get.dart';

import '../controllers/manage_station_controller.dart';

class ManageStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageStationController>(
      () => ManageStationController(),
    );
  }
}
