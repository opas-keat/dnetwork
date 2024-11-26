import 'package:get/get.dart';

import '../../../../data/responses/station_service_response.dart';
import '../../../../shared/utils.dart';

class DashboardDetailController extends GetxController {
  final logTitle = "DashboardDetailController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;

  // RxString selectedProvince = ''.obs;
  final stationList = <StationData>[].obs;
  RxString stationName = ''.obs;

  @override
  void onInit() {
    talker.info('$logTitle:onInit:');
    super.onInit();
  }

  @override
  void onReady() {
    update();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getById() {
    talker.info('$logTitle:getById:');
    talker.info(stationList[0].name);
    stationName.value = stationList[0].name!;
  }
}
