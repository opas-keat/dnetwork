import 'package:flutter/material.dart';
import 'package:frontend/app/data/responses/budget_service_response.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/budget_service.dart';
import '../../../../api/services/budget_type_service.dart';
import '../../../../data/requests/budget_service_request.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageBudgetController extends GetxController {
  final logTitle = "ManageBudgetController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final budgetList = <BudgetData>[].obs;
  final budgets = <Budgets>[].obs;
  final budgetTypeList = <String>[].obs;
  Rx<String> selectedBudgetType = "".obs;

  RxString budgetError = ''.obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final budgetDate = TextEditingController();
  final budgetType = TextEditingController();
  final budgetBegin = TextEditingController();
  final budgetUsed = TextEditingController();
  final budgetRemain = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
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
    budgetList.clear();
    super.onClose();
  }

  save() async {
    talker.info('$logTitle:saveBudget:');
    isLoading.value = true;
    try {
      talker.info('$logTitle:save:');
      talker.info(
          '$logTitle::save:province:${addressController.selectedProvince.value}');
      talker.info(
          '$logTitle::save:province:${addressController.selectedProvince.value.isEmpty}');
      talker.debug(budgetDate.text);
      talker.debug(budgetType.text);
      talker.debug(budgetBegin.text);
      talker.debug(budgetUsed.text);
      talker.debug(budgetRemain.text);
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        if (addressController.selectedProvince.value != '') {
          budgets.add(
            Budgets(
              budgetBegin: int.parse(budgetBegin.text),
              budgetDate: budgetDate.text,
              budgetRemain: int.parse(budgetRemain.text),
              budgetType: selectedBudgetType.value,
              budgetUsed: int.parse(budgetUsed.text),
              province: addressController.selectedProvince.value,
            ),
          );
          final result = await BudgetService().createBudget(budgets.obs.value);
          talker.debug('response message : ${result?.message}');
          if (result?.code == "000") {
            for (var item in result!.data!) {
              budgetList.add(
                BudgetData(
                  id: item.id,
                  budgetBegin: item.budgetBegin,
                  budgetDate: item.budgetDate,
                  budgetRemain: item.budgetRemain,
                  budgetType: item.budgetType,
                  budgetUsed: item.budgetUsed,
                  province: item.province,
                ),
              );
            }
            isLoading.value = false;
            budgets.clear();
            // addressController.selectedProvince.value = '';
            resetForm();
            return true;
          }
        } else {
          final result = await Get.dialog(
            AlertDialog(
              content: const Text('กรุณาเลือก จังหวัด'),
              actions: [
                TextButton(
                  child: const Text("ปิด"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
          // if (result) {
          return false;
          // }
        }
      }
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  // Future<bool> saveBudget() async {
  //   talker.info('$logTitle:saveBudget:');
  //   isLoading.value = true;
  //   try {
  //     // for (var budget in budgetList) {
  //     //   budgets.add(
  //     //     Budgets(
  //     //       budgetBegin: budget.budgetBegin,
  //     //       budgetDate: budget.budgetDate,
  //     //       budgetRemain: budget.budgetRemain,
  //     //       budgetType: budget.budgetType,
  //     //       budgetUsed: budget.budgetUsed,
  //     //       province: budget.province!,
  //     //     ),
  //     //   );
  //     // }
  //     final result = await BudgetService().createBudget(budgets.obs.value);
  //     talker.debug('response message : ${result?.message}');
  //     if (result?.code == "000") {
  //       isLoading.value = false;
  //       // budgetList.clear();
  //       budgets.clear();
  //       addressController.selectedProvince.value = '';
  //       resetForm();
  //       return true;
  //     }

  //     return true;
  //   } catch (e) {
  //     talker.error('$e');
  //     return false;
  //   }
  // }

  editData() async {
    talker.info('$logTitle:editData:$selectedIndexFromTable');
    isLoading.value = true;
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        if (addressController.selectedProvince.value != '') {
          budgets.add(
            Budgets(
              id: selectedId,
              budgetBegin: int.parse(budgetBegin.text),
              budgetDate: budgetDate.text,
              budgetRemain: int.parse(budgetRemain.text),
              budgetType: selectedBudgetType.value,
              budgetUsed: int.parse(budgetUsed.text),
              province: addressController.selectedProvince.value,
            ),
          );
          final result = await BudgetService().updateBudget(budgets.obs.value);
          talker.debug('response message : ${result?.message}');
          if (result?.code == "000") {
            for (var item in result!.data!) {
              budgetList[selectedIndexFromTable].budgetDate = item.budgetDate;
              budgetList[selectedIndexFromTable].budgetType = item.budgetType;
              budgetList[selectedIndexFromTable].province = item.province;
              budgetList[selectedIndexFromTable].budgetBegin = item.budgetBegin;
              budgetList[selectedIndexFromTable].budgetRemain =
                  item.budgetRemain;
              budgetList[selectedIndexFromTable].budgetUsed = item.budgetUsed;
              budgetList[selectedIndexFromTable].province = item.province;
            }
          }
          isLoading.value = false;
          budgetList.refresh();
          budgets.clear();
          // addressController.selectedProvince.value = '';
          selectedIndexFromTable = -1;
          resetForm();
        } else {
          Get.dialog(
            AlertDialog(
              content: const Text('กรุณาเลือก จังหวัด'),
              actions: [
                TextButton(
                  child: const Text("ปิด"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          );
        }
      }
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() async {
    talker.info('$logTitle:deleteDataFromTable:$selectedId');
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (budgetList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await BudgetService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('budgetList : ${budgetList.toString()}');
        budgetList.removeAt(selectedIndexFromTable);
        talker.debug('budgetList : ${budgetList.toString()}');
        budgetList.refresh();
      }
    }
  }

  // deleteDataFromTable() {
  //   talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
  //   if (budgetList.length > selectedIndexFromTable &&
  //       selectedIndexFromTable > -1) {
  //     budgetList.removeAt(selectedIndexFromTable);
  //     selectedIndexFromTable = -1;
  //     resetForm();
  //   }
  // }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    try {
      final result = await BudgetService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        selectedBudgetType.value = item.budgetType!;
        budgetDate.text = item.budgetDate!;
        budgetBegin.text = item.budgetBegin!.toString();
        budgetUsed.text = item.budgetUsed!.toString();
        budgetRemain.text = item.budgetRemain!.toString();
        addressController.selectedProvince.value = item.province!;
        update();
      }
      isLoading.value = false;
      budgetList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  // selectDataFromTable(int index) {
  //   selectedIndexFromTable = index;
  //   talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
  //   talker.debug(budgetList[index].budgetType);
  //   talker.debug(budgetList[index].budgetDate);
  //   talker.debug(budgetList[index].budgetBegin);
  //   talker.debug(budgetList[index].budgetUsed);
  //   talker.debug(budgetList[index].budgetRemain);
  //   talker.debug(budgetList[index].province);
  //   // budgetType.text = budgetList[index].budgetType!;
  //   selectedBudgetType.value = budgetList[index].budgetType!;
  //   budgetDate.text = budgetList[index].budgetDate!;
  //   budgetBegin.text = budgetList[index].budgetBegin!.toString();
  //   budgetUsed.text = budgetList[index].budgetUsed!.toString();
  //   budgetRemain.text = budgetList[index].budgetRemain!.toString();
  //   addressController.selectedProvince.value = budgetList[index].province!;
  //   update();
  //   budgetList.refresh();
  // }

  // addDataToTable() {
  //   talker.info('$logTitle:addDataToTable:');
  //   talker.debug(budgetDate.text);
  //   talker.debug(budgetType.text);
  //   talker.debug(budgetBegin.text);
  //   talker.debug(budgetUsed.text);
  //   talker.debug(budgetRemain.text);
  //   final isValid = formKey.currentState!.validate();
  //   if (isValid) {
  //     if (addressController.selectedProvince.value != '') {
  //       budgetList.add(
  //         BudgetData(
  //           budgetBegin: int.parse(budgetBegin.text),
  //           budgetDate: budgetDate.text,
  //           budgetRemain: int.parse(budgetRemain.text),
  //           budgetType: selectedBudgetType.value,
  //           budgetUsed: int.parse(budgetUsed.text),
  //           province: addressController.selectedProvince.value,
  //         ),
  //       );
  //       budgets.add(
  //         Budgets(
  //           budgetBegin: int.parse(budgetBegin.text),
  //           budgetDate: budgetDate.text,
  //           budgetRemain: int.parse(budgetRemain.text),
  //           budgetType: selectedBudgetType.value,
  //           budgetUsed: int.parse(budgetUsed.text),
  //           province: addressController.selectedProvince.value,
  //         ),
  //       );
  //       saveBudget();
  //       // resetForm();
  //     } else {
  //       Get.dialog(
  //         AlertDialog(
  //           content: const Text('กรุณาเลือก จังหวัด'),
  //           actions: [
  //             TextButton(
  //               child: const Text("ปิด"),
  //               onPressed: () => Get.back(),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   }
  // }

  resetForm() {
    budgetDate.text = "";
    budgetType.text = "";
    budgetBegin.text = "";
    budgetUsed.text = "";
    budgetRemain.text = "";
    selectedBudgetType.value = '';
    // addressController.selectedProvince.value = '';
    update();
  }

  Future listBudgetType() async {
    talker.info('$logTitle::listBudgetType');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await BudgetTypeService().list(qParams);
      budgetTypeList.clear();
      budgetTypeList.add("");
      for (var item in result!.data!) {
        budgetTypeList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
