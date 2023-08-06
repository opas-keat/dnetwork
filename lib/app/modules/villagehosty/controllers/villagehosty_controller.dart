import 'package:get/get.dart';

import '../../../api/services/village_service.dart';
import '../../../data/models/village_statistics_data.dart';
import '../../../shared/utils.dart';

class VillageController extends GetxController {
  final logTitle = "VillageController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  final listVillageStatistics = <VillageStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    listVillageStatistics.value = listVillageStatisticsData;
    // update();
    // getVillage();
    listVillage();
  }

  listVillage() async {
    talker.info('$logTitle:listVillage:');
    isLoading.value = true;
    String province = "ฉะเชิงเทรา";
    try {
      final result = await VillageService().listVillage(province);
      listVillageStatistics.clear();
      for (final item in result!.data!) {
        listVillageStatistics.add(
          VillageStatisticsData(
            name: item.name,
            no: item.no,
            address: item.address,
            total: item.total,
          ),
        );
      }
      isLoading.value = false;
      update();
    } catch (e) {
      talker.error('$e');
    }
  }

  getVillage() async {
    talker.info('$logTitle:getVillage:');
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
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "no") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.no!.compareTo(b.no!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.no!.compareTo(a.no!));
    } else if (field == "address") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    } else if (field == "total") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.total!.compareTo(b.total!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.total!.compareTo(a.total!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
