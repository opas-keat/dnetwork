import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/province_summary.dart';
import '../../../shared/utils.dart';

class DashboardController extends GetxController {
  final logTitle = "DashboardController";
  RxBool isLoading = true.obs;
  RxBool isLoadingSummaryInfo = true.obs;
  RxBool isLoadingSummaryStation = true.obs;
  RxBool isLoadingSummaryCommiss = true.obs;
  RxBool isLoadingSummaryLectuter = true.obs;
  RxBool isLoadingSummaryVillage = true.obs;

  final listProvinceSummary = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listProvinceSummary.value = listProvinceSummaryData;
    update();
    // getSummaryData();
  }

  void sort<T>(
    String field,
    int columnIndex,
    bool ascending,
  ) {
    talker.info('$logTitle:sort:$field');
    if (field == "name") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "totalStation") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalStation.compareTo(b.totalStation))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalStation.compareTo(a.totalStation));
    } else if (field == "totalCommiss") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalCommiss.compareTo(b.totalCommiss))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalCommiss.compareTo(a.totalCommiss));
    } else if (field == "totalMember") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalMember.compareTo(b.totalMember))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalMember.compareTo(a.totalMember));
    } else if (field == "totalNetwork") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalNetwork.compareTo(b.totalNetwork))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalNetwork.compareTo(a.totalNetwork));
    } else if (field == "totalLectuter") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalLectuter.compareTo(b.totalLectuter))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalLectuter.compareTo(a.totalLectuter));
    } else if (field == "totalVillage") {
      ascending
          ? listProvinceSummary.obs.value
              .sort((a, b) => a.totalVillage.compareTo(b.totalVillage))
          : listProvinceSummary.obs.value
              .sort((a, b) => b.totalVillage.compareTo(a.totalVillage));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
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
