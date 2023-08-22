import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/station_service.dart';
import '../../../data/models/station_statistics_data.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class StationController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddStation = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listStationStatistics = <StationStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final name = TextEditingController();
  final location = TextEditingController();
  final facebook = TextEditingController();
  final process = TextEditingController();

  final selectedStation = StationStatisticsData();

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listStationStatistics.value = listStationStatisticsDataModel;
    // update();
    listStation();
  }

  listStation() async {
    talker.info('$logTitle:listStation:');
    isLoading.value = true;
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
      "amphure": addressController.selectedAmphure.value,
      "district": addressController.selectedTambol.value,
      "name": name.text,
      "process": process.text,
      "location": location.text,
      "facebook": facebook.text,
    };
    try {
      final result = await StationService().list(qParams);
      listStationStatistics.clear();
      for (final item in result!.data!) {
        listStationStatistics.add(
          StationStatisticsData(
            name: item.name,
            address: '${item.province}/${item.amphure}/${item.district}',
            totalCommiss: item.totalCommiss,
            totalMember: item.totalMember,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
      // return false;
    } catch (e) {
      talker.error('$e');
      // return false;
    }
    // update();
  }

  getStation() async {
    talker.info('$logTitle:getStation:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  resetSearch() {
    name.text = "";
    process.text = "";
    location.text = "";
    facebook.text = "";
    update();
  }

  void sort<T>(
    // Comparable<T> Function(StationStatisticsData s) getField,
    String field,
    int columnIndex,
    bool ascending,
  ) {
    // talker.debug(logTitle + ':field:' + field.toString());
    // talker.debug(logTitle + ':sort:' + columnIndex.toString());
    // talker.debug(logTitle + ':ascending:' + ascending.toString());
    if (field == "name") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listStationStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "address") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listStationStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    } else if (field == "totalCommiss") {
      ascending
          ? listStationStatistics.obs.value
              .sort((a, b) => a.totalCommiss!.compareTo(b.totalCommiss as num))
          : listStationStatistics.obs.value
              .sort((a, b) => b.totalCommiss!.compareTo(a.totalCommiss as num));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
