import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/network_position_service.dart';
import '../../../api/services/network_service.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/network_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class NetworkController extends GetxController {
  final logTitle = "NetworkController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddNetwork = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listNetworkStatistics = <NetworkData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final networkIdCard = TextEditingController(text: "");
  final networkTelephone = TextEditingController(text: "");
  final networkStationName = TextEditingController(text: "");
  final networkFirstName = TextEditingController(text: "");
  final networkSurName = TextEditingController(text: "");

  final summaryChart = <SummaryChart>[].obs;

  int currentPage = 1;
  RxInt offset = 0.obs;

  @override
  void onInit() {
    super.onInit();
    listNetwork();
    listNetworkPosition();
  }

  listNetworkPosition() async {
    talker.info('$logTitle::listMemberPosition');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": queryParamOffset,
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await NetworkPositionService().list(qParams);
      summaryChart.clear();
      for (final item in result!.data!) {
        summaryChart.add(
          SummaryChart(
            icon: Icons.edit_document,
            color: randomColor(),
            name: item.name!,
            value: item.totalData!,
          ),
        );
      }
      isLoadingChart.value = false;
      isLoadingChart.refresh();
      summaryChart.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  listNetwork() async {
    talker.info('$logTitle:listNetwork:');
    isLoading.value = true;
    String province = window.sessionStorage["province"]!;
    if (province.isEmpty) {
      province = addressController.selectedProvince.value;
    }
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": province,
      "network_id_card": networkIdCard.text,
      "network_telephone": networkTelephone.text,
      "network_station_name": networkStationName.text,
      "network_first_name": networkFirstName.text,
      "network_sur_name": networkSurName.text,
    };
    try {
      final result = await NetworkService().list(qParams);
      // listNetworkStatistics.clear();
      for (final item in result!.data!) {
        listNetworkStatistics.add(
          NetworkData(
            id: item.id,
            networkFirstName: item.networkFirstName,
            networkSurName: item.networkSurName,
            province: item.province,
            amphure: item.amphure,
            district: item.district,
            networkTelephone: item.networkTelephone,
            networkPosition: item.networkPosition,
            // name: "${item.networkFirstName!} ${item.networkSurName!}",
            // address: "${item.province}/${item.amphure}/${item.district}",
            networkDate: item.networkDate,
            networkLocation: item.networkLocation,
            networkPreName: item.networkPreName,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  // getNetwork() async {
  //   talker.info('$logTitle:getNetwork:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }

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
          ? listNetworkStatistics.obs.value.sort(
              (a, b) => a.networkFirstName!.compareTo(b.networkFirstName!))
          : listNetworkStatistics.obs.value.sort(
              (a, b) => b.networkFirstName!.compareTo(a.networkFirstName!));
    } else if (field == "position") {
      ascending
          ? listNetworkStatistics.obs.value
              .sort((a, b) => a.networkPosition!.compareTo(b.networkPosition!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.networkPosition!.compareTo(a.networkPosition!));
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
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listNetworkStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
