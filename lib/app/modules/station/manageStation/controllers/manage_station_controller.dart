import 'package:flutter/material.dart';
import 'package:frontend/app/data/models/station_model.dart';
import 'package:frontend/app/modules/address/controllers/address_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/utils.dart';

class ManageStationController extends GetxController {
  final logTitle = "ManageStationController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final stationList = [].obs;
  final processList = [].obs;

  final tffName = TextEditingController();
  final tffLocaion = TextEditingController();
  final tffProvince = TextEditingController();
  final amphureController = TextEditingController();
  final tambolController = TextEditingController();
  final facebookController = TextEditingController();
  final processController = TextEditingController();

  addStationToDataTable() {
    talker.info('$logTitle:addStationToDataTable:');
    stationList.add(
      StationModel(
        name: tffName.text,
        locaion: tffLocaion.text,
        province: addressController.selectedProvince.value.pName,
        amphure: addressController.selectedAmphure.value.aName,
        tambol: addressController.selectedTambol.value.tName,
        facebook: "-",
        process: "-",
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
