import 'package:get/get.dart';

import '../controllers/detail_station_controller.dart';

class DetailStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStationController>(
      () => DetailStationController(),
    );
  }
}
