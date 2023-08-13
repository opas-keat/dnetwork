import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/services/network_service.dart';
import '../../../../data/requests/network_service_request.dart';
import '../../../../data/responses/network_service_response.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';

class ManageNetworkController extends GetxController {
  final logTitle = "ManageNetworkController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final networkList = <NetworkData>[].obs;
  final networks = <Networks>[].obs;

  RxString networkError = ''.obs;

  final networkStationId = TextEditingController(text: "0");
  final networkStationName = TextEditingController();
  final networkFirstName = TextEditingController();
  final networkSurName = TextEditingController();
  final networkIdCard = TextEditingController();
  final networkBirthYear = TextEditingController();
  final networkLocation = TextEditingController();
  final networkDate = TextEditingController();
  final networkTelephone = TextEditingController();
  final networkPosition = TextEditingController();
  final networkPositionCommu = TextEditingController();
  final networkExp = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // talker.debug(window.sessionStorage["token"]);
  }

  Future<bool> saveNetwork() async {
    talker.info('$logTitle:saveNetwork:');
    isLoading.value = true;
    try {
      final result = await NetworkService().createNetwork(networks.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      networkList.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  addDataToTable() {
    talker.info('$logTitle:addDataToTable:');
    talker.debug(networkStationId.text);
    talker.debug(networkStationName.text);
    talker.debug(networkFirstName.text);
    talker.debug(networkSurName.text);
    talker.debug(networkIdCard.text);
    talker.debug(networkBirthYear.text);
    talker.debug(networkLocation.text);
    talker.debug(networkDate.text);
    talker.debug(networkTelephone.text);
    talker.debug(networkPosition.text);
    talker.debug(networkPositionCommu.text);
    talker.debug(networkExp.text);
    networkList.add(
      NetworkData(
        networkFirstName: networkFirstName.text,
        networkSurName: networkSurName.text,
        networkPosition: networkPosition.text,
        networkDate: networkDate.text,
        networkTelephone: networkTelephone.text,
      ),
    );
    networks.add(Networks(
      amphure: addressController.selectedAmphure.value.split('|').last,
      district: addressController.selectedTambol.value.split('|').last,
      networkBirthYear: networkBirthYear.text,
      networkDate: networkDate.text,
      networkExp: networkExp.text,
      networkFirstName: networkFirstName.text,
      networkIdCard: networkIdCard.text,
      networkLocation: networkLocation.text,
      networkPosition: networkPosition.text,
      networkPositionCommu: networkPositionCommu.text,
      networkStationId: int.parse(networkStationId.text),
      networkStationName: networkStationName.text,
      networkSurName: networkSurName.text,
      networkTelephone: networkTelephone.text,
      province: addressController.selectedProvince.value.split('|').last,
    ));
    resetForm();
  }

  resetForm() {
    networkBirthYear.text = "";
    networkDate.text = "";
    networkExp.text = "";
    networkFirstName.text = "";
    networkIdCard.text = "";
    networkLocation.text = "";
    networkPosition.text = "";
    networkPositionCommu.text = "";
    networkStationId.text = "0";
    networkStationName.text = "";
    networkSurName.text = "";
    networkTelephone.text = "";
    update();
  }
}
