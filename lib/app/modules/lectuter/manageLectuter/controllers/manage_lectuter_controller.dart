import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  final lectuterList = <LectuterData>[].obs;
  final processList = [].obs;

  final lectuters = <Lectuters>[].obs;

  RxString lectuterError = ''.obs;

  final lectuterPreName = TextEditingController();
  final lectuterFirstName = TextEditingController();
  final lectuterSurName = TextEditingController();
  final lectuterTelephone = TextEditingController();
  final lectuterLine = TextEditingController();
  final lectuterFacebook = TextEditingController();
  final lectuterAgency = TextEditingController();
  final lectuterAffiliate = TextEditingController();
  final lectuterExp = TextEditingController();

  Future<bool> saveLectuter() async {
    talker.info('$logTitle:saveLectuter:');
    isLoading.value = true;
    try {
      final result =
          await LectuterService().createLectuter(lectuters.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      lectuterList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  addToDataTable() {
    talker.info('$logTitle:addToDataTable:');
    lectuterList.add(
      LectuterData(
        name: lectuterPreName.text,
        lectuterFirstName: lectuterFirstName.text,
        lectuterSurName: lectuterSurName.text,
        agency: lectuterAgency.text,
        affiliate: lectuterAffiliate.text,
        telephone: lectuterTelephone.text,
        province: addressController.selectedProvince.value.split('|').last,
      ),
    );
    lectuters.add(
      Lectuters(
        lectuterAffiliate: lectuterAffiliate.text,
        lectuterAgency: lectuterAgency.text,
        lectuterExp: lectuterExp.text,
        lectuterFacebook: lectuterFacebook.text,
        lectuterFirstName: lectuterFirstName.text,
        lectuterLine: lectuterLine.text,
        lectuterPreName: lectuterPreName.text,
        lectuterSurName: lectuterSurName.text,
        lectuterTelephone: lectuterTelephone.text,
        province: addressController.selectedProvince.value.split('|').last,
      ),
    );
    resetForm();
  }

  resetForm() {
    lectuterPreName.text = "";
    lectuterFirstName.text = "";
    lectuterSurName.text = "";
    lectuterTelephone.text = "";
    lectuterLine.text = "";
    lectuterFacebook.text = "";
    lectuterAgency.text = "";
    lectuterAffiliate.text = "";
    lectuterExp.text = "";
    update();
  }
}
