import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api.dart';
import '../../../../api/api_end_points.dart';
import '../../../../api/api_params.dart';
import '../../../../api/services/file_attach_service.dart';
import '../../../../api/services/training_service.dart';
import '../../../../api/services/training_type_service.dart';
import '../../../../data/requests/training_service_request.dart';
import '../../../../data/responses/training_service_response.dart';
import '../../../../shared/controller/info_card_controller.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';
import '../../controllers/training_controller.dart';

class ManageTrainingController extends GetxController {
  final logTitle = "ManageTrainingController";
  RxBool isLoading = true.obs;
  InfoCardController infoCardController = Get.put(InfoCardController());
  TrainingController trainingController = Get.put(TrainingController());
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final trainingList = <TrainingData>[].obs;
  final trainings = <Trainings>[].obs;
  final trainingTypeList = <String>[].obs;
  Rx<String> selectedTrainingType = "".obs;

  final trainingName = TextEditingController();
  final trainingDateForm = TextEditingController();
  final trainingDateTo = TextEditingController();
  final trainingType = TextEditingController();
  final trainingTotal = TextEditingController(text: "0");

  RxString trainingError = ''.obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

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
    trainingList.clear();
    super.onClose();
  }

  Future<bool> save() async {
    talker.info('$logTitle:save:');
    isLoading.value = true;
    bool result = true;
    try {
      talker.info('$logTitle:save:');
      talker.info(
          '$logTitle::save:province:${addressController.selectedProvince.value}');
      talker.info(
          '$logTitle::save:province:${addressController.selectedProvince.value.isEmpty}');
      trainings.add(
        Trainings(
          trainingDateForm: trainingDateForm.text,
          trainingDateTo: trainingDateTo.text,
          trainingName: trainingName.text,
          trainingTotal: int.parse(trainingTotal.text),
          trainingType: selectedTrainingType.value,
          province: addressController.selectedProvince.value,
        ),
      );
      final response = await TrainingService().create(trainings.obs.value);
      talker.debug('response message : ${response?.message}');
      if (response?.code == "000") {
        for (var item in response!.data!) {
          trainingList.add(
            TrainingData(
              id: item.id,
              trainingDateForm: item.trainingDateForm,
              trainingDateTo: item.trainingDateTo,
              trainingName: item.trainingName,
              trainingTotal: item.trainingTotal,
              trainingType: item.trainingType,
              province: item.province,
            ),
          );
          //upload image profile
          final bytesProfile = await fileUpload.value.readAsBytes();
          final sizeProfile = await fileUpload.value.length();
          if (fileUpload.value.name != '') {
            await FileAttachService().create(
              fileUpload.value.name,
              sizeProfile,
              bytesProfile,
              "training",
              "profiles",
              item.id.toString(),
            );
          }
        }
        isLoading.value = false;
        trainings.clear();
        // addressController.selectedProvince.value = '';
        resetForm();
        // return true;
      }
      result = true;
    } catch (e) {
      talker.error('$e');
      result = false;
    }
    return result;
  }

  // Future<bool> saveTraining() async {
  //   talker.info('$logTitle:saveTraining:');
  //   isLoading.value = true;
  //   try {
  //     for (var training in trainingList) {
  //       trainings.add(
  //         Trainings(
  //           trainingDateForm: training.trainingDateForm,
  //           trainingDateTo: training.trainingDateTo,
  //           trainingName: training.trainingName,
  //           trainingTotal: training.trainingTotal,
  //           trainingType: training.trainingType,
  //           province: training.province!,
  //         ),
  //       );
  //     }
  //     final result = await TrainingService().create(trainings.obs.value);
  //     talker.debug('response message : ${result?.message}');
  //     if (result?.code == "000") {
  //       return true;
  //     }
  //     isLoading.value = false;
  //     trainingList.clear();
  //     trainings.clear();
  //     addressController.selectedProvince.value = '';
  //     resetForm();
  //     return true;
  //   } catch (e) {
  //     talker.error('$e');
  //     // trainingError.obs.value = '$e';
  //     return false;
  //   }
  // }

  edit() async {
    talker.info('$logTitle:editData:$selectedIndexFromTable');
    isLoading.value = true;
    try {
      trainings.add(
        Trainings(
          id: selectedId,
          trainingDateForm: trainingDateForm.text,
          trainingDateTo: trainingDateTo.text,
          trainingName: trainingName.text,
          trainingTotal: int.parse(trainingTotal.text),
          trainingType: selectedTrainingType.value,
          province: addressController.selectedProvince.value,
        ),
      );
      final result = await TrainingService().update(trainings.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        for (var item in result!.data!) {
          trainingList[selectedIndexFromTable].trainingName = item.trainingName;
          trainingList[selectedIndexFromTable].trainingDateForm =
              item.trainingDateForm;
          trainingList[selectedIndexFromTable].trainingDateTo =
              item.trainingDateTo;
          trainingList[selectedIndexFromTable].trainingType = item.trainingType;
          trainingList[selectedIndexFromTable].province = item.province;
          trainingList[selectedIndexFromTable].trainingTotal =
              item.trainingTotal;
        }
      }
      isLoading.value = false;
      trainingList.refresh();
      trainings.clear();
      selectedIndexFromTable = -1;
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  delete() async {
    talker.info('$logTitle:deleteDataFromTable:$selectedId');
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (trainingList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await TrainingService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('trainingList : ${trainingList.toString()}');
        trainingList.removeAt(selectedIndexFromTable);
        talker.debug('trainingList : ${trainingList.toString()}');
        trainingList.refresh();
      }
    }
  }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    try {
      final result = await TrainingService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        trainingDateForm.text = trainingList[index].trainingDateForm!;
        trainingDateTo.text = trainingList[index].trainingDateTo!;
        trainingName.text = trainingList[index].trainingName!;
        trainingTotal.text = trainingList[index].trainingTotal!.toString();
        selectedTrainingType.value = trainingList[index].trainingType!;
        addressController.selectedProvince.value =
            trainingList[index].province!;
        // get profiles
        Map<String, String> qParams = {
          "module": "training",
          "link_id": item.id!.toString(),
        };
        final profilesAttach = await FileAttachService().getProfiles(qParams);
        talker.debug('$logTitle:profilesAttach : ${profilesAttach.toString()}');
        for (final fileAttach in profilesAttach!.data!) {
          if (fileAttach.id != 0) {
            filePath.value = Api.baseUrl +
                Api.ectApiContext +
                Api.ectApiVersion +
                ApiEndPoints.fileAttach +
                fileAttach.fileUrl!;
          } else {
            filePath.value = 'assets/images/undraw_Add_files_re_v09g.png';
          }
        }
        update();
      }
      isLoading.value = false;
      trainingList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  // deleteDataFromTable() {
  //   talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
  //   if (trainingList.length > selectedIndexFromTable &&
  //       selectedIndexFromTable > -1) {
  //     trainingList.removeAt(selectedIndexFromTable);
  //     selectedIndexFromTable = -1;
  //     resetForm();
  //   }
  // }

  // selectDataFromTable(int index) {
  //   selectedIndexFromTable = index;
  //   talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
  //   talker.debug(trainingList[index].trainingDateForm);
  //   talker.debug(trainingList[index].trainingDateTo);
  //   talker.debug(trainingList[index].trainingName);
  //   talker.debug(trainingList[index].trainingTotal);
  //   talker.debug(trainingList[index].trainingType);
  //   talker.debug(trainingList[index].province);
  //   trainingDateForm.text = trainingList[index].trainingDateForm!;
  //   trainingDateTo.text = trainingList[index].trainingDateTo!;
  //   trainingName.text = trainingList[index].trainingName!;
  //   trainingTotal.text = trainingList[index].trainingTotal!.toString();
  //   selectedTrainingType.value = trainingList[index].trainingType!;
  //   addressController.selectedProvince.value = trainingList[index].province!;
  //   update();
  //   trainingList.refresh();
  // }

  // addDataToTable() {
  //   talker.info('$logTitle:addDataToTable:');
  //   talker.debug(trainingName.text);
  //   talker.debug(trainingDateForm.text);
  //   talker.debug(trainingDateTo.text);
  //   talker.debug(trainingType.text);
  //   talker.debug(trainingTotal.text);
  //   final isValid = formKey.currentState!.validate();
  //   if (isValid) {
  //     if (addressController.selectedProvince.value != '') {
  //       trainingList.add(
  //         TrainingData(
  //           trainingDateForm: trainingDateForm.text,
  //           trainingDateTo: trainingDateTo.text,
  //           trainingName: trainingName.text,
  //           trainingTotal: int.parse(trainingTotal.text),
  //           trainingType: selectedTrainingType.value,
  //           province: addressController.selectedProvince.value,
  //         ),
  //       );
  //       resetForm();
  //     } else {
  //       // talker.info('กรุณเลือก จังหวัด/อำเภอ/ตำบล');
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
    trainingName.text = "";
    trainingDateForm.text = "";
    trainingDateTo.text = "";
    trainingType.text = "";
    trainingTotal.text = "0";
    selectedTrainingType.value = '';
    // addressController.selectedProvince.value = '';
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
