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
        province: addressController.selectedProvince.value.split('|').last,
      ),
    );
    budgets.add(
      Budgets(
        budgetBegin: int.parse(budgetBegin.text),
        budgetDate: budgetDate.text,
        budgetRemain: int.parse(budgetRemain.text),
        budgetType: budgetType.text,
        budgetUsed: int.parse(budgetUsed.text),
        province: addressController.selectedProvince.value.split('|').last,
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
    update();
  }
}
