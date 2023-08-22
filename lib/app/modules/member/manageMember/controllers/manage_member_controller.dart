import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_commu_service.dart';
import '../../../../api/services/commiss_position_service.dart';
import '../../../../api/services/member_service.dart';
import '../../../../data/requests/member_service_request.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../shared/utils.dart';

class ManageMemberController extends GetxController {
  final logTitle = "ManageMemberController";
  RxBool isLoading = true.obs;
  // AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final memberList = <MemberData>[].obs;
  final members = <Members>[].obs;

  final memberPositionList = <String>[].obs;
  Rx<String> selectedMemberPosition = "".obs;
  final memberPositionCommuList = <String>[].obs;
  Rx<String> selectedMemberPositionCommu = "".obs;

  RxString memberError = ''.obs;

  final formKey = GlobalKey<FormState>();
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
  final memberProvince = TextEditingController();
  final memberAmphure = TextEditingController();
  final memberTambol = TextEditingController();

  final memberPositionCommuChips = <String>[].obs;
  final memberExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listMemberPosition();
    listMemberPositionCommu();
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

  Future saveMember() async {
    talker.info('$logTitle:saveMember:');
    isLoading.value = true;
    try {
      for (var member in memberList) {
        members.add(
          Members(
            amphure: member.amphure,
            district: member.district,
            province: member.province,
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
    if (memberList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      memberList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) async {
    selectedIndexFromTable = index;
    memberPositionCommuChips.clear();
    memberExpChips.clear();
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
    selectedMemberPosition.value = memberList[index].memberPosition!;

    memberAmphure.text = memberList[index].district!;
    memberTambol.text = memberList[index].amphure!;
    memberProvince.text = memberList[index].province!;
    if (memberList[index].memberPositionCommu!.isNotEmpty) {
      memberPositionCommuChips
          .addAll(memberList[index].memberPositionCommu!.split('|'));
      selectedMemberPositionCommu.value =
          memberList[index].memberPositionCommu!.split('|').first;
    }
    if (memberList[index].memberExp!.isNotEmpty) {
      memberExpChips.addAll(memberList[index].memberExp!.split('|'));
    }
    update();
    memberList.refresh();
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
    final isValid = formKey.currentState!.validate();
    if (isValid) {
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
          memberPosition: selectedMemberPosition.value,
          memberPositionCommu: memberPositionCommuChips.join('|'),
          memberExp: memberExp.text,
          amphure: memberAmphure.text,
          district: memberTambol.text,
          province: memberProvince.text,
        ),
      );
      resetForm();
    }

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
  }

  resetForm() {
    memberBirthYear.text = "";
    memberDate.text = "";
    memberExp.text = "";
    memberFirstName.text = "";
    memberIdCard.text = "";
    memberLocation.text = "";
    // memberPosition.text = "";
    memberPositionCommu.text = "";
    // memberStationId.text = "0";
    // memberStationName.text = "";
    memberSurName.text = "";
    memberTelephone.text = "";
    memberPositionCommuChips.clear();
    memberExpChips.clear();
    // addressController.selectedProvince.value = '';
    // addressController.selectedAmphure.value = '';
    // addressController.selectedTambol.value = '';
    selectedMemberPosition.value = '';
    selectedMemberPositionCommu.value = '';
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug(
        '$logTitle::addPositionCommuToChip:${selectedMemberPositionCommu.value}');
    memberPositionCommuChips.add(selectedMemberPositionCommu.value);
    talker.debug(
        '$logTitle::addPositionCommuToChip:${memberPositionCommuChips.join("|")}');
    memberPositionCommuChips.refresh();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    memberPositionCommuChips.remove(positionCommu);
    memberPositionCommuChips.refresh();
  }

  addMemberExpToChip(String exp) {
    talker.debug('$logTitle::addMemberExpToChip:$exp');
    memberExpChips.add(exp);
    talker.debug('$logTitle::addMemberExpToChip:${memberExpChips.toString()}');
    memberExp.text = '';
    memberExpChips.refresh();
  }

  deleteMemberExpToChip(String memberExp) {
    talker.debug('$logTitle::deleteMemberToChip:$memberExp');
    memberExpChips.remove(memberExp);
    memberExpChips.refresh();
  }

  Future listMemberPosition() async {
    talker.info('$logTitle::listMemberPosition');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionService().list(qParams);
      memberPositionList.clear();
      memberPositionList.add("");
      for (var item in result!.data!) {
        memberPositionList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }

  Future listMemberPositionCommu() async {
    talker.info('$logTitle::listMemberPositionCommu');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionCommuService().list(qParams);
      memberPositionCommuList.clear();
      memberPositionCommuList.add("");
      for (var item in result!.data!) {
        memberPositionCommuList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
