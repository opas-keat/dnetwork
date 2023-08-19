import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_service.dart';
import '../../../../api/services/commiss_service.dart';
import '../../../../data/requests/commiss_service_request.dart';
import '../../../../data/responses/commiss_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageCommissController extends GetxController {
  final logTitle = "ManageCommissController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final commissList = <CommissData>[].obs;
  final commisss = <Commisss>[].obs;
  final commissPositionList = <String>[].obs;
  Rx<String> selectedCommissPosition = "".obs;

  RxString commissError = ''.obs;

  final formKey = GlobalKey<FormState>();
  final commissStationId = TextEditingController(text: "0");
  final commissStationName = TextEditingController();
  final commissFirstName = TextEditingController();
  final commissSurName = TextEditingController();
  final commissIdCard = TextEditingController();
  final commissBirthYear = TextEditingController();
  final commissLocation = TextEditingController();
  final commissDate = TextEditingController();
  final commissTelephone = TextEditingController();
  // final commissPosition = TextEditingController();
  final commissPositionCommu = TextEditingController();
  final commissExp = TextEditingController();
  final commissProvince = TextEditingController();
  final commissAmphure = TextEditingController();
  final commissTambol = TextEditingController();

  final commissPositionCommuChips = <String>[].obs;
  final commissExpChips = <String>[].obs;

  int selectedIndexFromTable = 0;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listCommissPosition();
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

  Future<bool> saveCommiss() async {
    talker.info('$logTitle:saveCommiss:');
    isLoading.value = true;
    try {
      for (var commiss in commissList) {
        commisss.add(
          Commisss(
            amphure: commiss.amphure,
            district: commiss.district,
            province: commiss.province,
            commissBirthYear: commiss.commissBirthYear,
            commissDate: commiss.commissDate,
            commissExp: commiss.commissExp,
            commissFirstName: commiss.commissFirstName,
            commissIdCard: commiss.commissIdCard,
            commissLocation: commiss.commissLocation,
            commissPosition: commiss.commissPosition,
            commissPositionCommu: commiss.commissPositionCommu,
            commissStationId: commiss.commissStationId,
            commissStationName: commiss.commissStationName,
            commissSurName: commiss.commissSurName,
            commissTelephone: commiss.commissTelephone,
          ),
        );
      }
      final result = await CommissService().createCommiss(commisss.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      commissList.clear();
      commisss.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (commissList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      commissList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(commissList[index].commissStationId);
    talker.debug(commissList[index].commissStationName);
    talker.debug(commissList[index].commissFirstName);
    talker.debug(commissList[index].commissSurName);
    talker.debug(commissList[index].commissIdCard);
    talker.debug(commissList[index].commissBirthYear);
    talker.debug(commissList[index].commissLocation);
    talker.debug(commissList[index].commissDate);
    talker.debug(commissList[index].commissTelephone);
    talker.debug(commissList[index].commissPosition);
    talker.debug(commissList[index].commissPositionCommu);
    talker.debug(commissList[index].commissExp);
    talker.debug(commissList[index].province);
    talker.debug(commissList[index].amphure);
    talker.debug(commissList[index].district);
    commissStationId.text = commissList[index].commissStationId!.toString();
    commissStationName.text = commissList[index].commissStationName!;
    commissFirstName.text = commissList[index].commissFirstName!;
    commissSurName.text = commissList[index].commissSurName!;
    commissIdCard.text = commissList[index].commissIdCard!;
    commissBirthYear.text = commissList[index].commissBirthYear!;
    commissLocation.text = commissList[index].commissLocation!;
    commissDate.text = commissList[index].commissDate!;
    commissTelephone.text = commissList[index].commissTelephone!;
    // commissPosition.text = commissList[index].commissPosition!;
    commissPositionCommu.text = commissList[index].commissPositionCommu!;
    commissExp.text = commissList[index].commissExp!;
    commissAmphure.text = commissList[index].district!;
    commissTambol.text = commissList[index].amphure!;
    commissProvince.text = commissList[index].province!;
    // addressController.selectedProvince.value = commissList[index].province!;
    // await addressController
    //     .listAmphure(commissList[index].province!.split('|').first);
    // addressController.selectedAmphure.value = commissList[index].amphure!;
    // await addressController
    //     .listTambol(commissList[index].amphure!.split('|').first);
    // addressController.selectedTambol.value = commissList[index].district!;
    update();
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(commissStationId.text);
    talker.debug(commissStationName.text);
    talker.debug(commissFirstName.text);
    talker.debug(commissSurName.text);
    talker.debug(commissIdCard.text);
    talker.debug(commissBirthYear.text);
    talker.debug(commissLocation.text);
    talker.debug(commissDate.text);
    talker.debug(commissTelephone.text);
    talker.debug(selectedCommissPosition);
    talker.debug(commissPositionCommu.text);
    talker.debug(commissExp.text);
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      commissList.add(
        CommissData(
          commissStationId: int.parse(commissStationId.text),
          commissStationName: commissStationName.text,
          commissFirstName: commissFirstName.text,
          commissSurName: commissSurName.text,
          commissIdCard: commissIdCard.text,
          commissBirthYear: commissBirthYear.text,
          commissLocation: commissLocation.text,
          commissDate: commissDate.text,
          commissTelephone: commissTelephone.text,
          commissPosition: selectedCommissPosition.value,
          commissPositionCommu: commissPositionCommu.text,
          commissExp: commissExp.text,
          amphure: commissAmphure.text,
          district: commissTambol.text,
          province: commissProvince.text,
        ),
      );
      resetForm();
    }
    // commisss.add(
    //   Commisss(
    //     amphure: addressController.selectedAmphure.value,
    //     district: addressController.selectedTambol.value,
    //     commissBirthYear: commissBirthYear.text,
    //     commissDate: commissDate.text,
    //     commissExp: commissExpChips.toString(),
    //     commissFirstName: commissFirstName.text,
    //     commissIdCard: commissIdCard.text,
    //     commissLocation: commissLocation.text,
    //     commissPosition: commissPosition.text,
    //     commissPositionCommu: commissPositionCommuChips.toString(),
    //     commissStationId: int.parse(commissStationId.text),
    //     commissStationName: commissStationName.text,
    //     commissSurName: commissSurName.text,
    //     commissTelephone: commissTelephone.text,
    //     province: addressController.selectedProvince.value,
    //   ),
    // );
  }

  resetForm() {
    commissBirthYear.text = "";
    commissDate.text = "";
    commissExp.text = "";
    commissFirstName.text = "";
    commissIdCard.text = "";
    commissLocation.text = "";
    // commissPosition.text = "";
    commissPositionCommu.text = "";
    // commissStationId.text = "0";
    // commissStationName.text = "";
    commissSurName.text = "";
    commissTelephone.text = "";
    commissPositionCommuChips.clear();
    commissExpChips.clear();
    // addressController.selectedProvince.value = '0|';
    // addressController.selectedAmphure.value = '0|';
    // addressController.selectedTambol.value = '0|';
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::addPositionCommuToChip:$positionCommu');
    commissPositionCommuChips.add(positionCommu);
    talker.debug(
        '$logTitle::addPositionCommuToChip:${commissPositionCommuChips.toString()}');
    update();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    commissPositionCommuChips.remove(positionCommu);
    update();
  }

  addCommissExpToChip(String commissExp) {
    talker.debug('$logTitle::addCommissExpToChip:$commissExp');
    commissExpChips.add(commissExp);
    talker
        .debug('$logTitle::addCommissExpToChip:${commissExpChips.toString()}');
    update();
  }

  deleteCommissExpToChip(String commissExp) {
    talker.debug('$logTitle::deleteCommissToChip:$commissExp');
    commissExpChips.remove(commissExp);
    update();
  }

  Future listCommissPosition() async {
    talker.info('$logTitle::listCommissPosition');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionService().list(qParams);
      commissPositionList.clear();
      commissPositionList.add("");
      for (var item in result!.data!) {
        commissPositionList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
