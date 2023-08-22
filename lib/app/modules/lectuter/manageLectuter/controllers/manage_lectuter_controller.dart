import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/lectuter_affiliate_service.dart';
import '../../../../api/services/lectuter_service.dart';
import '../../../../data/requests/lectuter_service_request.dart';
import '../../../../data/responses/lectuter_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageLectuterController extends GetxController {
  final logTitle = "ManageLectuterController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final lectuterAffiliateList = <String>[].obs;
  Rx<String> selectedLectuterAffiliate = "".obs;

  final lectuterList = <LectuterData>[].obs;
  final processList = [].obs;

  final lectuters = <Lectuters>[].obs;

  RxString lectuterError = ''.obs;

  final formKey = GlobalKey<FormState>();
  final lectuterPreName = TextEditingController();
  final lectuterFirstName = TextEditingController();
  final lectuterSurName = TextEditingController();
  final lectuterTelephone = TextEditingController();
  final lectuterLine = TextEditingController();
  final lectuterFacebook = TextEditingController();
  final lectuterAgency = TextEditingController();
  final lectuterAffiliate = TextEditingController();
  final lectuterExp = TextEditingController();

  final lectuterExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listLectuterAffiliate();
  }

  @override
  void onReady() {
    super.onReady();
    talker.info('$logTitle onReady');
  }

  @override
  void onClose() {
    talker.info('$logTitle onClose');
    super.onClose();
  }

  Future<bool> saveLectuter() async {
    talker.info('$logTitle:saveLectuter:');
    isLoading.value = true;
    try {
      for (var lectuter in lectuterList) {
        lectuters.add(
          Lectuters(
            lectuterAffiliate: lectuter.affiliate,
            lectuterAgency: lectuter.agency,
            lectuterExp: lectuter.lectuterExp,
            lectuterFacebook: lectuter.lectuterFacebook,
            lectuterFirstName: lectuter.lectuterFirstName,
            lectuterLine: lectuter.lectuterLine,
            lectuterPreName: lectuter.lectuterPreName,
            lectuterSurName: lectuter.lectuterSurName,
            lectuterTelephone: lectuter.telephone,
            province: lectuter.province!,
          ),
        );
      }
      final result =
          await LectuterService().createLectuter(lectuters.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      lectuterList.clear();
      lectuters.clear();
      addressController.selectedProvince.value = '';
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    if (lectuterList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      lectuterList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    lectuterExpChips.clear();
    lectuterPreName.text = lectuterList[index].lectuterPreName!;
    lectuterFirstName.text = lectuterList[index].lectuterFirstName!;
    lectuterSurName.text = lectuterList[index].lectuterSurName!;
    lectuterTelephone.text = lectuterList[index].telephone!;
    lectuterLine.text = lectuterList[index].lectuterLine!;
    lectuterFacebook.text = lectuterList[index].lectuterFacebook!;
    lectuterAgency.text = lectuterList[index].agency!;
    selectedLectuterAffiliate.value = lectuterList[index].affiliate!;
    // lectuterAffiliate.text = lectuterList[index].affiliate!;
    // lectuterExp.text = lectuterList[index].lectuterExp!;
    addressController.selectedProvince.value = lectuterList[index].province!;
    if (lectuterList[index].lectuterExp!.isNotEmpty) {
      lectuterExpChips.addAll(lectuterList[index].lectuterExp!.split('|'));
    }
    update();
    lectuterList.refresh();
  }

  addToDataTable() {
    talker.info('$logTitle:addToDataTable:');
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (lectuterExp.text.isNotEmpty) {
        lectuterExpChips.add(lectuterExp.text);
      }
      lectuterList.add(
        LectuterData(
          name: lectuterPreName.text,
          lectuterFirstName: lectuterFirstName.text,
          lectuterSurName: lectuterSurName.text,
          agency: lectuterAgency.text,
          affiliate: selectedLectuterAffiliate.value,
          telephone: lectuterTelephone.text,
          province: addressController.selectedProvince.value,
          lectuterExp: lectuterExpChips.join('|'),
          lectuterFacebook: lectuterFacebook.text,
          lectuterLine: lectuterLine.text,
          lectuterPreName: lectuterPreName.text,
        ),
      );
      resetForm();
    }
    // lectuters.add(
    //   Lectuters(
    //     lectuterAffiliate: lectuterAffiliate.text,
    //     lectuterAgency: lectuterAgency.text,
    //     lectuterExp: lectuterExpChips.toString(),
    //     lectuterFacebook: lectuterFacebook.text,
    //     lectuterFirstName: lectuterFirstName.text,
    //     lectuterLine: lectuterLine.text,
    //     lectuterPreName: lectuterPreName.text,
    //     lectuterSurName: lectuterSurName.text,
    //     lectuterTelephone: lectuterTelephone.text,
    //     province: addressController.selectedProvince.value,
    //   ),
    // );
  }

  resetForm() {
    lectuterPreName.text = "";
    lectuterFirstName.text = "";
    lectuterSurName.text = "";
    lectuterTelephone.text = "";
    lectuterLine.text = "";
    lectuterFacebook.text = "";
    lectuterAgency.text = "";
    // lectuterAffiliate.text = "";
    selectedLectuterAffiliate.value = "";
    lectuterExp.text = "";
    lectuterExpChips.clear();
    // addressController.selectedProvince.value = '';
    update();
  }

  addLectuterExpToChip(String exp) {
    talker.debug('$logTitle::addLectuterExpToChip:$exp');
    lectuterExpChips.add(exp);
    talker.debug(
        '$logTitle::addLectuterExpToChip:${lectuterExpChips.toString()}');
    lectuterExp.text = "";
    lectuterExpChips.refresh();
  }

  deleteLectuterExpToChip(String lectuterExp) {
    talker.debug('$logTitle::deleteLectuterExpToChip:$lectuterExp');
    lectuterExpChips.remove(lectuterExp);
    lectuterExpChips.refresh();
  }

  Future listLectuterAffiliate() async {
    talker.info('$logTitle::listLectuterAffiliate');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await LectuterAffiliateService().list(qParams);
      lectuterAffiliateList.clear();
      lectuterAffiliateList.add("");
      for (var item in result!.data!) {
        lectuterAffiliateList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
