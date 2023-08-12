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
    trainings.add(
      Trainings(
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
    update();
  }
}
