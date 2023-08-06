import 'package:get/get.dart';

import '../../../api/services/network_service.dart';
import '../../../data/models/network_statistics.data.dart';
import '../../../shared/utils.dart';

class NetworkController extends GetxController {
  final logTitle = "NetworkController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddNetwork = true.obs;

  final listNetworkStatistics = <NetworkStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listNetworkStatistics.value = listNetworkStatisticsData;
    // update();
    // getNetwork();
    listNetwork();
  }

  listNetwork() async {
    talker.info('$logTitle:listNetwork:');
    isLoading.value = true;
    String province = "";
    try {
      final result = await NetworkService().listNetwork(province);
      listNetworkStatistics.clear();
      for (final item in result!.data!) {
        listNetworkStatistics.add(
          NetworkStatisticsData(
            name: item.name,
            address: item.address,
            telephone: item.telephone,
            position: item.position,
            networkDate: item.networkDate,
            networkLocation: item.networkLocation,
          ),
        );
      }
      isLoading.value = false;
      update();
    } catch (e) {
      talker.error('$e');
    }
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
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "position") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.position!.compareTo(b.position!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.position!.compareTo(a.position!));
    } else if (field == "networkDate") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.networkDate!.compareTo(b.networkDate!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.networkDate!.compareTo(a.networkDate!));
    } else if (field == "networkLocation") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.networkLocation!.compareTo(b.networkLocation!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.networkLocation!.compareTo(a.networkLocation!));
    } else if (field == "address") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
