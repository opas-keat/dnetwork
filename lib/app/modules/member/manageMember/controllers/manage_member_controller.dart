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

  int selectedIndexFromTable = 0;

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

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (members.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      members.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(members[index].memberStationId);
    talker.debug(members[index].memberStationName);
    talker.debug(members[index].memberFirstName);
    talker.debug(members[index].memberSurName);
    talker.debug(members[index].memberIdCard);
    talker.debug(members[index].memberBirthYear);
    talker.debug(members[index].memberLocation);
    talker.debug(members[index].memberDate);
    talker.debug(members[index].memberTelephone);
    talker.debug(members[index].memberPosition);
    talker.debug(members[index].memberPositionCommu);
    talker.debug(members[index].memberExp);
    talker.debug(members[index].province);
    talker.debug(members[index].amphure);
    talker.debug(members[index].district);
    memberStationId.text = members[index].memberStationId!.toString();
    memberStationName.text = members[index].memberStationName!;
    memberFirstName.text = members[index].memberFirstName!;
    memberSurName.text = members[index].memberSurName!;
    memberIdCard.text = members[index].memberIdCard!;
    memberBirthYear.text = members[index].memberBirthYear!;
    memberLocation.text = members[index].memberLocation!;
    memberDate.text = members[index].memberDate!;
    memberTelephone.text = members[index].memberTelephone!;
    memberPosition.text = members[index].memberPosition!;
    memberPositionCommu.text = members[index].memberPositionCommu!;
    memberExp.text = members[index].memberExp!;
    addressController.selectedProvince.value = members[index].province!;
    addressController.selectedAmphure.value = members[index].amphure!;
    addressController.selectedTambol.value = members[index].district!;
    update();
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
    // memberList.add(
    //   MemberData(
    //     memberFirstName: memberFirstName.text,
    //     memberSurName: memberSurName.text,
    //     memberPosition: memberPosition.text,
    //     memberDate: memberDate.text,
    //     memberTelephone: memberTelephone.text,
    //   ),
    // );
    members.add(
      Members(
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
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
        province: addressController.selectedProvince.value,
      ),
    );
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
    memberPositionCommuChips.clear();
    memberExpChips.clear();
    addressController.selectedProvince.value = '0|';
    addressController.selectedAmphure.value = '0|';
    addressController.selectedTambol.value = '0|';
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
