import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_commu_service.dart';
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
  final commissPositionCommuList = <String>[].obs;
  Rx<String> selectedCommissPositionCommu = "".obs;

  RxString commissError = ''.obs;

  
  final commissStationId = TextEditingController(text: "0");
  final commissStationName = TextEditingController();
  final commissFirstName = TextEditingController();
  final commissSurName = TextEditingController();
  final commissIdCard = TextEditingController();
  final commissBirthYear = TextEditingController();
  final commissLocation = TextEditingController();
  final commissDate = TextEditingController();
  final commissTelephone = TextEditingController();
  final commissPositionCommu = TextEditingController();
  final commissExp = TextEditingController();
  final commissProvince = TextEditingController();
  final commissAmphure = TextEditingController();
  final commissTambol = TextEditingController();

  final commissPositionCommuChips = <String>[].obs;
  final commissExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listCommissPosition();
    listCommissPositionCommu();
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
    commissList.clear();
    super.onClose();
  }

  save() async {
    talker.info('$logTitle:saveBudget:');
    isLoading.value = true;
    try {
      talker.info('$logTitle:save:');
      talker.debug(commissLocation.text);
      talker.debug(addressController.selectedProvince.value);
      talker.debug(addressController.selectedAmphure.value);
      talker.debug(addressController.selectedTambol.value);
      talker.debug(commissLocation.text);
      final isValid = formKeyCommiss.currentState!.validate();
      if (isValid) {
        commisss.add(
          Commisss(
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
            commissPositionCommu: commissPositionCommuChips.join('|'),
            commissExp: commissExp.text,
            amphure: commissAmphure.text,
            district: commissTambol.text,
            province: commissProvince.text,
          ),
        );
        final result = await CommissService().create(commisss.obs.value);
        talker.debug('response message : ${result?.message}');
        if (result?.code == "000") {
          for (var item in result!.data!) {
            commissList.add(
              CommissData(
                id: item.id,
                amphure: item.amphure,
                district: item.district,
                province: item.province,
                commissBirthYear: item.commissBirthYear,
                commissDate: item.commissDate,
                commissExp: item.commissExp,
                commissFirstName: item.commissFirstName,
                commissIdCard: item.commissIdCard,
                commissLocation: item.commissLocation,
                commissPosition: item.commissPosition,
                commissPositionCommu: item.commissPositionCommu,
                commissStationId: item.commissStationId,
                commissStationName: item.commissStationName,
                commissSurName: item.commissSurName,
                commissTelephone: item.commissTelephone,
              ),
            );
          }
          isLoading.value = false;
          commisss.clear();
          resetForm();
          return true;
        }
        return false;
      }
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  edit() async {
    talker.info('$logTitle:editData:$selectedIndexFromTable');
    isLoading.value = true;
    try {
      final isValid = formKeyCommiss.currentState!.validate();
      if (isValid) {
        commisss.add(
          Commisss(
            id: selectedId,
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
            commissPositionCommu: commissPositionCommuChips.join('|'),
            commissExp: commissExp.text,
            amphure: commissAmphure.text,
            district: commissTambol.text,
            province: commissProvince.text,
          ),
        );
        final result = await CommissService().update(commisss.obs.value);
        talker.debug('response message : ${result?.message}');
        if (result?.code == "000") {
          for (var item in result!.data!) {
            commissList[selectedIndexFromTable].commissStationId =
                item.commissStationId;
            commissList[selectedIndexFromTable].commissStationName =
                item.commissStationName;
            commissList[selectedIndexFromTable].commissFirstName =
                item.commissFirstName;
            commissList[selectedIndexFromTable].commissSurName =
                item.commissSurName;
            commissList[selectedIndexFromTable].commissIdCard =
                item.commissIdCard;
            commissList[selectedIndexFromTable].commissBirthYear =
                item.commissBirthYear;
            commissList[selectedIndexFromTable].commissLocation =
                item.commissLocation;
            commissList[selectedIndexFromTable].commissDate = item.commissDate;
            commissList[selectedIndexFromTable].commissTelephone =
                item.commissTelephone;
            commissList[selectedIndexFromTable].commissPosition =
                item.commissPosition;
            commissList[selectedIndexFromTable].commissPositionCommu =
                item.commissPositionCommu;
            commissList[selectedIndexFromTable].amphure = item.amphure;
            commissList[selectedIndexFromTable].district = item.district;
            commissList[selectedIndexFromTable].province = item.province;
          }
        }
        isLoading.value = false;
        commissList.refresh();
        commisss.clear();
        selectedIndexFromTable = -1;
        resetForm();
      }
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  delete() async {
    talker.info('$logTitle:deleteDataFromTable:$selectedId');
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (commissList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await CommissService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('commissList : ${commissList.toString()}');
        commissList.removeAt(selectedIndexFromTable);
        talker.debug('trainingList : ${commissList.toString()}');
        commissList.refresh();
      }
    }
  }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    try {
      final result = await CommissService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        commissStationId.text = item.commissStationId!.toString();
        commissStationName.text = item.commissStationName!;
        commissFirstName.text = item.commissFirstName!;
        commissSurName.text = item.commissSurName!;
        commissIdCard.text = item.commissIdCard!;
        commissBirthYear.text = item.commissBirthYear!;
        commissLocation.text = item.commissLocation!;
        commissDate.text = item.commissDate!;
        commissTelephone.text = item.commissTelephone!;
        selectedCommissPosition.value = item.commissPosition!;
        commissAmphure.text = item.district!;
        commissTambol.text = item.amphure!;
        commissProvince.text = item.province!;
        if (item.commissPositionCommu!.isNotEmpty) {
          commissPositionCommuChips
              .addAll(item.commissPositionCommu!.split('|'));
          selectedCommissPositionCommu.value =
              item.commissPositionCommu!.split('|').first;
        }
        if (item.commissExp!.isNotEmpty) {
          commissExpChips.addAll(item.commissExp!.split('|'));
        }
        update();
      }
      isLoading.value = false;
      commissList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  resetForm() {
    commissBirthYear.text = "";
    commissDate.text = "";
    commissExp.text = "";
    commissFirstName.text = "";
    commissIdCard.text = "";
    commissLocation.text = "";
    commissPositionCommu.text = "";
    commissSurName.text = "";
    commissTelephone.text = "";
    commissPositionCommuChips.clear();
    commissExpChips.clear();
    selectedCommissPosition.value = '';
    selectedCommissPositionCommu.value = '';
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug(
        '$logTitle::addPositionCommuToChip:${selectedCommissPositionCommu.value}');
    commissPositionCommuChips.add(selectedCommissPositionCommu.value);
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
    } catch (e) {
      talker.error('$e');
    }
  }

  Future listCommissPositionCommu() async {
    talker.info('$logTitle::listCommissPositionCommu');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionCommuService().list(qParams);
      commissPositionCommuList.clear();
      commissPositionCommuList.add("");
      for (var item in result!.data!) {
        commissPositionCommuList.add(item.name!);
      }
    } catch (e) {
      talker.error('$e');
    }
  }
}
