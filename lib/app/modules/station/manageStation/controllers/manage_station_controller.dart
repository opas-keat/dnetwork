import 'package:flutter/material.dart';
import 'package:frontend/app/api/api.dart';
import 'package:frontend/app/api/api_end_points.dart';
import 'package:frontend/app/modules/address/controllers/address_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/file_attach_service.dart';
import '../../../../api/services/station_service.dart';
import '../../../../data/requests/station_service_request.dart';
import '../../../../data/responses/station_service_response.dart';
import '../../../../shared/controller/info_card_controller.dart';
import '../../../../shared/utils.dart';
import '../../../dashboard/controllers/dashboard_controller.dart';
import '../../../training/controllers/training_controller.dart';
import '../../controllers/station_controller.dart';

class ManageStationController extends GetxController {
  final logTitle = "ManageStationController";
  RxBool isLoading = true.obs;
  InfoCardController infoCardController = Get.put(InfoCardController());
  StationController stationController = Get.put(StationController());
  DashboardController dashboardController = Get.put(DashboardController());
  TrainingController trainingController = Get.put(TrainingController());
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final stationList = <StationData>[].obs;
  final stations = <Stations>[].obs;
  final processList = [].obs;

  final stationName = TextEditingController();
  final stationFacebook = TextEditingController();
  final stationLocation = TextEditingController();
  final stationProcess = TextEditingController();
  final stationTraining = TextEditingController();

  RxString stationError = ''.obs;

  final processChips = <String>[].obs;
  final trainingChips = <String>[].obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

  @override
  void onInit() {
    talker.info('$logTitle:onInit:');
    super.onInit();
  }

  @override
  void onReady() {
    talker.info('$logTitle:onReady:');
    super.onReady();
  }

  @override
  void onClose() {
    talker.info('$logTitle:onClose:');
    stationList.clear();
    super.onClose();
  }

  checkDuplicate() async {
    talker.info('$logTitle:checkDuplicate:');
    bool result = false;
    try {
      Map<String, String> qParams = {
        "name": stationName.text,
        "province": addressController.selectedProvince.value,
        "amphure": addressController.selectedAmphure.value,
        "district": addressController.selectedTambol.value,
      };
      final checkDuplicate = await StationService().checkDuplicateName(qParams);
      if (checkDuplicate?.code == "000") {
        if (checkDuplicate!.data!.isNotEmpty) {
          result = true;
        }
      }
    } catch (e) {
      talker.error('$e');
      result = false;
    }
    return result;
  }

  save() async {
    isLoading.value = true;
    bool result = true;
    try {
      talker.info('$logTitle:save:');
      talker.debug(stationName.text);
      talker.debug(stationLocation.text);
      talker.debug(addressController.selectedProvince.value);
      talker.debug(addressController.selectedAmphure.value);
      talker.debug(addressController.selectedTambol.value);
      talker.debug(stationFacebook.text);
      talker.debug(processChips.join('|'));
      stations.add(
        Stations(
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
      final response = await StationService().create(stations.obs.value);
      talker.debug('response message : ${response?.message}');
      if (response?.code == "000") {
        for (var item in response!.data!) {
          stationList.add(
            StationData(
              id: item.id,
              name: item.name,
              location: item.location,
              province: item.province,
              amphure: item.amphure,
              district: item.district,
              facebook: item.facebook,
              process: item.process,
              training: item.training,
              totalCommiss: item.totalCommiss,
              totalMember: item.totalMember,
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
              "info",
              "profiles",
              item.id.toString(),
            );
          }
        }
        isLoading.value = false;
        stations.clear();
        resetForm();
      }
      result = true;
    } catch (e) {
      talker.error('$e');
      result = true;
    }
    return result;
  }

  edit() async {
    talker.info('$logTitle:editData:$selectedIndexFromTable');
    isLoading.value = true;
    try {
      stations.add(
        Stations(
          id: selectedId,
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
      final result = await StationService().update(stations.obs.value);

      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        for (var item in result!.data!) {
          stationList[selectedIndexFromTable].name = item.name;
          stationList[selectedIndexFromTable].location = item.location;
          stationList[selectedIndexFromTable].province = item.province;
          stationList[selectedIndexFromTable].amphure = item.amphure;
          stationList[selectedIndexFromTable].district = item.district;
          stationList[selectedIndexFromTable].facebook = item.facebook;
          stationList[selectedIndexFromTable].process = item.process;
          stationList[selectedIndexFromTable].training = item.training;
          stationList[selectedIndexFromTable].totalCommiss = item.totalCommiss;
          stationList[selectedIndexFromTable].totalMember = item.totalMember;
        }
      }
      isLoading.value = false;
      stationList.refresh();
      stations.clear();
      selectedIndexFromTable = -1;
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  // Future<bool> saveStation() async {
  //   talker.info('$logTitle:saveStation:');
  //   isLoading.value = true;
  //   try {
  //     for (var station in stationList) {
  //       stations.add(
  //         Stations(
  //           name: station.name,
  //           location: station.location,
  //           province: station.province!,
  //           amphure: station.amphure!,
  //           district: station.district!,
  //           facebook: station.facebook,
  //           process: station.process,
  //           totalCommiss: 0,
  //           totalMember: 0,
  //           training: station.training,
  //         ),
  //       );
  //     }
  //     final result = await StationService().createStation(stations.obs.value);
  //     talker.debug('response message : ${result?.message}');
  //     if (result?.code == "000") {
  //       return true;
  //     }
  //     isLoading.value = false;
  //     stationList.clear();
  //     stations.clear();
  //     addressController.selectedProvince.value = '';
  //     addressController.selectedAmphure.value = '';
  //     addressController.selectedTambol.value = '';
  //     resetForm();
  //     return true;
  //   } catch (e) {
  //     talker.error('$e');
  //     return false;
  //   }
  // }

  delete() async {
    talker.info('$logTitle:deleteDataFromTable:$selectedId');
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (stationList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await StationService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('stationList : ${stationList.toString()}');
        stationList.removeAt(selectedIndexFromTable);
        talker.debug('trainingList : ${stationList.toString()}');
        stationList.refresh();
      }
    }
  }

  // deleteDataFromTable() {
  //   talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
  //   if (stationList.length > selectedIndexFromTable &&
  //       selectedIndexFromTable > -1) {
  //     stationList.removeAt(selectedIndexFromTable);
  //     selectedIndexFromTable = -1;
  //     resetForm();
  //   }
  // }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    processChips.clear();
    trainingChips.clear();
    try {
      final result = await StationService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        stationName.text = stationList[index].name!;
        stationLocation.text = stationList[index].location!;
        stationFacebook.text = stationList[index].facebook!;
        if (stationList[index].process!.isNotEmpty) {
          processChips.addAll(stationList[index].process!.split('|'));
        }
        if (stationList[index].training!.isNotEmpty) {
          trainingChips.addAll(stationList[index].training!.split('|'));
        }
        talker.info('$logTitle:id:$processChips');
        addressController.selectedProvince.value = stationList[index].province!;
        await addressController.listAmphure();
        addressController.selectedAmphure.value = stationList[index].amphure!;
        await addressController.listTambol();
        addressController.selectedTambol.value = stationList[index].district!;

        // get profiles
        Map<String, String> qParams = {
          "module": "info",
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
      }
      isLoading.value = false;
      stationList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  // selectDataFromTable(int index) {
  //   selectedIndexFromTable = index;
  //   talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
  //   processChips.clear();
  //   trainingChips.clear();
  //   // talker.debug(stationList[index].province);
  //   // talker.debug(stationList[index].amphure);
  //   // talker.debug(stationList[index].district);
  //   // talker.debug(stationList[index].process!.split('|').length);
  //   // talker.debug(stationList[index].process!.toString());
  //   stationName.text = stationList[index].name!;
  //   stationLocation.text = stationList[index].location!;
  //   addressController.selectedProvince.value = stationList[index].province!;
  //   addressController.selectedAmphure.value = stationList[index].amphure!;
  //   addressController.selectedTambol.value = stationList[index].district!;
  //   stationFacebook.text = stationList[index].facebook!;
  //   if (stationList[index].process!.isNotEmpty) {
  //     processChips.addAll(stationList[index].process!.split('|'));
  //   }
  //   if (stationList[index].training!.isNotEmpty) {
  //     trainingChips.addAll(stationList[index].training!.split('|'));
  //   }
  //   update();
  //   stationList.refresh();
  // }

  // addToDataTable() {
  //   talker.info('$logTitle:addToDataTable:');
  //   final isValid = formKey.currentState!.validate();
  //   if (isValid) {
  //     talker.debug(stationName.text);
  //     talker.debug(stationLocation.text);
  //     talker.debug(addressController.selectedProvince.value);
  //     talker.debug(addressController.selectedAmphure.value);
  //     talker.debug(addressController.selectedTambol.value);
  //     talker.debug(stationFacebook.text);
  //     talker.debug(processChips.join());
  //     if (addressController.selectedProvince.value != '' &&
  //         addressController.selectedAmphure.value != '' &&
  //         addressController.selectedTambol.value != '') {
  //       if (stationProcess.text.isNotEmpty) {
  //         processChips.add(stationProcess.text);
  //       }
  //       if (stationTraining.text.isNotEmpty) {
  //         trainingChips.add(stationTraining.text);
  //       }
  //       stationList.add(
  //         StationData(
  //           name: stationName.text,
  //           location: stationLocation.text,
  //           province: addressController.selectedProvince.value,
  //           amphure: addressController.selectedAmphure.value,
  //           district: addressController.selectedTambol.value,
  //           facebook: stationFacebook.text,
  //           process: processChips.join('|'),
  //           training: trainingChips.join('|'),
  //           totalCommiss: 0,
  //           totalMember: 0,
  //         ),
  //       );
  //       resetForm();
  //     } else {
  //       // talker.info('กรุณเลือก จังหวัด/อำเภอ/ตำบล');
  //       Get.dialog(
  //         AlertDialog(
  //           content: const Text('กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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
    stationName.text = "";
    stationLocation.text = "";
    // addressController.selectedProvince.value = '';
    // addressController.selectedAmphure.value = '';
    // addressController.selectedTambol.value = '';
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
