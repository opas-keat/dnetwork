import 'package:get/get.dart';

import '../../../api/services/training_service.dart';
import '../../../data/models/training_statistics_data.dart';
import '../../../shared/utils.dart';

class TrainingController extends GetxController {
  final logTitle = "TrainingController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddTraining = true.obs;

  final listTrainingStatistics = <TrainingStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listTrainingStatistics.value = listTrainingStatisticsData;
    // update();
    // getTraining();
    listTraining();
  }

  listTraining() async {
    talker.info('$logTitle:listTraining:');
    isLoading.value = true;
    String province = "";
    try {
      final result = await TrainingService().listTraining(province);
      listTrainingStatistics.clear();
      for (final item in result!.data!) {
        listTrainingStatistics.add(
          TrainingStatisticsData(
            name: item.trainingName,
            date: '${item.trainingDateForm} ถึง ${item.trainingDateTo}',
            type: item.trainingType,
            total: item.trainingTotal,
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

  getTraining() async {
    talker.info('$logTitle:getTraining:');
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
          ? listTrainingStatistics.obs.value
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listTrainingStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "date") {
      ascending
          ? listTrainingStatistics.obs.value
              .sort((a, b) => a.date!.compareTo(b.date!))
          : listTrainingStatistics.obs.value
              .sort((a, b) => b.date!.compareTo(a.date!));
    } else if (field == "type") {
      ascending
          ? listTrainingStatistics.obs.value
              .sort((a, b) => a.type!.compareTo(b.type!))
          : listTrainingStatistics.obs.value
              .sort((a, b) => b.type!.compareTo(a.type!));
    } else if (field == "province") {
      ascending
          ? listTrainingStatistics.obs.value
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listTrainingStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    } else if (field == "total") {
      ascending
          ? listTrainingStatistics.obs.value
              .sort((a, b) => a.total!.compareTo(b.total!))
          : listTrainingStatistics.obs.value
              .sort((a, b) => b.total!.compareTo(a.total!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
