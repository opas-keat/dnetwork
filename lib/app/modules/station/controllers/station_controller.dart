import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../api/services/summary_info_service.dart';
import '../../../data/models/summary_info.dart';
import '../../../data/responses/summary_info_service_response.dart';
import '../../../shared/utils.dart';

class StationController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddStation = true.obs;

  final listStationStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  // final listStationInfo = <SummaryInfoData>[].obs;
  // final listDashboardSummaryInfo = <SummaryInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    // listStationStatistics.value = listStationStatisticsData;
    // update();
    // getSummaryInfo();
    getStation();
  }

  // getSummaryInfo() async {
  //   talker.info('$logTitle:getSummaryInfo:');
  //   try {
  //     final result = await SummaryInfoService().getSummaryInfo();
  //     listStationInfo.clear();
  //     for (final item in result!.data!) {
  //       listDashboardSummaryInfo.add(SummaryInfo(
  //         name: item.name!,
  //         nameEn: item.nameEn!,
  //         value: item.value!,
  //       ));
  //     }
  //     // listDashboardSummaryInfo.addAll(result!.data! as Iterable<SummaryInfo>);
  //     update();
  //     return false;
  //   } catch (e) {
  //     talker.error('$e');
  //     return false;
  //   }
  // }

  getStation() async {
    talker.info('$logTitle:getStation:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  void sort<T>(
    // Comparable<T> Function(StationStatisticsData s) getField,
    String field,
    int columnIndex,
    bool ascending,
  ) {
    // talker.debug(logTitle + ':field:' + field.toString());
    // talker.debug(logTitle + ':sort:' + columnIndex.toString());
    // talker.debug(logTitle + ':ascending:' + ascending.toString());
    if (field == "name") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listStationStatistics.obs.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "address") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.address.compareTo(b.address))
          : listStationStatistics.obs.value
              .sort((a, b) => b.address.compareTo(a.address));
    } else if (field == "totalCommiss") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.totalCommiss.compareTo(b.totalCommiss))
          : listStationStatistics.obs.value
              .sort((a, b) => b.totalCommiss.compareTo(a.totalCommiss));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
