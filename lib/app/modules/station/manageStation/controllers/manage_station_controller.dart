import 'package:flutter/material.dart';
import 'package:frontend/app/data/models/station_model.dart';
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

  final tffName = TextEditingController();
  final tffLocaion = TextEditingController();
  final tffProvince = TextEditingController();
  // final amphureController = TextEditingController();
  // final tambolController = TextEditingController();
  final facebook = TextEditingController();
  final process = TextEditingController();

  Future<bool> saveStation() async {
    talker.info('$logTitle:saveStation:');
    isLoading.value = true;
    try {
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

  addToDataTable() {
    talker.info('$logTitle:addToDataTable:');
    stationList.add(
      StationData(
        name: tffName.text,
        province: addressController.selectedProvince.value,
        amphure: addressController.selectedAmphure.value,
        facebook: facebook.text,
        process: process.text,
        district: addressController.selectedTambol.value,
        location: tffLocaion.text,
        totalComiss: 0,
        totalMember: 0,
      ),
    );
    stations.add(
      Stations(
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
        location: tffLocaion.text,
        name: tffName.text,
        process: process.text,
        province: addressController.selectedProvince.value,
        totalComiss: 0,
      ),
    );
    resetForm();
  }

  resetForm() {
    tffName.text = "";
    tffLocaion.text = "";
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
