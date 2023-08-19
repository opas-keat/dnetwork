import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/training_service.dart';
import '../../../../api/services/training_type_service.dart';
import '../../../../data/requests/training_service_request.dart';
import '../../../../data/responses/training_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageTrainingController extends GetxController {
  final logTitle = "ManageTrainingController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final trainingList = <TrainingData>[].obs;
  final trainings = <Trainings>[].obs;
  final trainingTypeList = <String>[].obs;
  Rx<String> selectedTrainingType = "".obs;

  final formKey = GlobalKey<FormState>();
  final trainingName = TextEditingController();
  final trainingDateForm = TextEditingController();
  final trainingDateTo = TextEditingController();
  final trainingType = TextEditingController();
  final trainingTotal = TextEditingController(text: '0');

  RxString trainingError = ''.obs;

  int selectedIndexFromTable = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listTrainingType();
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

  Future<bool> saveTraining() async {
    talker.info('$logTitle:saveTraining:');
    isLoading.value = true;
    try {
      for (var training in trainingList) {
        trainings.add(
          Trainings(
            trainingDateForm: training.trainingDateForm,
            trainingDateTo: training.trainingDateTo,
            trainingName: training.trainingName,
            trainingTotal: training.trainingTotal,
            trainingType: training.trainingType,
            province: addressController.selectedProvince.value.split('|').last,
          ),
        );
      }
      final result =
          await TrainingService().createTraining(trainings.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      trainingList.clear();
      trainings.clear();
      addressController.selectedProvince.value = '0|';
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      // trainingError.obs.value = '$e';
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (trainingList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      trainingList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(trainingList[index].trainingDateForm);
    talker.debug(trainingList[index].trainingDateTo);
    talker.debug(trainingList[index].trainingName);
    talker.debug(trainingList[index].trainingTotal);
    talker.debug(trainingList[index].trainingType);
    talker.debug(trainingList[index].province);
    trainingDateForm.text = trainingList[index].trainingDateForm!;
    trainingDateTo.text = trainingList[index].trainingDateTo!;
    trainingName.text = trainingList[index].trainingName!;
    trainingTotal.text = trainingList[index].trainingTotal!.toString();
    selectedTrainingType.value = trainingList[index].trainingType!;
    addressController.selectedProvince.value = trainingList[index].province!;
    update();
    trainingList.refresh();
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(trainingName.text);
    talker.debug(trainingDateForm.text);
    talker.debug(trainingDateTo.text);
    talker.debug(trainingType.text);
    talker.debug(trainingTotal.text);
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (addressController.selectedProvince.value != '0|') {
        trainingList.add(
          TrainingData(
            trainingDateForm: trainingDateForm.text,
            trainingDateTo: trainingDateTo.text,
            trainingName: trainingName.text,
            trainingTotal: int.parse(trainingTotal.text),
            trainingType: selectedTrainingType.value,
            province: addressController.selectedProvince.value,
          ),
        );
        resetForm();
      } else {
        // talker.info('กรุณเลือก จังหวัด/อำเภอ/ตำบล');
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
  }

  resetForm() {
    trainingName.text = "";
    trainingDateForm.text = "";
    trainingDateTo.text = "";
    trainingType.text = "";
    trainingTotal.text = "0";
    selectedTrainingType.value = '';
    // addressController.selectedProvince.value = '0|';
    update();
  }

  Future listTrainingType() async {
    talker.info('$logTitle::listTrainingType');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await TrainingTypeService().list(qParams);
      trainingTypeList.clear();
      trainingTypeList.add("");
      for (var item in result!.data!) {
        trainingTypeList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
