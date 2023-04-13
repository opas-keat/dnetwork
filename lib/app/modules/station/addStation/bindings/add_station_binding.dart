import 'package:get/get.dart';

import '../controllers/add_station_controller.dart';

class AddStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStationController>(
      () => AddStationController(),
    );
  }
}
