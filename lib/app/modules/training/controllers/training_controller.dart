import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/training_service.dart';
import '../../../api/services/training_type_service.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/models/training_statistics_data.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class TrainingController extends GetxController {
  final logTitle = "TrainingController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddTraining = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listTrainingStatistics = <TrainingStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final trainingName = TextEditingController(text: "");
  final trainingDateForm = TextEditingController(text: "");
  final trainingDateTo = TextEditingController(text: "");
  final trainingType = TextEditingController(text: "");

  final summaryChart = <SummaryChart>[].obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listTraining();
    listTrainingType();
  }

  listTrainingType() async {
    talker.info('$logTitle::listTrainingType');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await TrainingTypeService().list(qParams);
      summaryChart.clear();
      for (final item in result!.data!) {
        summaryChart.add(
          SummaryChart(
            icon: Icons.edit_document,
            color: randomColor(),
            name: item.name!,
            value: item.totalData!,
          ),
        );
      }
      isLoadingChart.value = false;
      summaryChart.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  listTraining() async {
    talker.info('$logTitle:listTraining:');
    isLoading.value = true;
    // String province = "";
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
      "training_name": trainingName.text,
      "training_date_form": trainingDateForm.text,
      "training_date_to": trainingDateTo.text,
      "training_type": trainingType.text,
    };
    try {
      final result = await TrainingService().list(qParams);
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
      resetSearch();
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

  resetSearch() {
    trainingName.text = "";
    trainingDateForm.text = "";
    trainingDateTo.text = "";
    trainingType.text = "";
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
