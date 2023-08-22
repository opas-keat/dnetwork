import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_commu_service.dart';
import '../../../../api/services/commiss_position_service.dart';
import '../../../../api/services/network_service.dart';
import '../../../../data/requests/network_service_request.dart';
import '../../../../data/responses/network_service_response.dart';
import '../../../../shared/utils.dart';

class ManageNetworkController extends GetxController {
  final logTitle = "ManageNetworkController";
  RxBool isLoading = true.obs;
  // AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final networkList = <NetworkData>[].obs;
  final networks = <Networks>[].obs;

  final networkPositionList = <String>[].obs;
  Rx<String> selectedNetworkPosition = "".obs;
  final networkPositionCommuList = <String>[].obs;
  Rx<String> selectedNetworkPositionCommu = "".obs;

  RxString networkError = ''.obs;

  final formKey = GlobalKey<FormState>();
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
  final networkProvince = TextEditingController();
  final networkAmphure = TextEditingController();
  final networkTambol = TextEditingController();

  final networkPositionCommuChips = <String>[].obs;
  final networkExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listNetworkPosition();
    listNetworkPositionCommu();
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

  Future saveNetwork() async {
    talker.info('$logTitle:saveNetwork:');
    isLoading.value = true;
    try {
      for (var network in networkList) {
        networks.add(
          Networks(
            amphure: network.amphure,
            district: network.district,
            province: network.province,
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
    } catch (e) {
      talker.error('$e');
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
    networkPositionCommuChips.clear();
    networkExpChips.clear();
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
    selectedNetworkPosition.value = networkList[index].networkPosition!;

    networkAmphure.text = networkList[index].district!;
    networkTambol.text = networkList[index].amphure!;
    networkProvince.text = networkList[index].province!;
    if (networkList[index].networkPositionCommu!.isNotEmpty) {
      networkPositionCommuChips
          .addAll(networkList[index].networkPositionCommu!.split('|'));
      selectedNetworkPositionCommu.value =
          networkList[index].networkPositionCommu!.split('|').first;
    }
    if (networkList[index].networkExp!.isNotEmpty) {
      networkExpChips.addAll(networkList[index].networkExp!.split('|'));
    }
    update();
    networkList.refresh();
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
    final isValid = formKey.currentState!.validate();
    if (isValid) {
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
          networkPosition: selectedNetworkPosition.value,
          networkPositionCommu: networkPositionCommuChips.join('|'),
          networkExp: networkExp.text,
          amphure: networkAmphure.text,
          district: networkTambol.text,
          province: networkProvince.text,
        ),
      );
      resetForm();
    }

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
  }

  resetForm() {
    networkBirthYear.text = "";
    networkDate.text = "";
    networkExp.text = "";
    networkFirstName.text = "";
    networkIdCard.text = "";
    networkLocation.text = "";
    // networkPosition.text = "";
    networkPositionCommu.text = "";
    // networkStationId.text = "0";
    // networkStationName.text = "";
    networkSurName.text = "";
    networkTelephone.text = "";
    networkPositionCommuChips.clear();
    networkExpChips.clear();
    // addressController.selectedProvince.value = '';
    // addressController.selectedAmphure.value = '';
    // addressController.selectedTambol.value = '';
    selectedNetworkPosition.value = '';
    selectedNetworkPositionCommu.value = '';
    update();
  }

  addPositionCommuToChip(String positionCommu) {
    talker.debug(
        '$logTitle::addPositionCommuToChip:${selectedNetworkPositionCommu.value}');
    networkPositionCommuChips.add(selectedNetworkPositionCommu.value);
    talker.debug(
        '$logTitle::addPositionCommuToChip:${networkPositionCommuChips.join("|")}');
    networkPositionCommuChips.refresh();
  }

  deletePositionCommuToChip(String positionCommu) {
    talker.debug('$logTitle::deletePositionCommuToChip:$positionCommu');
    networkPositionCommuChips.remove(positionCommu);
    networkPositionCommuChips.refresh();
  }

  addNetworkExpToChip(String exp) {
    talker.debug('$logTitle::addNetworkExpToChip:$networkExp');
    networkExpChips.add(exp);
    talker
        .debug('$logTitle::addNetworkExpToChip:${networkExpChips.toString()}');
    networkExp.text = '';
    networkExpChips.refresh();
  }

  deleteNetworkExpToChip(String networkExp) {
    talker.debug('$logTitle::deleteNetworkToChip:$networkExp');
    networkExpChips.remove(networkExp);
    networkExpChips.refresh();
  }

  Future listNetworkPosition() async {
    talker.info('$logTitle::listNetworkPosition');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionService().list(qParams);
      networkPositionList.clear();
      networkPositionList.add("");
      for (var item in result!.data!) {
        networkPositionList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }

  Future listNetworkPositionCommu() async {
    talker.info('$logTitle::listNetworkPositionCommu');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await CommissPositionCommuService().list(qParams);
      networkPositionCommuList.clear();
      networkPositionCommuList.add("");
      for (var item in result!.data!) {
        networkPositionCommuList.add(item.name!);
      }
      // update();
    } catch (e) {
      talker.error('$e');
    }
  }
}
