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

  Future saveMember() async {
    talker.info('$logTitle:saveMember:');
    isLoading.value = true;
    try {
      for (var member in memberList) {
        members.add(
          Members(
            amphure: member.amphure!.split('|').last,
            district: member.district!.split('|').last,
            province: member.province!.split('|').last,
            memberBirthYear: member.memberBirthYear,
            memberDate: member.memberDate,
            memberExp: member.memberExp,
            memberFirstName: member.memberFirstName,
            memberIdCard: member.memberIdCard,
            memberLocation: member.memberLocation,
            memberPosition: member.memberPosition,
            memberPositionCommu: member.memberPositionCommu,
            memberStationId: member.memberStationId,
            memberStationName: member.memberStationName,
            memberSurName: member.memberSurName,
            memberTelephone: member.memberTelephone,
          ),
        );
      }
      final result = await MemberService().createMember(members.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      memberList.clear();
      members.clear();
      resetForm();
    } catch (e) {
      talker.error('$e');
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (members.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      memberList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(memberList[index].memberStationId);
    talker.debug(memberList[index].memberStationName);
    talker.debug(memberList[index].memberFirstName);
    talker.debug(memberList[index].memberSurName);
    talker.debug(memberList[index].memberIdCard);
    talker.debug(memberList[index].memberBirthYear);
    talker.debug(memberList[index].memberLocation);
    talker.debug(memberList[index].memberDate);
    talker.debug(memberList[index].memberTelephone);
    talker.debug(memberList[index].memberPosition);
    talker.debug(memberList[index].memberPositionCommu);
    talker.debug(memberList[index].memberExp);
    talker.debug(memberList[index].province);
    talker.debug(memberList[index].amphure);
    talker.debug(memberList[index].district);
    memberStationId.text = memberList[index].memberStationId!.toString();
    memberStationName.text = memberList[index].memberStationName!;
    memberFirstName.text = memberList[index].memberFirstName!;
    memberSurName.text = memberList[index].memberSurName!;
    memberIdCard.text = memberList[index].memberIdCard!;
    memberBirthYear.text = memberList[index].memberBirthYear!;
    memberLocation.text = memberList[index].memberLocation!;
    memberDate.text = memberList[index].memberDate!;
    memberTelephone.text = memberList[index].memberTelephone!;
    memberPosition.text = memberList[index].memberPosition!;
    memberPositionCommu.text = memberList[index].memberPositionCommu!;
    memberExp.text = memberList[index].memberExp!;
    addressController.selectedProvince.value = memberList[index].province!;
    await addressController
        .listAmphure(memberList[index].province!.split('|').first);
    addressController.selectedAmphure.value = memberList[index].amphure!;
    await addressController
        .listTambol(memberList[index].amphure!.split('|').first);
    addressController.selectedTambol.value = memberList[index].district!;
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
    memberList.add(
      MemberData(
        memberStationId: int.parse(memberStationId.text),
        memberStationName: memberStationName.text,
        memberFirstName: memberFirstName.text,
        memberSurName: memberSurName.text,
        memberIdCard: memberIdCard.text,
        memberBirthYear: memberBirthYear.text,
        memberLocation: memberLocation.text,
        memberDate: memberDate.text,
        memberTelephone: memberTelephone.text,
        memberPosition: memberPosition.text,
        memberPositionCommu: memberPositionCommu.text,
        memberExp: memberExp.text,
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
        province: addressController.selectedProvince.value,
      ),
    );
    // members.add(
    //   Members(
    //     amphure: addressController.selectedAmphure.value,
    //     district: addressController.selectedTambol.value,
    //     memberBirthYear: memberBirthYear.text,
    //     memberDate: memberDate.text,
    //     memberExp: memberExpChips.toString(),
    //     memberFirstName: memberFirstName.text,
    //     memberIdCard: memberIdCard.text,
    //     memberLocation: memberLocation.text,
    //     memberPosition: memberPosition.text,
    //     memberPositionCommu: memberPositionCommuChips.toString(),
    //     memberStationId: int.parse(memberStationId.text),
    //     memberStationName: memberStationName.text,
    //     memberSurName: memberSurName.text,
    //     memberTelephone: memberTelephone.text,
    //     province: addressController.selectedProvince.value,
    //   ),
    // );
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
    addressController.selectedAmphure.value = "0|";
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
