import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/training_service.dart';
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

  final trainingName = TextEditingController();
  final trainingDateForm = TextEditingController();
  final trainingDateTo = TextEditingController();
  final trainingType = TextEditingController();
  final trainingTotal = TextEditingController(text: '0');

  final trainingList = <TrainingData>[].obs;
  final trainings = <Trainings>[].obs;

  RxString trainingError = ''.obs;

  int selectedIndexFromTable = 0;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // talker.debug(window.sessionStorage["token"]);
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
    trainingType.text = trainingList[index].trainingType!;
    addressController.selectedProvince.value = trainingList[index].province!;
    update();
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(trainingName.text);
    talker.debug(trainingDateForm.text);
    talker.debug(trainingDateTo.text);
    talker.debug(trainingType.text);
    talker.debug(trainingTotal.text);
    trainingList.add(
      TrainingData(
        trainingDateForm: trainingDateForm.text,
        trainingDateTo: trainingDateTo.text,
        trainingName: trainingName.text,
        trainingTotal: int.parse(trainingTotal.text),
        trainingType: trainingType.text,
        province: addressController.selectedProvince.value,
      ),
    );

    resetForm();
  }

  resetForm() {
    trainingName.text = "";
    trainingDateForm.text = "";
    trainingDateTo.text = "";
    trainingType.text = "";
    trainingTotal.text = "0";
    addressController.selectedProvince.value = '0|';
    update();
  }
}
