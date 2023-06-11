import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/commiss_statistics_data.dart';
import '../../../shared/utils.dart';

class CommissController extends GetxController {
  final logTitle = "CommissController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  final listCommissStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listCommissStatistics.value = listCommissStatisticsData;
    update();
    getCommiss();
  }

  getCommiss() async {
    talker.info('$logTitle:getCommiss:');
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
          ? listCommissStatistics.value.sort((a, b) => a.name.compareTo(b.name))
          : listCommissStatistics.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "position") {
      ascending
          ? listCommissStatistics.value
              .sort((a, b) => a.position.compareTo(b.position))
          : listCommissStatistics.value
              .sort((a, b) => b.position.compareTo(a.position));
    } else if (field == "commissDate") {
      ascending
          ? listCommissStatistics.value
              .sort((a, b) => a.commissDate.compareTo(b.commissDate))
          : listCommissStatistics.value
              .sort((a, b) => b.commissDate.compareTo(a.commissDate));
    } else if (field == "commissLocation") {
      ascending
          ? listCommissStatistics.value
              .sort((a, b) => a.commissLocation.compareTo(b.commissLocation))
          : listCommissStatistics.value
              .sort((a, b) => b.commissLocation.compareTo(a.commissLocation));
    } else if (field == "address") {
      ascending
          ? listCommissStatistics.value
              .sort((a, b) => a.address.compareTo(b.address))
          : listCommissStatistics.value
              .sort((a, b) => b.address.compareTo(a.address));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
