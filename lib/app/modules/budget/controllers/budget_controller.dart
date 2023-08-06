import 'package:get/get.dart';

import '../../../api/services/budget_service.dart';
import '../../../data/models/budget_statistics_data.dart';
import '../../../shared/utils.dart';

class BudgetController extends GetxController {
  final logTitle = "BudgetController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;

  final listBudgetStatistics = <BudgetStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listBudgetStatistics.value = listBudgetStatisticsData;
    // update();
    // getBudget();
    listBudget();
  }

  listBudget() async {
    talker.info('$logTitle:listBudget:');
    isLoading.value = true;
    String province = "";
    try {
      final result = await BudgetService().listBudget(province);
      listBudgetStatistics.clear();
      for (final item in result!.data!) {
        listBudgetStatistics.add(
          BudgetStatisticsData(
            date: item.budgetDate,
            type: item.budgetType,
            budgetBegin: item.budgetBegin,
            budgetUsed: item.budgetUsed,
            budgetRemain: item.budgetRemain,
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

  getBudget() async {
    talker.info('$logTitle:getBudget:');
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
    if (field == "date") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.date!.compareTo(b.date!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.date!.compareTo(a.date!));
    } else if (field == "type") {
      ascending
          ? listBudgetStatistics.obs.value
              .sort((a, b) => a.type!.compareTo(b.type!))
          : listBudgetStatistics.obs.value
              .sort((a, b) => b.type!.compareTo(a.type!));
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
