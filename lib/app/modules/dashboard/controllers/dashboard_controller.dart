import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../shared/utils.dart';

class DashboardController extends GetxController {
  final logTitle = "DashboardController";
  RxBool isLoadingSummaryInfo = true.obs;
  RxBool isLoadingSummaryStation = true.obs;
  RxBool isLoadingSummaryCommiss = true.obs;
  RxBool isLoadingSummaryLectuter = true.obs;
  RxBool isLoadingSummaryVillage = true.obs;

  @override
  void onInit() {
    super.onInit();
    getSummaryData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSummaryData() {
    getSummaryStation();
    getSummaryCommiss();
    getSummaryLectuter();
    getSummaryVillage();
    // update();
  }

  getSummaryVillage() async {
    talker.info('getListVillage');
    isLoadingSummaryVillage.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  getSummaryLectuter() async {
    talker.info('getListLectuter');
    isLoadingSummaryLectuter.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  getSummaryCommiss() async {
    talker.info('getListCommiss');
    isLoadingSummaryCommiss.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  getSummaryStation() async {
    talker.info('getListStation');
    isLoadingSummaryStation.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  getSummaryInfoCard() async {
    talker.info('getSummaryInfoCard');
    isLoadingSummaryInfo.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
