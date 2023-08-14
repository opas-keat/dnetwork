import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final commissPosition = TextEditingController();
  final commissPositionCommu = TextEditingController();
  final commissExp = TextEditingController();

  final commissPositionCommuChips = <String>[].obs;
  final commissExpChips = <String>[].obs;

  Future<bool> saveCommiss() async {
    talker.info('$logTitle:saveCommiss:');
    isLoading.value = true;
    try {
      final result = await CommissService().createCommiss(commisss.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      commissList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
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
    talker.debug(commissPosition.text);
    talker.debug(commissPositionCommu.text);
    talker.debug(commissExp.text);
    commissList.add(
      CommissData(
        commissFirstName: commissFirstName.text,
        commissSurName: commissSurName.text,
        commissPosition: commissPosition.text,
        commissDate: commissDate.text,
        commissTelephone: commissTelephone.text,
      ),
    );
    commisss.add(Commisss(
      amphure: addressController.selectedAmphure.value.split('|').last,
      district: addressController.selectedTambol.value.split('|').last,
      commissBirthYear: commissBirthYear.text,
      commissDate: commissDate.text,
      commissExp: commissExpChips.toString(),
      commissFirstName: commissFirstName.text,
      commissIdCard: commissIdCard.text,
      commissLocation: commissLocation.text,
      commissPosition: commissPosition.text,
      commissPositionCommu: commissPositionCommuChips.toString(),
      commissStationId: int.parse(commissStationId.text),
      commissStationName: commissStationName.text,
      commissSurName: commissSurName.text,
      commissTelephone: commissTelephone.text,
      province: addressController.selectedProvince.value.split('|').last,
    ));
    resetForm();
  }

  resetForm() {
    commissBirthYear.text = "";
    commissDate.text = "";
    commissExp.text = "";
    commissFirstName.text = "";
    commissIdCard.text = "";
    commissLocation.text = "";
    commissPosition.text = "";
    commissPositionCommu.text = "";
    commissStationId.text = "0";
    commissStationName.text = "";
    commissSurName.text = "";
    commissTelephone.text = "";
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
}
