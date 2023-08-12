import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/services/network_service.dart';
import '../../../data/models/network_statistics.data.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class NetworkController extends GetxController {
  final logTitle = "NetworkController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddNetwork = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listNetworkStatistics = <NetworkStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final networkIdCard = TextEditingController(text: "");
  final networkTelephone = TextEditingController(text: "");
  final networkStationName = TextEditingController(text: "");
  final networkFirstName = TextEditingController(text: "");
  final networkSurName = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listNetworkStatistics.value = listNetworkStatisticsData;
    // update();
    // getNetwork();
    listNetwork();
  }

  listNetwork() async {
    talker.info('$logTitle:listNetwork:');
    isLoading.value = true;
    // String province = "";
    try {
      final result = await NetworkService().listNetwork(
        addressController.selectedProvince.value,
        networkIdCard.text,
        networkTelephone.text,
        networkStationName.text,
        networkFirstName.text,
        networkSurName.text,
      );
      listNetworkStatistics.clear();
      for (final item in result!.data!) {
        listNetworkStatistics.add(
          NetworkStatisticsData(
            name: item.name,
            address: item.address,
            telephone: item.telephone,
            position: item.position,
            networkDate: item.networkDate,
            networkLocation: item.networkLocation,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  getNetwork() async {
    talker.info('$logTitle:getNetwork:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  resetSearch() {
    networkIdCard.text = "";
    networkTelephone.text = "";
    networkStationName.text = "";
    networkFirstName.text = "";
    networkSurName.text = "";
    update();
  }

  void sort<T>(
    String field,
    int columnIndex,
    bool ascending,
  ) {
    talker.info('$logTitle:sort:$field');
    if (field == "name") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "position") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.position!.compareTo(b.position!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.position!.compareTo(a.position!));
    } else if (field == "networkDate") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.networkDate!.compareTo(b.networkDate!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.networkDate!.compareTo(a.networkDate!));
    } else if (field == "networkLocation") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.networkLocation!.compareTo(b.networkLocation!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.networkLocation!.compareTo(a.networkLocation!));
    } else if (field == "address") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
