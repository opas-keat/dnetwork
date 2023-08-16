import 'package:flutter/material.dart';
import 'package:frontend/app/data/responses/budget_service_response.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/budget_service.dart';
import '../../../../data/requests/budget_service_request.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageBudgetController extends GetxController {
  final logTitle = "ManageTrainingController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final budgetDate = TextEditingController();
  final budgetType = TextEditingController();
  final budgetBegin = TextEditingController(text: '0');
  final budgetUsed = TextEditingController(text: '0');
  final budgetRemain = TextEditingController(text: '0');

  final budgetList = <BudgetData>[].obs;
  final budgets = <Budgets>[].obs;

  RxString budgetError = ''.obs;

  int selectedIndexFromTable = 0;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // talker.debug(window.sessionStorage["token"]);
  }

  Future<bool> saveBudget() async {
    talker.info('$logTitle:saveBudget:');
    isLoading.value = true;
    try {
      for (var budget in budgetList) {
        budgets.add(
          Budgets(
            budgetBegin: budget.budgetBegin,
            budgetDate: budget.budgetDate,
            budgetRemain: budget.budgetRemain,
            budgetType: budget.budgetType,
            budgetUsed: budget.budgetUsed,
            province: budget.province!.split('|').last,
          ),
        );
      }
      final result = await BudgetService().createBudget(budgets.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      budgetList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (budgetList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      talker.debug(budgetList[selectedIndexFromTable].budgetType);
      talker.debug(budgetList[selectedIndexFromTable].budgetDate);
      talker.debug(budgetList[selectedIndexFromTable].budgetBegin);
      talker.debug(budgetList[selectedIndexFromTable].budgetUsed);
      talker.debug(budgetList[selectedIndexFromTable].budgetRemain);
      talker.debug(budgetList[selectedIndexFromTable].province);
      budgetList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(budgetList[index].budgetType);
    talker.debug(budgetList[index].budgetDate);
    talker.debug(budgetList[index].budgetBegin);
    talker.debug(budgetList[index].budgetUsed);
    talker.debug(budgetList[index].budgetRemain);
    talker.debug(budgetList[index].province);
    budgetType.text = budgetList[index].budgetType!;
    budgetDate.text = budgetList[index].budgetDate!;
    budgetBegin.text = budgetList[index].budgetBegin!.toString();
    budgetUsed.text = budgetList[index].budgetUsed!.toString();
    budgetRemain.text = budgetList[index].budgetRemain!.toString();
    addressController.selectedProvince.value = budgetList[index].province!;
    update();
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(budgetDate.text);
    talker.debug(budgetType.text);
    talker.debug(budgetBegin.text);
    talker.debug(budgetUsed.text);
    talker.debug(budgetRemain.text);
    budgetList.add(
      BudgetData(
        budgetBegin: int.parse(budgetBegin.text),
        budgetDate: budgetDate.text,
        budgetRemain: int.parse(budgetRemain.text),
        budgetType: budgetType.text,
        budgetUsed: int.parse(budgetUsed.text),
        province: addressController.selectedProvince.value,
      ),
    );
    resetForm();
  }

  resetForm() {
    budgetDate.text = "";
    budgetType.text = "";
    budgetBegin.text = "0";
    budgetUsed.text = "0";
    budgetRemain.text = "0";
    addressController.selectedProvince.value = '0|';
    update();
  }
}
