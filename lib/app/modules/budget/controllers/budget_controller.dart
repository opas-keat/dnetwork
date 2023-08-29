import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/budget_service.dart';
import '../../../api/services/budget_type_service.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/budget_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class BudgetController extends GetxController {
  final logTitle = "BudgetController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listBudgetStatistics = <BudgetData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final budgetDate = TextEditingController(text: "");
  final budgetType = TextEditingController(text: "");
  // final province = TextEditingController();

  final summaryBudgetChart = <SummaryChart>[].obs;

  int currentPage = 1;
  RxInt offset = 0.obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listBudget();
    listBudgetType();
  }

  @override
  void onReady() {
    super.onReady();
    talker.info('$logTitle onReady');
    update();
  }

  @override
  void onClose() {
    talker.info('$logTitle onClose');
    super.onClose();
  }

  selectDataFromTable(int index, BudgetData budgetData) {
    // selectedIndexFromTable = index;
    // talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:index:$index');
    // talker.info('$logTitle:index:$index');
    // isLoading.value = true;
    // manageBudgetController.budgetList.add(budgetData);
  }

  listBudgetType() async {
    talker.info('$logTitle::listBudget');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": queryParamOffset,
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await BudgetTypeService().list(qParams);
      summaryBudgetChart.clear();
      for (final item in result!.data!) {
        summaryBudgetChart.add(
          SummaryChart(
            icon: Icons.edit_document,
            color: randomColor(),
            name: item.name!,
            value: item.totalData!,
          ),
        );
      }
      isLoadingChart.value = false;
      isLoadingChart.refresh();
      summaryBudgetChart.refresh();
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }

  listBudget() async {
    talker.info('$logTitle::listBudget');
    isLoading.value = true;
    // String province = "";
    talker.debug('$logTitle::listBudget:offset:${offset.value}');
    talker.debug('$logTitle::listBudget:budgetDate-${budgetDate.text}');
    talker.debug('$logTitle::listBudget:budgetType-${budgetType.text}');
    talker.debug(
        '$logTitle::listBudget:province-${addressController.selectedProvince.value}');
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "budget_date": budgetDate.text,
      "budget_type": budgetType.text,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await BudgetService().listBudget(qParams);
      for (final item in result!.data!) {
        listBudgetStatistics.add(
          BudgetData(
            id: item.id,
            budgetDate: item.budgetDate,
            budgetType: item.budgetType,
            budgetBegin: item.budgetBegin,
            budgetUsed: item.budgetUsed,
            budgetRemain: item.budgetRemain,
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

  getBudget() async {
    talker.info('$logTitle:getBudget:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  resetSearch() {
    budgetDate.text = "";
    budgetType.text = "";
    update();
  }

  void sort<T>(
    String field,
    int columnIndex,
    bool ascending,
  ) {
    talker.info('$logTitle:sort:$field');
    if (field == "date") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.budgetDate!.compareTo(b.budgetDate!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.budgetDate!.compareTo(a.budgetDate!));
    } else if (field == "type") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.budgetType!.compareTo(b.budgetType!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.budgetType!.compareTo(a.budgetType!));
    } else if (field == "province") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    } else if (field == "budgetBegin") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.budgetBegin!.compareTo(b.budgetBegin!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.budgetBegin!.compareTo(a.budgetBegin!));
    } else if (field == "budgetUsed") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.budgetUsed!.compareTo(b.budgetUsed!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.budgetUsed!.compareTo(a.budgetUsed!));
    } else if (field == "budgetRemain") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.budgetRemain!.compareTo(b.budgetRemain!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.budgetRemain!.compareTo(a.budgetRemain!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
