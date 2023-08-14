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

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> saveVillage() async {
    talker.info('$logTitle:saveVillage:');
    isLoading.value = true;
    try {
      final result = await VillageService().createVillage(villages.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      villageList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
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
    villageList.add(VillageData(
      address:
          "${addressController.selectedProvince.value.split('|').last}/${addressController.selectedAmphure.value.split('|').last}/${addressController.selectedTambol.value.split('|').last}",
      name: villageName.text,
      no: villageNo.text,
      total: int.parse(villageTotal.text),
    ));
    villages.add(
      Villages(
        amphure: addressController.selectedAmphure.value.split('|').last,
        district: addressController.selectedTambol.value.split('|').last,
        election: election.text,
        province: addressController.selectedProvince.value.split('|').last,
        villageActYear: villageActYear.text,
        villageActivity: villageActivity.text,
        villageGoalAct2: villageGoalAct2.text,
        villageGoalAct: int.parse(villageGoalAct.text),
        villageName: villageName.text,
        villageNo: villageNo.text,
        villageTotal: int.parse(villageTotal.text),
        villageTotalUsed: int.parse(villageTotalUsed.text),
        villageTypeAct: typeActChips.toString(),
        villageLocation: villageLocation.text,
      ),
    );
    resetForm();
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
    villageTypeAct.text = "";
    election.text = "";
    update();
  }

  addTypeActToChip(String typeAct) {
    talker.debug('$logTitle::addVillageTypeActToChip:$typeAct');
    typeActChips.add(typeAct);
    talker.debug(
        '$logTitle::addVillageTypeActToChip:${typeActChips.toString()}');
    update();
  }

  deleteTypeActToChip(String typeAct) {
    talker.debug('$logTitle::deleteVillageTypeActToChip:$typeAct');
    typeActChips.remove(typeAct);
    update();
  }
}
