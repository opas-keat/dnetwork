import 'package:get/get.dart';

import '../../../api/services/lectuter_service.dart';
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
    // isLoading.value = true;
    // listLectuterStatistics.value = listLectuterStatisticsData;
    // update();
    // getLectuter();
    listLectuter();
  }

  listLectuter() async {
    talker.info('$logTitle:listLectuter:');
    isLoading.value = true;
    String province = "ฉะเชิงเทรา";
    try {
      final result = await LectuterService().listLectuter(province);
      listLectuterStatistics.clear();
      for (final item in result!.data!) {
        listLectuterStatistics.add(
          LectuterStatisticsData(
            name: item.name,
            telephone: item.telephone,
            agency: item.agency,
            affiliate: item.affiliate,
            province: item.province,
          ),
        );
      }
      isLoading.value = false;
      update();
    } catch (e) {
      talker.error('$e');
    }
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
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "agency") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.agency.compareTo(b.agency))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.agency.compareTo(a.agency));
    } else if (field == "affiliate") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.affiliate.compareTo(b.affiliate))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.affiliate.compareTo(a.affiliate));
    } else if (field == "province") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.province.compareTo(b.province))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.province.compareTo(a.province));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
