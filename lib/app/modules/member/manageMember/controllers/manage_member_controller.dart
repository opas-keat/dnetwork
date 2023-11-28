import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api.dart';
import '../../../../api/api_end_points.dart';
import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_commu_service.dart';
import '../../../../api/services/file_attach_service.dart';
import '../../../../api/services/member_position_service.dart';
import '../../../../api/services/member_service.dart';
import '../../../../data/requests/member_service_request.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../shared/controller/info_card_controller.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';
import '../../../dashboard/controllers/dashboard_controller.dart';
import '../../../station/controllers/station_controller.dart';
import '../../controllers/member_controller.dart';

class ManageMemberController extends GetxController {
  final logTitle = "ManageMemberController";
  RxBool isLoading = true.obs;
  InfoCardController infoCardController = Get.put(InfoCardController());
  StationController stationController = Get.put(StationController());
  DashboardController dashboardController = Get.put(DashboardController());
  MemberController memberController = Get.put(MemberController());
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final memberList = <MemberData>[].obs;
  final members = <Members>[].obs;
  final memberPositionList = <String>[].obs;
  Rx<String> selectedMemberPosition = "".obs;
  final memberPositionCommuList = <String>[].obs;
  Rx<String> selectedMemberPositionCommu = "".obs;

  final memberStationId = TextEditingController(text: "0");
  final memberStationName = TextEditingController();
  final memberFirstName = TextEditingController();
  final memberSurName = TextEditingController();
  final memberIdCard = TextEditingController();
  final memberBirthYear = TextEditingController();
  final memberLocation = TextEditingController();
  final memberDate = TextEditingController();
  final memberTelephone = TextEditingController();
  final memberPositionCommu = TextEditingController();
  final memberExp = TextEditingController();
  final memberProvince = TextEditingController();
  final memberAmphure = TextEditingController();
  final memberTambol = TextEditingController();
  final memberPreName = TextEditingController();

  RxString memberError = ''.obs;

  final memberPositionCommuChips = <String>[].obs;
  final memberExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

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
    memberList.clear();
    super.onClose();
  }

  save() async {
    talker.info('$logTitle:save:');
    isLoading.value = true;
    bool result = true;
    try {
      members.add(
        Members(
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
          memberPreName: memberPreName.text,
        ),
      );
      talker.debug('request message : ${members.toJson()}');
      final response = await MemberService().create(members.obs.value);
      talker.debug('response message : ${response?.message}');
      if (response?.code == "000") {
        for (var item in response!.data!) {
          memberList.add(
            MemberData(
              id: item.id,
              amphure: item.amphure,
              district: item.district,
              province: item.province,
              memberBirthYear: item.memberBirthYear,
              memberDate: item.memberDate,
              memberExp: item.memberExp,
              memberFirstName: item.memberFirstName,
              memberIdCard: item.memberIdCard,
              memberLocation: item.memberLocation,
              memberPosition: item.memberPosition,
              memberPositionCommu: item.memberPositionCommu,
              memberStationId: item.memberStationId,
              memberStationName: item.memberStationName,
              memberSurName: item.memberSurName,
              memberTelephone: item.memberTelephone,
              memberPreName: item.memberPreName,
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
              "member",
              "profiles",
              item.id.toString(),
            );
          }
        }
        isLoading.value = false;
        members.clear();
        selectedIndexFromTable = -1;
        resetForm();
      }
      result = true;
    } catch (e) {
      talker.error('$e');
      result = false;
    }
    return result;
  }

  edit() async {
    talker.info('$logTitle:editData:$selectedIndexFromTable');
    isLoading.value = true;
    try {
      members.add(
        Members(
          id: selectedId,
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
          memberPreName: memberPreName.text,
        ),
      );
      final result = await MemberService().update(members.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        for (var item in result!.data!) {
          memberList[selectedIndexFromTable].memberStationId =
              item.memberStationId;
          memberList[selectedIndexFromTable].memberStationName =
              item.memberStationName;
          memberList[selectedIndexFromTable].memberFirstName =
              item.memberFirstName;
          memberList[selectedIndexFromTable].memberSurName = item.memberSurName;
          memberList[selectedIndexFromTable].memberIdCard = item.memberIdCard;
          memberList[selectedIndexFromTable].memberBirthYear =
              item.memberBirthYear;
          memberList[selectedIndexFromTable].memberLocation =
              item.memberLocation;
          memberList[selectedIndexFromTable].memberDate = item.memberDate;
          memberList[selectedIndexFromTable].memberTelephone =
              item.memberTelephone;
          memberList[selectedIndexFromTable].memberPosition =
              item.memberPosition;
          memberList[selectedIndexFromTable].memberPositionCommu =
              item.memberPositionCommu;
          memberList[selectedIndexFromTable].amphure = item.amphure;
          memberList[selectedIndexFromTable].district = item.district;
          memberList[selectedIndexFromTable].province = item.province;
          memberList[selectedIndexFromTable].memberPreName = item.memberPreName;
        }
      }
      isLoading.value = false;
      memberList.refresh();
      members.clear();
      selectedIndexFromTable = -1;
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  delete() async {
    talker.info('$logTitle:deleteDataFromTable:$selectedId');
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (memberList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await MemberService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('memberList : ${memberList.toString()}');
        memberList.removeAt(selectedIndexFromTable);
        talker.debug('trainingList : ${memberList.toString()}');
        memberList.refresh();
      }
    }
  }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    memberPositionCommuChips.clear();
    memberExpChips.clear();
    try {
      final result = await MemberService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        memberStationId.text = item.memberStationId!.toString();
        memberStationName.text = item.memberStationName!;
        memberFirstName.text = item.memberFirstName!;
        memberSurName.text = item.memberSurName!;
        memberIdCard.text = item.memberIdCard!;
        memberBirthYear.text = item.memberBirthYear!;
        memberLocation.text = item.memberLocation!;
        memberDate.text = item.memberDate!;
        memberTelephone.text = item.memberTelephone!;
        // memberPosition.text = memberList[index].memberPosition!;
        selectedMemberPosition.value = item.memberPosition!;

        // memberPositionCommu.text = memberList[index].memberPositionCommu!;
        // memberExp.text = memberList[index].memberExp!;
        memberAmphure.text = item.amphure!;
        memberTambol.text = item.district!;
        memberProvince.text = item.province!;
        memberPreName.text = item.memberPreName!;
        if (item.memberPositionCommu!.isNotEmpty) {
          memberPositionCommuChips.addAll(item.memberPositionCommu!.split('|'));
          selectedMemberPositionCommu.value =
              item.memberPositionCommu!.split('|').first;
        }
        if (item.memberExp!.isNotEmpty) {
          memberExpChips.addAll(item.memberExp!.split('|'));
        }
        // get profiles
        Map<String, String> qParams = {
          "module": "member",
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
        update();
      }
      isLoading.value = false;
      memberList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  // Future<bool> saveMember() async {
  //   talker.info('$logTitle:saveMember:');
  //   isLoading.value = true;
  //   try {
  //     for (var member in memberList) {
  //       members.add(
  //         Members(
  //           amphure: member.amphure,
  //           district: member.district,
  //           province: member.province,
  //           memberBirthYear: member.memberBirthYear,
  //           memberDate: member.memberDate,
  //           memberExp: member.memberExp,
  //           memberFirstName: member.memberFirstName,
  //           memberIdCard: member.memberIdCard,
  //           memberLocation: member.memberLocation,
  //           memberPosition: member.memberPosition,
  //           memberPositionCommu: member.memberPositionCommu,
  //           memberStationId: member.memberStationId,
  //           memberStationName: member.memberStationName,
  //           memberSurName: member.memberSurName,
  //           memberTelephone: member.memberTelephone,
  //         ),
  //       );
  //     }
  //     final result = await MemberService().create(members.obs.value);
  //     talker.debug('response message : ${result?.message}');
  //     if (result?.code == "000") {
  //       return true;
  //     }
  //     isLoading.value = false;
  //     memberList.clear();
  //     members.clear();
  //     resetForm();
  //     return true;
  //   } catch (e) {
  //     talker.error('$e');
  //     return false;
  //   }
  // }

  // deleteDataFromTable() {
  //   talker.info('$logTitle:deleteDataFromTable:${selectedIndexFromTable}');
  //   if (memberList.length > selectedIndexFromTable &&
  //       selectedIndexFromTable > -1) {
  //     memberList.removeAt(selectedIndexFromTable);
  //     selectedIndexFromTable = -1;
  //     resetForm();
  //   }
  // }

  // selectDataFromTable(int index) async {
  //   selectedIndexFromTable = index;
  //   talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
  //   memberPositionCommuChips.clear();
  //   memberExpChips.clear();
  //   talker.debug(memberList[index].memberStationId);
  //   talker.debug(memberList[index].memberStationName);
  //   talker.debug(memberList[index].memberFirstName);
  //   talker.debug(memberList[index].memberSurName);
  //   talker.debug(memberList[index].memberIdCard);
  //   talker.debug(memberList[index].memberBirthYear);
  //   talker.debug(memberList[index].memberLocation);
  //   talker.debug(memberList[index].memberDate);
  //   talker.debug(memberList[index].memberTelephone);
  //   talker.debug(memberList[index].memberPosition);
  //   talker.debug(memberList[index].memberPositionCommu);
  //   talker.debug(memberList[index].memberExp);
  //   talker.debug(memberList[index].province);
  //   talker.debug(memberList[index].amphure);
  //   talker.debug(memberList[index].district);
  //   memberStationId.text = memberList[index].memberStationId!.toString();
  //   memberStationName.text = memberList[index].memberStationName!;
  //   memberFirstName.text = memberList[index].memberFirstName!;
  //   memberSurName.text = memberList[index].memberSurName!;
  //   memberIdCard.text = memberList[index].memberIdCard!;
  //   memberBirthYear.text = memberList[index].memberBirthYear!;
  //   memberLocation.text = memberList[index].memberLocation!;
  //   memberDate.text = memberList[index].memberDate!;
  //   memberTelephone.text = memberList[index].memberTelephone!;
  //   // memberPosition.text = memberList[index].memberPosition!;
  //   selectedMemberPosition.value = memberList[index].memberPosition!;

  //   // memberPositionCommu.text = memberList[index].memberPositionCommu!;
  //   // memberExp.text = memberList[index].memberExp!;
  //   memberAmphure.text = memberList[index].district!;
  //   memberTambol.text = memberList[index].amphure!;
  //   memberProvince.text = memberList[index].province!;
  //   if (memberList[index].memberPositionCommu!.isNotEmpty) {
  //     memberPositionCommuChips
  //         .addAll(memberList[index].memberPositionCommu!.split('|'));
  //     selectedMemberPositionCommu.value =
  //         memberList[index].memberPositionCommu!.split('|').first;
  //   }
  //   if (memberList[index].memberExp!.isNotEmpty) {
  //     memberExpChips.addAll(memberList[index].memberExp!.split('|'));
  //   }
  //   // addressController.selectedProvince.value = memberList[index].province!;
  //   // await addressController
  //   //     .listAmphure(memberList[index].province!.split('|').first);
  //   // addressController.selectedAmphure.value = memberList[index].amphure!;
  //   // await addressController
  //   //     .listTambol(memberList[index].amphure!.split('|').first);
  //   // addressController.selectedTambol.value = memberList[index].district!;
  //   update();
  //   memberList.refresh();
  // }

  // addDataToTable() {
  //   talker.info('$logTitle:addDataToTable:');
  //   talker.debug(memberStationId.text);
  //   talker.debug(memberStationName.text);
  //   talker.debug(memberFirstName.text);
  //   talker.debug(memberSurName.text);
  //   talker.debug(memberIdCard.text);
  //   talker.debug(memberBirthYear.text);
  //   talker.debug(memberLocation.text);
  //   talker.debug(memberDate.text);
  //   talker.debug(memberTelephone.text);
  //   talker.debug(selectedMemberPosition);
  //   talker.debug(memberPositionCommu.text);
  //   talker.debug(memberExp.text);
  //   final isValid = formKey.currentState!.validate();
  //   if (isValid) {
  //     memberList.add(
  //       MemberData(
  //         memberStationId: int.parse(memberStationId.text),
  //         memberStationName: memberStationName.text,
  //         memberFirstName: memberFirstName.text,
  //         memberSurName: memberSurName.text,
  //         memberIdCard: memberIdCard.text,
  //         memberBirthYear: memberBirthYear.text,
  //         memberLocation: memberLocation.text,
  //         memberDate: memberDate.text,
  //         memberTelephone: memberTelephone.text,
  //         memberPosition: selectedMemberPosition.value,
  //         memberPositionCommu: memberPositionCommuChips.join('|'),
  //         memberExp: memberExp.text,
  //         amphure: memberAmphure.text,
  //         district: memberTambol.text,
  //         province: memberProvince.text,
  //       ),
  //     );
  //     resetForm();
  //   }
  //   // members.add(
  //   //   Members(
  //   //     amphure: addressController.selectedAmphure.value,
  //   //     district: addressController.selectedTambol.value,
  //   //     memberBirthYear: memberBirthYear.text,
  //   //     memberDate: memberDate.text,
  //   //     memberExp: memberExpChips.toString(),
  //   //     memberFirstName: memberFirstName.text,
  //   //     memberIdCard: memberIdCard.text,
  //   //     memberLocation: memberLocation.text,
  //   //     memberPosition: memberPosition.text,
  //   //     memberPositionCommu: memberPositionCommuChips.toString(),
  //   //     memberStationId: int.parse(memberStationId.text),
  //   //     memberStationName: memberStationName.text,
  //   //     memberSurName: memberSurName.text,
  //   //     memberTelephone: memberTelephone.text,
  //   //     province: addressController.selectedProvince.value,
  //   //   ),
  //   // );
  // }

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
    memberPreName.text = "";
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
        '$logTitle::addPositionCommuToChip:${memberPositionCommuChips.toString()}');
    // selectedMemberPositionCommu.value = '';
    update();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    memberPositionCommuChips.remove(positionCommu);
    update();
  }

  addMemberExpToChip(String memberExp) {
    talker.debug('$logTitle::addMemberExpToChip:$memberExp');
    memberExpChips.add(memberExp);
    talker.debug('$logTitle::addMemberExpToChip:${memberExpChips.toString()}');
    update();
  }

  deleteMemberExpToChip(String memberExp) {
    talker.debug('$logTitle::deleteMemberToChip:$memberExp');
    memberExpChips.remove(memberExp);
    update();
  }

  Future listMemberPosition() async {
    talker.info('$logTitle::listMemberPosition');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await MemberPositionService().list(qParams);
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
