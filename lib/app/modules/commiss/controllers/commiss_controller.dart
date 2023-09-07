import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/commiss_position_service.dart';
import '../../../api/services/commiss_service.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/commiss_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class CommissController extends GetxController {
  final logTitle = "CommissController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listCommissStatistics = <CommissData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final commissFirstName = TextEditingController(text: "");
  final commissSurName = TextEditingController(text: "");
  final commissTelephone = TextEditingController(text: "");
  final commissDate = TextEditingController(text: "");
  final commissStationName = TextEditingController(text: "");

  final summaryChart = <SummaryChart>[].obs;

  int currentPage = 1;
  RxInt offset = 0.obs;

  String defaultCommissOrder = queryParamOrderBy;

  final commissPositionList = <String>[].obs;
  Rx<String> selectedCommissPosition = "".obs;

  @override
  void onInit() {
    super.onInit();
    listCommiss();
    listCommissPosition();
  }

  listCommissPosition() async {
    talker.info('$logTitle::listCommissPosition');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": queryParamOffset,
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await CommissPositionService().list(qParams);
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
        commissPositionList.add(item.name!);
      }
      isLoadingChart.value = false;
      isLoadingChart.refresh();
      summaryChart.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  Future listCommissPositionDD() async {
    talker.info('$logTitle::listCommissPositionDD');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": "id asc",
    };
    try {
      final result = await CommissPositionService().list(qParams);
      commissPositionList.clear();
      commissPositionList.add("");
      for (var item in result!.data!) {
        commissPositionList.add(item.name!);
      }
    } catch (e) {
      talker.error('$e');
    }
  }

  listCommiss() async {
    talker.info('$logTitle:listCommiss:');
    isLoading.value = true;
    String province = window.sessionStorage["province"]!;
    if (province.isEmpty) {
      province = addressController.selectedProvince.value;
    }
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": defaultCommissOrder,
      "province": province,
      "amphure": addressController.selectedAmphure.value,
      "district": addressController.selectedTambol.value,
      "commiss_first_name": commissFirstName.text,
      "commiss_sur_name": commissSurName.text,
      "commiss_telephone": commissTelephone.text,
      "commiss_date": commissDate.text,
      "commiss_station_name": commissStationName.text,
      "commiss_position": selectedCommissPosition.value,
    };
    try {
      final result = await CommissService().list(qParams);
      // listCommissStatistics.clear();
      for (final item in result!.data!) {
        listCommissStatistics.add(
          CommissData(
            id: item.id,
            commissFirstName: item.commissFirstName,
            commissSurName: item.commissSurName,
            province: item.province,
            amphure: item.amphure,
            district: item.district,
            commissTelephone: item.commissTelephone,
            commissPosition: item.commissPosition,
            commissDate: item.commissDate,
            commissLocation: item.commissLocation,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  // getCommiss() async {
  //   talker.info('$logTitle:getCommiss:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }

  resetSearch() {
    commissFirstName.text = "";
    commissSurName.text = "";
    commissTelephone.text = "";
    commissDate.text = "";
    commissStationName.text = "";
    selectedCommissPosition.value = "";
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
          ? listCommissStatistics.obs.value
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "position") {
      ascending
          ? listCommissStatistics.obs.value
              .sort((a, b) => a.position!.compareTo(b.position!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.position!.compareTo(a.position!));
    } else if (field == "commissDate") {
      ascending
          ? listCommissStatistics.obs.value
              .sort((a, b) => a.commissDate!.compareTo(b.commissDate!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.commissDate!.compareTo(a.commissDate!));
    } else if (field == "commissLocation") {
      ascending
          ? listCommissStatistics.obs.value
              .sort((a, b) => a.commissLocation!.compareTo(b.commissLocation!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.commissLocation!.compareTo(a.commissLocation!));
    } else if (field == "address") {
      ascending
          ? listCommissStatistics.obs.value
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
