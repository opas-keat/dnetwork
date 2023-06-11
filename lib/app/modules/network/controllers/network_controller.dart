import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/network_statistics.data.dart';
import '../../../shared/utils.dart';

class NetworkController extends GetxController {
  final logTitle = "NetworkController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddNetwork = true.obs;

  final listNetworkStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listNetworkStatistics.value = listNetworkStatisticsData;
    update();
    getNetwork();
  }

  getNetwork() async {
    talker.info('$logTitle:getNetwork:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  void sort<T>(
    String field,
    int columnIndex,
    bool ascending,
  ) {
    talker.info('$logTitle:sort:$field');
    if (field == "name") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "position") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.position.compareTo(b.position))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.position.compareTo(a.position));
    } else if (field == "commissDate") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.commissDate.compareTo(b.commissDate))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.commissDate.compareTo(a.commissDate));
    } else if (field == "commissLocation") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.commissLocation.compareTo(b.commissLocation))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.commissLocation.compareTo(a.commissLocation));
    } else if (field == "address") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.address.compareTo(b.address))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.address.compareTo(a.address));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
