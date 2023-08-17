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
      for (var network in networkList) {
        networks.add(
          Networks(
            amphure: network.amphure!.split('|').last,
            district: network.district!.split('|').last,
            province: network.province!.split('|').last,
            networkBirthYear: network.networkBirthYear,
            networkDate: network.networkDate,
            networkExp: network.networkExp,
            networkFirstName: network.networkFirstName,
            networkIdCard: network.networkIdCard,
            networkLocation: network.networkLocation,
            networkPosition: network.networkPosition,
            networkPositionCommu: network.networkPositionCommu,
            networkStationId: network.networkStationId,
            networkStationName: network.networkStationName,
            networkSurName: network.networkSurName,
            networkTelephone: network.networkTelephone,
          ),
        );
      }
      final result = await NetworkService().createNetwork(networks.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        return true;
      }
      isLoading.value = false;
      networkList.clear();
      networks.clear();
      resetForm();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  deleteDataFromTable() {
    talker.info('$logTitle:deleteDataFromTable:$selectedIndexFromTable');
    if (networkList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      networkList.removeAt(selectedIndexFromTable);
      selectedIndexFromTable = -1;
      resetForm();
    }
  }

  selectDataFromTable(int index) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.debug(networkList[index].networkStationId);
    talker.debug(networkList[index].networkStationName);
    talker.debug(networkList[index].networkFirstName);
    talker.debug(networkList[index].networkSurName);
    talker.debug(networkList[index].networkIdCard);
    talker.debug(networkList[index].networkBirthYear);
    talker.debug(networkList[index].networkLocation);
    talker.debug(networkList[index].networkDate);
    talker.debug(networkList[index].networkTelephone);
    talker.debug(networkList[index].networkPosition);
    talker.debug(networkList[index].networkPositionCommu);
    talker.debug(networkList[index].networkExp);
    talker.debug(networkList[index].province);
    talker.debug(networkList[index].amphure);
    talker.debug(networkList[index].district);
    networkStationId.text = networkList[index].networkStationId!.toString();
    networkStationName.text = networkList[index].networkStationName!;
    networkFirstName.text = networkList[index].networkFirstName!;
    networkSurName.text = networkList[index].networkSurName!;
    networkIdCard.text = networkList[index].networkIdCard!;
    networkBirthYear.text = networkList[index].networkBirthYear!;
    networkLocation.text = networkList[index].networkLocation!;
    networkDate.text = networkList[index].networkDate!;
    networkTelephone.text = networkList[index].networkTelephone!;
    networkPosition.text = networkList[index].networkPosition!;
    networkPositionCommu.text = networkList[index].networkPositionCommu!;
    networkExp.text = networkList[index].networkExp!;
    addressController.selectedProvince.value = networkList[index].province!;
    await addressController
        .listAmphure(networkList[index].province!.split('|').first);
    addressController.selectedAmphure.value = networkList[index].amphure!;
    await addressController
        .listTambol(networkList[index].amphure!.split('|').first);
    addressController.selectedTambol.value = networkList[index].district!;
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
    networkList.add(
      NetworkData(
        networkStationId: int.parse(networkStationId.text),
        networkStationName: networkStationName.text,
        networkFirstName: networkFirstName.text,
        networkSurName: networkSurName.text,
        networkIdCard: networkIdCard.text,
        networkBirthYear: networkBirthYear.text,
        networkLocation: networkLocation.text,
        networkDate: networkDate.text,
        networkTelephone: networkTelephone.text,
        networkPosition: networkPosition.text,
        networkPositionCommu: networkPositionCommu.text,
        networkExp: networkExp.text,
        amphure: addressController.selectedAmphure.value,
        district: addressController.selectedTambol.value,
        province: addressController.selectedProvince.value,
      ),
    );
    // networks.add(
    //   Networks(
    //     amphure: addressController.selectedAmphure.value,
    //     district: addressController.selectedTambol.value,
    //     networkBirthYear: networkBirthYear.text,
    //     networkDate: networkDate.text,
    //     networkExp: networkExpChips.toString(),
    //     networkFirstName: networkFirstName.text,
    //     networkIdCard: networkIdCard.text,
    //     networkLocation: networkLocation.text,
    //     networkPosition: networkPosition.text,
    //     networkPositionCommu: networkPositionCommuChips.toString(),
    //     networkStationId: int.parse(networkStationId.text),
    //     networkStationName: networkStationName.text,
    //     networkSurName: networkSurName.text,
    //     networkTelephone: networkTelephone.text,
    //     province: addressController.selectedProvince.value,
    //   ),
    // );
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
