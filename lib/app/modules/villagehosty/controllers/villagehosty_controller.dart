import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/village_statistics_data.dart';
import '../../../shared/utils.dart';

class VillageController extends GetxController {
  final logTitle = "VillageController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  final listVillageStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listVillageStatistics.value = listVillageStatisticsData;
    update();
    getVillage();
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
          ? listVillageStatistics.value.sort((a, b) => a.name.compareTo(b.name))
          : listVillageStatistics.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "no") {
      ascending
          ? listVillageStatistics.value.sort((a, b) => a.no.compareTo(b.no))
          : listVillageStatistics.value.sort((a, b) => b.no.compareTo(a.no));
    } else if (field == "address") {
      ascending
          ? listVillageStatistics.value
              .sort((a, b) => a.address.compareTo(b.address))
          : listVillageStatistics.value
              .sort((a, b) => b.address.compareTo(a.address));
    } else if (field == "total") {
      ascending
          ? listVillageStatistics.value
              .sort((a, b) => a.total.compareTo(b.total))
          : listVillageStatistics.value
              .sort((a, b) => b.total.compareTo(a.total));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
