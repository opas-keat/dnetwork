import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/village_service.dart';
import '../../../../data/requests/village_service_request.dart';
import '../../../../data/responses/village_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageVillageController extends GetxController {
  final logTitle = "ManageVillageController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final formKey = GlobalKey<FormState>();
  final villageList = <VillageData>[].obs;
  final villages = <Villages>[].obs;
  final villageName = TextEditingController();
  final villageNo = TextEditingController();
  final villageTotal = TextEditingController(text: "0");
  final villageTotalUsed = TextEditingController(text: "0");
  final villageActivity = TextEditingController();
  final villageActYear = TextEditingController();
  final villageGoalAct = TextEditingController(text: "0");
  final villageGoalAct2 = TextEditingController();
  final villageTypeAct = TextEditingController();
  final election = TextEditingController();
  final villageLocation = TextEditingController();

  RxString villageError = ''.obs;

  final typeActChips = <String>[].obs;

  int selectedIndexFromTable = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
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

  Future<bool> saveVillage() async {
    talker.info('$logTitle:saveVillage:');
    isLoading.value = true;
    try {
      for (var village in villageList) {
        villages.add(
          Villages(
            amphure: village.amphure!.split('|').last,
            district: village.district!.split('|').last,
            province: village.province!.split('|').last,
            election: village.election,
            villageActYear: village.villageActYear,
            villageActivity: village.villageActivity,
            villageGoalAct2: village.villageGoalAct2,
            villageGoalAct: village.villageGoalAct,
            villageLocation: village.villageLocation,
            villageName: village.villageName,
            villageNo: village.villageNo,
            villageTotal: village.villageTotal,
            villageTotalUsed: village.villageTotalUsed,
            villageTypeAct: village.villageTypeAct,
          ),
        );
      }
      final result = await VillageService().createVillage(villages.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      villageList.clear();
      villages.clear();
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
    if (villageList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      villageList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) async {
    selectedIndexFromTable = index;
    typeActChips.clear();
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    election.text = villageList[index].election!;
    villageActYear.text = villageList[index].villageActYear!;
    villageActivity.text = villageList[index].villageActivity!;
    // villageGoalAct2.text = villageList[index].villageGoalAct2!;
    villageGoalAct.text = villageList[index].villageGoalAct!.toString();
    villageLocation.text = villageList[index].villageLocation!;
    villageName.text = villageList[index].villageName!;
    villageNo.text = villageList[index].villageNo!;
    villageTotal.text = villageList[index].villageTotal!.toString();
    villageTotalUsed.text = villageList[index].villageTotalUsed!.toString();
    // villageTypeAct.text = villageList[index].villageTypeAct!;
    if (villageList[index].villageTypeAct!.isNotEmpty) {
      typeActChips.addAll(villageList[index].villageTypeAct!.split('|'));
    }
    addressController.selectedProvince.value = villageList[index].province!;
    // await addressController
    //     .listAmphure(villageList[index].province!.split('|').first);
    // addressController.selectedAmphure.value = villageList[index].amphure!;
    // await addressController
    //     .listTambol(villageList[index].amphure!.split('|').first);
    addressController.selectedTambol.value = villageList[index].district!;
    update();
    villageList.refresh();
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(villageName.text);
    talker.debug(villageNo.text);
    talker.debug(villageTotal.text);
    talker.debug(villageTotalUsed.text);
    talker.debug(villageActivity.text);
    talker.debug(villageActYear.text);
    talker.debug(villageGoalAct.text);
    talker.debug(villageGoalAct2.text);
    talker.debug(villageTypeAct.text);
    talker.debug(election.text);
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (addressController.selectedProvince.value != '0|' &&
          addressController.selectedAmphure.value != '0|' &&
          addressController.selectedTambol.value != '0|') {
        if (villageTypeAct.text.isNotEmpty && villageGoalAct2.text.isNotEmpty) {
          typeActChips.add('${villageTypeAct.text} : ${villageGoalAct2.text}');
        }
        villageList.add(
          VillageData(
            amphure: addressController.selectedAmphure.value,
            district: addressController.selectedTambol.value,
            election: election.text,
            province: addressController.selectedProvince.value,
            villageActYear: villageActYear.text,
            villageActivity: villageActivity.text,
            villageGoalAct2: villageGoalAct2.text,
            villageGoalAct: int.parse(villageGoalAct.text),
            villageLocation: villageLocation.text,
            villageName: villageName.text,
            villageNo: villageNo.text,
            villageTotal: int.parse(villageTotal.text),
            villageTotalUsed: int.parse(villageTotalUsed.text),
            villageTypeAct: typeActChips.join('|'),
          ),
        );
        resetForm();
      } else {
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
    // villages.add(
    //   Villages(
    //     amphure: addressController.selectedAmphure.value.split('|').last,
    //     district: addressController.selectedTambol.value.split('|').last,
    //     election: election.text,
    //     province: addressController.selectedProvince.value.split('|').last,
    //     villageActYear: villageActYear.text,
    //     villageActivity: villageActivity.text,
    //     villageGoalAct2: villageGoalAct2.text,
    //     villageGoalAct: int.parse(villageGoalAct.text),
    //     villageName: villageName.text,
    //     villageNo: villageNo.text,
    //     villageTotal: int.parse(villageTotal.text),
    //     villageTotalUsed: int.parse(villageTotalUsed.text),
    //     villageTypeAct: typeActChips.toString(),
    //     villageLocation: villageLocation.text,
    //   ),
    // );
  }

  resetForm() {
    villageName.text = "";
    villageNo.text = "";
    villageTotal.text = "0";
    villageTotalUsed.text = "0";
    villageActivity.text = "";
    villageActYear.text = "";
    villageGoalAct.text = "0";
    villageGoalAct2.text = "";
    villageLocation.text = "";
    villageTypeAct.text = "";
    election.text = "";
    typeActChips.clear();
    // addressController.selectedProvince.value = '0|';
    // addressController.selectedAmphure.value = '0|';
    // addressController.selectedTambol.value = '0|';
    update();
  }

  addTypeActToChip(String typeAct, String goalAct2) {
    talker.debug('$logTitle::addVillageTypeActToChip:$typeAct');
    typeActChips.add('$typeAct : $goalAct2');
    talker
        .debug('$logTitle::addVillageTypeActToChip:${typeActChips.toString()}');
    villageTypeAct.text = "";
    villageGoalAct2.text = "";
    typeActChips.refresh();
  }

  deleteTypeActToChip(String typeAct) {
    talker.debug('$logTitle::deleteVillageTypeActToChip:$typeAct');
    typeActChips.remove(typeAct);
    typeActChips.refresh();
  }
}
