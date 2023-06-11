import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/lectuter_statistics_data.dart';
import '../../../shared/utils.dart';

class LectuterController extends GetxController {
  final logTitle = "LectuterController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  final listLectuterStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listLectuterStatistics.value = listLectuterStatisticsData;
    update();
    getLectuter();
  }

  getLectuter() async {
    talker.info('$logTitle:getLectuter:');
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
          ? listLectuterStatistics.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listLectuterStatistics.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "agency") {
      ascending
          ? listLectuterStatistics.value
              .sort((a, b) => a.agency.compareTo(b.agency))
          : listLectuterStatistics.value
              .sort((a, b) => b.agency.compareTo(a.agency));
    } else if (field == "affiliate") {
      ascending
          ? listLectuterStatistics.value
              .sort((a, b) => a.affiliate.compareTo(b.affiliate))
          : listLectuterStatistics.value
              .sort((a, b) => b.affiliate.compareTo(a.affiliate));
    } else if (field == "province") {
      ascending
          ? listLectuterStatistics.value
              .sort((a, b) => a.province.compareTo(b.province))
          : listLectuterStatistics.value
              .sort((a, b) => b.province.compareTo(a.province));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
