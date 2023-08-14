import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/member_service.dart';
import '../../../../data/requests/member_service_request.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageMemberController extends GetxController {
  final logTitle = "ManageMemberController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final memberList = <MemberData>[].obs;
  final members = <Members>[].obs;

  RxString memberError = ''.obs;

  final memberStationId = TextEditingController(text: "0");
  final memberStationName = TextEditingController();
  final memberFirstName = TextEditingController();
  final memberSurName = TextEditingController();
  final memberIdCard = TextEditingController();
  final memberBirthYear = TextEditingController();
  final memberLocation = TextEditingController();
  final memberDate = TextEditingController();
  final memberTelephone = TextEditingController();
  final memberPosition = TextEditingController();
  final memberPositionCommu = TextEditingController();
  final memberExp = TextEditingController();

  final memberPositionCommuChips = <String>[].obs;
  final memberExpChips = <String>[].obs;

  Future<bool> saveMember() async {
    talker.info('$logTitle:saveMember:');
    isLoading.value = true;
    try {
      final result = await MemberService().createMember(members.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      memberList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(memberStationId.text);
    talker.debug(memberStationName.text);
    talker.debug(memberFirstName.text);
    talker.debug(memberSurName.text);
    talker.debug(memberIdCard.text);
    talker.debug(memberBirthYear.text);
    talker.debug(memberLocation.text);
    talker.debug(memberDate.text);
    talker.debug(memberTelephone.text);
    talker.debug(memberPosition.text);
    talker.debug(memberPositionCommu.text);
    talker.debug(memberExp.text);
    memberList.add(
      MemberData(
        memberFirstName: memberFirstName.text,
        memberSurName: memberSurName.text,
        memberPosition: memberPosition.text,
        memberDate: memberDate.text,
        memberTelephone: memberTelephone.text,
      ),
    );
    members.add(Members(
      amphure: addressController.selectedAmphure.value.split('|').last,
      district: addressController.selectedTambol.value.split('|').last,
      memberBirthYear: memberBirthYear.text,
      memberDate: memberDate.text,
      memberExp: memberExpChips.toString(),
      memberFirstName: memberFirstName.text,
      memberIdCard: memberIdCard.text,
      memberLocation: memberLocation.text,
      memberPosition: memberPosition.text,
      memberPositionCommu: memberPositionCommuChips.toString(),
      memberStationId: int.parse(memberStationId.text),
      memberStationName: memberStationName.text,
      memberSurName: memberSurName.text,
      memberTelephone: memberTelephone.text,
      province: addressController.selectedProvince.value.split('|').last,
    ));
    resetForm();
  }

  resetForm() {
    memberBirthYear.text = "";
    memberDate.text = "";
    memberExp.text = "";
    memberFirstName.text = "";
    memberIdCard.text = "";
    memberLocation.text = "";
    memberPosition.text = "";
    memberPositionCommu.text = "";
    memberStationId.text = "0";
    memberStationName.text = "";
    memberSurName.text = "";
    memberTelephone.text = "";
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::addPositionCommuToChip:$positionCommu');
    memberPositionCommuChips.add(positionCommu);
    talker.debug(
        '$logTitle::addPositionCommuToChip:${memberPositionCommuChips.toString()}');
    update();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    memberPositionCommuChips.remove(positionCommu);
    update();
  }

  addCommissExpToChip(String memberExp) {
    talker.debug('$logTitle::addCommissExpToChip:$memberExp');
    memberExpChips.add(memberExp);
    talker.debug('$logTitle::addCommissExpToChip:${memberExpChips.toString()}');
    update();
  }

  deleteCommissExpToChip(String memberExp) {
    talker.debug('$logTitle::deleteCommissToChip:$memberExp');
    memberExpChips.remove(memberExp);
    update();
  }
}
