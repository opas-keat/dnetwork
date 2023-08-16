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

  final networkPositionCommuChips = <String>[].obs;
  final networkExpChips = <String>[].obs;

  int selectedIndexFromTable = 0;

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

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (networks.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      networks.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(networks[index].networkStationId);
    talker.debug(networks[index].networkStationName);
    talker.debug(networks[index].networkFirstName);
    talker.debug(networks[index].networkSurName);
    talker.debug(networks[index].networkIdCard);
    talker.debug(networks[index].networkBirthYear);
    talker.debug(networks[index].networkLocation);
    talker.debug(networks[index].networkDate);
    talker.debug(networks[index].networkTelephone);
    talker.debug(networks[index].networkPosition);
    talker.debug(networks[index].networkPositionCommu);
    talker.debug(networks[index].networkExp);
    talker.debug(networks[index].province);
    talker.debug(networks[index].amphure);
    talker.debug(networks[index].district);
    networkStationId.text = networks[index].networkStationId!.toString();
    networkStationName.text = networks[index].networkStationName!;
    networkFirstName.text = networks[index].networkFirstName!;
    networkSurName.text = networks[index].networkSurName!;
    networkIdCard.text = networks[index].networkIdCard!;
    networkBirthYear.text = networks[index].networkBirthYear!;
    networkLocation.text = networks[index].networkLocation!;
    networkDate.text = networks[index].networkDate!;
    networkTelephone.text = networks[index].networkTelephone!;
    networkPosition.text = networks[index].networkPosition!;
    networkPositionCommu.text = networks[index].networkPositionCommu!;
    networkExp.text = networks[index].networkExp!;
    addressController.selectedProvince.value = networks[index].province!;
    addressController.selectedAmphure.value = networks[index].amphure!;
    addressController.selectedTambol.value = networks[index].district!;
    update();
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
    // networkList.add(
    //   NetworkData(
    //     networkStationId: int.parse(networkStationId.text),
    //     networkStationName: networkStationName.text,
    //     networkFirstName: networkFirstName.text,
    //     networkSurName: networkSurName.text,
    //     networkIdCard: networkIdCard.text,
    //     networkBirthYear: networkBirthYear.text,
    //     networkLocation: networkLocation.text,
    //     networkDate: networkDate.text,
    //     networkTelephone: networkTelephone.text,
    //     networkPosition: networkPosition.text,
    //     networkPositionCommu: networkPositionCommu.text,
    //     networkExp: networkExp.text,

    //   ),
    // );
    networks.add(
      Networks(
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
        networkBirthYear: networkBirthYear.text,
        networkDate: networkDate.text,
        networkExp: networkExpChips.toString(),
        networkFirstName: networkFirstName.text,
        networkIdCard: networkIdCard.text,
        networkLocation: networkLocation.text,
        networkPosition: networkPosition.text,
        networkPositionCommu: networkPositionCommuChips.toString(),
        networkStationId: int.parse(networkStationId.text),
        networkStationName: networkStationName.text,
        networkSurName: networkSurName.text,
        networkTelephone: networkTelephone.text,
        province: addressController.selectedProvince.value,
      ),
    );
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
    networkPositionCommuChips.clear();
    networkExpChips.clear();
    addressController.selectedProvince.value = '0|';
    addressController.selectedAmphure.value = '0|';
    addressController.selectedTambol.value = '0|';
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::addPositionCommuToChip:$positionCommu');
    networkPositionCommuChips.add(positionCommu);
    talker.debug(
        '$logTitle::addPositionCommuToChip:${networkPositionCommuChips.toString()}');
    update();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    networkPositionCommuChips.remove(positionCommu);
    update();
  }

  addNetworkExpToChip(String networkExp) {
    talker.debug('$logTitle::addNetworkExpToChip:$networkExp');
    networkExpChips.add(networkExp);
    talker
        .debug('$logTitle::addNetworkExpToChip:${networkExpChips.toString()}');
    update();
  }

  deleteNetworkExpToChip(String networkExp) {
    talker.debug('$logTitle::deleteNetworkToChip:$networkExp');
    networkExpChips.remove(networkExp);
    update();
  }
}
