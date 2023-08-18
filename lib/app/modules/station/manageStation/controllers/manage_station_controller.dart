import 'package:flutter/material.dart';
import 'package:frontend/app/modules/address/controllers/address_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/station_service.dart';
import '../../../../data/requests/station_service_request.dart';
import '../../../../data/responses/station_service_response.dart';
import '../../../../shared/utils.dart';

class ManageStationController extends GetxController {
  final logTitle = "ManageStationController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final stationList = <StationData>[].obs;
  final processList = [].obs;

  final stations = <Stations>[].obs;

  RxString stationError = ''.obs;

  final formKey = GlobalKey<FormState>();
  final stationName = TextEditingController();
  final stationFacebook = TextEditingController();
  final stationLocation = TextEditingController();
  final stationProcess = TextEditingController();
  final stationTraining = TextEditingController();

  final processChips = <String>[].obs;
  final trainingChips = <String>[].obs;

  int selectedIndexFromTable = 0;

  @override
  void onInit() {
    talker.info('$logTitle:onInit:');
    super.onInit();
  }

  @override
  void onReady() {
    talker.info('$logTitle:onReady:');
    // processChips.add("[ff,sds]");
    super.onReady();
  }

  @override
  void onClose() {
    talker.info('$logTitle:onClose:');
    super.onReady();
  }

  Future<bool> saveStation() async {
    talker.info('$logTitle:saveStation:');
    isLoading.value = true;
    try {
      for (var station in stationList) {
        stations.add(
          Stations(
            name: station.name,
            location: station.location,
            province: station.province!.split('|').last,
            amphure: station.amphure!.split('|').last,
            district: station.district!.split('|').last,
            facebook: station.facebook,
            process: station.process,
            totalCommiss: 0,
            totalMember: 0,
            training: station.training,
          ),
        );
      }
      final result = await StationService().createStation(stations.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      stationList.clear();
      stations.clear();
      addressController.selectedProvince.value = '0|';
      addressController.selectedAmphure.value = '0|';
      addressController.selectedTambol.value = '0|';
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (stationList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      stationList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    processChips.clear();
    trainingChips.clear();
    // talker.debug(stationList[index].province);
    // talker.debug(stationList[index].amphure);
    // talker.debug(stationList[index].district);
    // talker.debug(stationList[index].process!.split('|').length);
    // talker.debug(stationList[index].process!.toString());
    stationName.text = stationList[index].name!;
    stationLocation.text = stationList[index].location!;
    addressController.selectedProvince.value = stationList[index].province!;
    addressController.selectedAmphure.value = stationList[index].amphure!;
    addressController.selectedTambol.value = stationList[index].district!;
    stationFacebook.text = stationList[index].facebook!;
    if (stationList[index].process!.isNotEmpty) {
      processChips.addAll(stationList[index].process!.split('|'));
    }
    if (stationList[index].training!.isNotEmpty) {
      trainingChips.addAll(stationList[index].training!.split('|'));
    }
    update();
  }

  addToDataTable() {
    talker.info('$logTitle:addToDataTable:');
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      talker.debug(stationName.text);
      talker.debug(stationLocation.text);
      talker.debug(addressController.selectedProvince.value);
      talker.debug(addressController.selectedAmphure.value);
      talker.debug(addressController.selectedTambol.value);
      talker.debug(stationFacebook.text);
      talker.debug(processChips.join());
      if (addressController.selectedProvince.value != '0|' &&
          addressController.selectedAmphure.value != '0|' &&
          addressController.selectedTambol.value != '0|') {
        if (stationProcess.text.isNotEmpty) {
          processChips.add(stationProcess.text);
        }
        if (stationTraining.text.isNotEmpty) {
          trainingChips.add(stationTraining.text);
        }
        stationList.add(
          StationData(
            name: stationName.text,
            location: stationLocation.text,
            province: addressController.selectedProvince.value,
            amphure: addressController.selectedAmphure.value,
            district: addressController.selectedTambol.value,
            facebook: stationFacebook.text,
            process: processChips.join('|'),
            training: trainingChips.join('|'),
            totalCommiss: 0,
            totalMember: 0,
          ),
        );
        resetForm();
      } else {
        // talker.info('กรุณเลือก จังหวัด/อำเภอ/ตำบล');
        Get.dialog(
          AlertDialog(
            content: const Text('กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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
    stationName.text = "";
    stationLocation.text = "";
    // addressController.selectedProvince.value = '0|';
    // addressController.selectedAmphure.value = '0|';
    // addressController.selectedTambol.value = '0|';
    stationFacebook.text = "";
    stationProcess.text = "";
    stationTraining.text = "";
    processChips.clear();
    trainingChips.clear();
    update();
  }

  addProcessToChip(String process) {
    talker.debug('$logTitle::addProcessToChip:$process');
    processChips.add(process);
    stationProcess.text = "";
    talker.debug('$logTitle::addProcessToChip:${processChips.toString()}');
    update();
  }

  deleteProcessToChip(String process) {
    talker.debug('$logTitle::deleteProcessToChip:$process');
    processChips.remove(process);
    update();
  }

  addTrainingToChip(String training) {
    talker.debug('$logTitle::addTrainingToChip:$training');
    trainingChips.add(training);
    stationTraining.text = "";
    talker.debug('$logTitle::addTrainingToChip:${trainingChips.toString()}');
    update();
  }

  deleteTrainingToChip(String training) {
    talker.debug('$logTitle::deleteTrainingToChip:$training');
    trainingChips.remove(training);
    update();
  }

  // getAddCommiss() async {
  //   talker.info('$logTitle:getAddStation:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }
}
