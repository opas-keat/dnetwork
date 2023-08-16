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

  final stationName = TextEditingController();
  final stationFacebook = TextEditingController();
  final stationLocation = TextEditingController();
  final stationProcess = TextEditingController();
  final stationTraining = TextEditingController();

  final processChips = <String>[].obs;
  final trainingChips = <String>[].obs;

  int selectedIndexFromTable = 0;

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
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (stations.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      stations.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(stationList[index].province);
    talker.debug(stationList[index].amphure);
    talker.debug(stationList[index].district);
    stationName.text = stationList[index].name!;
    stationLocation.text = stationList[index].location!;
    addressController.selectedProvince.value = stationList[index].province!;
    // addressController.selectedAmphure.value = stationList[index].amphure!;
    // addressController.selectedTambol.value = stationList[index].district!;
    stationFacebook.text = stationList[index].facebook!;
    stationProcess.text = stationList[index].process!;
    stationTraining.text = stationList[index].training!;
    update();
  }

  addToDataTable() {
    talker.info('$logTitle:addToDataTable:');
    stationList.add(
      StationData(
        name: stationName.text,
        location: stationLocation.text,
        province: addressController.selectedProvince.value,
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
        facebook: stationFacebook.text,
        process: processChips.first,
        training: trainingChips.first,
        totalCommiss: 0,
        totalMember: 0,
      ),
    );
    resetForm();
  }

  resetForm() {
    stationName.text = "";
    stationLocation.text = "";
    addressController.selectedProvince.value = '0|';
    addressController.selectedAmphure.value = '0|';
    addressController.selectedTambol.value = '0|';
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
