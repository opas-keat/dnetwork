import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_position_commu_service.dart';
import '../../../../api/services/network_position_service.dart';
import '../../../../api/services/network_service.dart';
import '../../../../data/requests/network_service_request.dart';
import '../../../../data/responses/network_service_response.dart';
import '../../../../shared/controller/info_card_controller.dart';
import '../../../../shared/utils.dart';
import '../../../address/controllers/address_controller.dart';
import '../../controllers/network_controller.dart';

class ManageNetworkController extends GetxController {
  final logTitle = "ManageNetworkController";
  RxBool isLoading = true.obs;
  InfoCardController infoCardController = Get.put(InfoCardController());
  NetworkController networkController = Get.put(NetworkController());
  AddressController addressController = Get.put(AddressController());

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final networkList = <NetworkData>[].obs;
  final networks = <Networks>[].obs;
  final networkPositionList = <String>[].obs;
  Rx<String> selectedNetworkPosition = "".obs;
  final networkPositionCommuList = <String>[].obs;
  Rx<String> selectedNetworkPositionCommu = "".obs;

  final networkStationId = TextEditingController(text: "0");
  final networkStationName = TextEditingController();
  final networkFirstName = TextEditingController();
  final networkSurName = TextEditingController();
  final networkIdCard = TextEditingController();
  final networkBirthYear = TextEditingController();
  final networkLocation = TextEditingController();
  final networkDate = TextEditingController();
  final networkTelephone = TextEditingController();
  final networkPositionCommu = TextEditingController();
  final networkExp = TextEditingController();
  final networkProvince = TextEditingController();
  final networkAmphure = TextEditingController();
  final networkTambol = TextEditingController();
  final networkPreName = TextEditingController();
  final networkAgency = TextEditingController();

  RxString networkError = ''.obs;

  final networkPositionCommuChips = <String>[].obs;
  final networkExpChips = <String>[].obs;

  int selectedIndexFromTable = -1;
  int selectedId = -1;

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
    networkList.clear();
    super.onClose();
  }

  save() async {
    talker.info('$logTitle:save:');
    isLoading.value = true;
    bool result = true;
    try {
      talker.debug(networkLocation.text);
      talker.debug(addressController.selectedProvince.value);
      talker.debug(addressController.selectedAmphure.value);
      talker.debug(addressController.selectedTambol.value);
      talker.debug(networkLocation.text);
      networks.add(
        Networks(
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
          networkPreName: networkPreName.text,
          networkAgency: networkAgency.text,
        ),
      );
      final response = await NetworkService().create(networks.obs.value);
      talker.debug('response message : ${response?.message}');
      if (response?.code == "000") {
        for (var item in response!.data!) {
          networkList.add(
            NetworkData(
              id: item.id,
              amphure: item.amphure,
              district: item.district,
              province: item.province,
              networkBirthYear: item.networkBirthYear,
              networkDate: item.networkDate,
              networkExp: item.networkExp,
              networkFirstName: item.networkFirstName,
              networkIdCard: item.networkIdCard,
              networkLocation: item.networkLocation,
              networkPosition: item.networkPosition,
              networkPositionCommu: item.networkPositionCommu,
              networkStationId: item.networkStationId,
              networkStationName: item.networkStationName,
              networkSurName: item.networkSurName,
              networkTelephone: item.networkTelephone,
              networkPreName: item.networkPreName,
              networkAgency: item.networkAgency,
            ),
          );
        }
        isLoading.value = false;
        networks.clear();
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
      networks.add(
        Networks(
          id: selectedId,
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
          networkPreName: networkPreName.text,
          networkAgency: networkAgency.text,
        ),
      );
      final result = await NetworkService().update(networks.obs.value);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        for (var item in result!.data!) {
          networkList[selectedIndexFromTable].networkStationId =
              item.networkStationId;
          networkList[selectedIndexFromTable].networkStationName =
              item.networkStationName;
          networkList[selectedIndexFromTable].networkFirstName =
              item.networkFirstName;
          networkList[selectedIndexFromTable].networkSurName =
              item.networkSurName;
          networkList[selectedIndexFromTable].networkIdCard =
              item.networkIdCard;
          networkList[selectedIndexFromTable].networkBirthYear =
              item.networkBirthYear;
          networkList[selectedIndexFromTable].networkLocation =
              item.networkLocation;
          networkList[selectedIndexFromTable].networkDate = item.networkDate;
          networkList[selectedIndexFromTable].networkTelephone =
              item.networkTelephone;
          networkList[selectedIndexFromTable].networkPosition =
              item.networkPosition;
          networkList[selectedIndexFromTable].networkPositionCommu =
              item.networkPositionCommu;
          networkList[selectedIndexFromTable].amphure = item.amphure;
          networkList[selectedIndexFromTable].district = item.district;
          networkList[selectedIndexFromTable].province = item.province;
          networkList[selectedIndexFromTable].networkPreName =
              item.networkPreName;
          networkList[selectedIndexFromTable].networkAgency =
              item.networkAgency;
        }
      }
      isLoading.value = false;
      networkList.refresh();
      networks.clear();
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
    if (networkList.length > selectedIndexFromTable &&
        selectedIndexFromTable > -1) {
      final result = await NetworkService().delete(selectedId);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        talker.debug('networkList : ${networkList.toString()}');
        networkList.removeAt(selectedIndexFromTable);
        talker.debug('trainingList : ${networkList.toString()}');
        networkList.refresh();
      }
    }
  }

  selectDataFromTable(int index, int id) async {
    selectedIndexFromTable = index;
    talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
    talker.info('$logTitle:id:$id');
    isLoading.value = true;
    try {
      final result = await NetworkService().getById(id);
      for (final item in result!.data!) {
        selectedId = item.id!;
        networkStationId.text = item.networkStationId!.toString();
        networkStationName.text = item.networkStationName!;
        networkFirstName.text = item.networkFirstName!;
        networkSurName.text = item.networkSurName!;
        networkIdCard.text = item.networkIdCard!;
        networkBirthYear.text = item.networkBirthYear!;
        networkLocation.text = item.networkLocation!;
        networkDate.text = item.networkDate!;
        networkTelephone.text = item.networkTelephone!;
        // networkPosition.text = networkList[index].networkPosition!;
        selectedNetworkPosition.value = item.networkPosition!;

        // networkPositionCommu.text = networkList[index].networkPositionCommu!;
        // networkExp.text = networkList[index].networkExp!;
        networkAmphure.text = item.district!;
        networkTambol.text = item.amphure!;
        networkProvince.text = item.province!;
        networkPreName.text = item.networkPreName!;
        networkAgency.text = item.networkAgency!;
        if (item.networkPositionCommu!.isNotEmpty) {
          networkPositionCommuChips
              .addAll(item.networkPositionCommu!.split('|'));
          selectedNetworkPositionCommu.value =
              item.networkPositionCommu!.split('|').first;
        }
        if (item.networkExp!.isNotEmpty) {
          networkExpChips.addAll(item.networkExp!.split('|'));
        }
        update();
      }
      isLoading.value = false;
      networkList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  // Future<bool> saveNetwork() async {
  //   talker.info('$logTitle:saveNetwork:');
  //   isLoading.value = true;
  //   try {
  //     for (var network in networkList) {
  //       networks.add(
  //         Networks(
  //           amphure: network.amphure,
  //           district: network.district,
  //           province: network.province,
  //           networkBirthYear: network.networkBirthYear,
  //           networkDate: network.networkDate,
  //           networkExp: network.networkExp,
  //           networkFirstName: network.networkFirstName,
  //           networkIdCard: network.networkIdCard,
  //           networkLocation: network.networkLocation,
  //           networkPosition: network.networkPosition,
  //           networkPositionCommu: network.networkPositionCommu,
  //           networkStationId: network.networkStationId,
  //           networkStationName: network.networkStationName,
  //           networkSurName: network.networkSurName,
  //           networkTelephone: network.networkTelephone,
  //         ),
  //       );
  //     }
  //     final result = await NetworkService().create(networks.obs.value);
  //     talker.debug('response message : ${result?.message}');
  //     if (result?.code == "000") {
  //       return true;
  //     }
  //     isLoading.value = false;
  //     networkList.clear();
  //     networks.clear();
  //     resetForm();
  //     return true;
  //   } catch (e) {
  //     talker.error('$e');
  //     return false;
  //   }
  // }

  // deleteDataFromTable() {
  //   talker.info('$logTitle:deleteDataFromTable:${selectedIndexFromTable}');
  //   if (networkList.length > selectedIndexFromTable &&
  //       selectedIndexFromTable > -1) {
  //     networkList.removeAt(selectedIndexFromTable);
  //     selectedIndexFromTable = -1;
  //     resetForm();
  //   }
  // }

  // selectDataFromTable(int index) async {
  //   selectedIndexFromTable = index;
  //   talker.info('$logTitle:selectDataFromTable:$selectedIndexFromTable');
  //   networkPositionCommuChips.clear();
  //   networkExpChips.clear();
  //   talker.debug(networkList[index].networkStationId);
  //   talker.debug(networkList[index].networkStationName);
  //   talker.debug(networkList[index].networkFirstName);
  //   talker.debug(networkList[index].networkSurName);
  //   talker.debug(networkList[index].networkIdCard);
  //   talker.debug(networkList[index].networkBirthYear);
  //   talker.debug(networkList[index].networkLocation);
  //   talker.debug(networkList[index].networkDate);
  //   talker.debug(networkList[index].networkTelephone);
  //   talker.debug(networkList[index].networkPosition);
  //   talker.debug(networkList[index].networkPositionCommu);
  //   talker.debug(networkList[index].networkExp);
  //   talker.debug(networkList[index].province);
  //   talker.debug(networkList[index].amphure);
  //   talker.debug(networkList[index].district);
  //   networkStationId.text = networkList[index].networkStationId!.toString();
  //   networkStationName.text = networkList[index].networkStationName!;
  //   networkFirstName.text = networkList[index].networkFirstName!;
  //   networkSurName.text = networkList[index].networkSurName!;
  //   networkIdCard.text = networkList[index].networkIdCard!;
  //   networkBirthYear.text = networkList[index].networkBirthYear!;
  //   networkLocation.text = networkList[index].networkLocation!;
  //   networkDate.text = networkList[index].networkDate!;
  //   networkTelephone.text = networkList[index].networkTelephone!;
  //   // networkPosition.text = networkList[index].networkPosition!;
  //   selectedNetworkPosition.value = networkList[index].networkPosition!;

  //   // networkPositionCommu.text = networkList[index].networkPositionCommu!;
  //   // networkExp.text = networkList[index].networkExp!;
  //   networkAmphure.text = networkList[index].district!;
  //   networkTambol.text = networkList[index].amphure!;
  //   networkProvince.text = networkList[index].province!;
  //   if (networkList[index].networkPositionCommu!.isNotEmpty) {
  //     networkPositionCommuChips
  //         .addAll(networkList[index].networkPositionCommu!.split('|'));
  //     selectedNetworkPositionCommu.value =
  //         networkList[index].networkPositionCommu!.split('|').first;
  //   }
  //   if (networkList[index].networkExp!.isNotEmpty) {
  //     networkExpChips.addAll(networkList[index].networkExp!.split('|'));
  //   }
  //   // addressController.selectedProvince.value = networkList[index].province!;
  //   // await addressController
  //   //     .listAmphure(networkList[index].province!.split('|').first);
  //   // addressController.selectedAmphure.value = networkList[index].amphure!;
  //   // await addressController
  //   //     .listTambol(networkList[index].amphure!.split('|').first);
  //   // addressController.selectedTambol.value = networkList[index].district!;
  //   update();
  //   networkList.refresh();
  // }

  // addDataToTable() {
  //   talker.info('$logTitle:addDataToTable:');
  //   talker.debug(networkStationId.text);
  //   talker.debug(networkStationName.text);
  //   talker.debug(networkFirstName.text);
  //   talker.debug(networkSurName.text);
  //   talker.debug(networkIdCard.text);
  //   talker.debug(networkBirthYear.text);
  //   talker.debug(networkLocation.text);
  //   talker.debug(networkDate.text);
  //   talker.debug(networkTelephone.text);
  //   talker.debug(selectedNetworkPosition);
  //   talker.debug(networkPositionCommu.text);
  //   talker.debug(networkExp.text);
  //   final isValid = formKey.currentState!.validate();
  //   if (isValid) {
  //     networkList.add(
  //       NetworkData(
  //         networkStationId: int.parse(networkStationId.text),
  //         networkStationName: networkStationName.text,
  //         networkFirstName: networkFirstName.text,
  //         networkSurName: networkSurName.text,
  //         networkIdCard: networkIdCard.text,
  //         networkBirthYear: networkBirthYear.text,
  //         networkLocation: networkLocation.text,
  //         networkDate: networkDate.text,
  //         networkTelephone: networkTelephone.text,
  //         networkPosition: selectedNetworkPosition.value,
  //         networkPositionCommu: networkPositionCommuChips.join('|'),
  //         networkExp: networkExp.text,
  //         amphure: networkAmphure.text,
  //         district: networkTambol.text,
  //         province: networkProvince.text,
  //       ),
  //     );
  //     resetForm();
  //   }
  //   // networks.add(
  //   //   Networks(
  //   //     amphure: addressController.selectedAmphure.value,
  //   //     district: addressController.selectedTambol.value,
  //   //     networkBirthYear: networkBirthYear.text,
  //   //     networkDate: networkDate.text,
  //   //     networkExp: networkExpChips.toString(),
  //   //     networkFirstName: networkFirstName.text,
  //   //     networkIdCard: networkIdCard.text,
  //   //     networkLocation: networkLocation.text,
  //   //     networkPosition: networkPosition.text,
  //   //     networkPositionCommu: networkPositionCommuChips.toString(),
  //   //     networkStationId: int.parse(networkStationId.text),
  //   //     networkStationName: networkStationName.text,
  //   //     networkSurName: networkSurName.text,
  //   //     networkTelephone: networkTelephone.text,
  //   //     province: addressController.selectedProvince.value,
  //   //   ),
  //   // );
  // }

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
    networkPreName.text = "";
    networkAgency.text = "";
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
        '$logTitle::addPositionCommuToChip:${networkPositionCommuChips.toString()}');
    // selectedNetworkPositionCommu.value = '';
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

  Future listNetworkPosition() async {
    talker.info('$logTitle::listNetworkPosition');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
    };
    try {
      final result = await NetworkPositionService().list(qParams);
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
