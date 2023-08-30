import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/village_service.dart';
import '../../../data/responses/village_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class VillageController extends GetxController {
  final logTitle = "VillageController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listVillageStatistics = <VillageData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final villageName = TextEditingController(text: "");
  final villageNo = TextEditingController(text: "");

  int currentPage = 1;
  RxInt offset = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listVillageStatistics.value = listVillageStatisticsData;
    // update();
    // getVillage();
    listVillage();
  }

  listVillage() async {
    talker.info('$logTitle:listVillage:');
    isLoading.value = true;
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
      "amphure": addressController.selectedAmphure.value,
      "district": addressController.selectedTambol.value,
      "village_name": villageName.text,
      "village_no": villageNo.text,
    };
    try {
      final result = await VillageService().list(qParams);
      // listVillageStatistics.clear();
      for (final item in result!.data!) {
        listVillageStatistics.add(
          VillageData(
            id: item.id,
            amphure: item.amphure,
            district: item.district,
            province: item.province,
            villageLocation: item.villageLocation,
            villageName: item.villageName,
            villageNo: item.villageNo,
            villageTotal: item.villageTotal,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  // getVillage() async {
  //   talker.info('$logTitle:getVillage:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }

  resetSearch() {
    villageName.text = "";
    villageNo.text = "";
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
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.villageName!.compareTo(b.villageName!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.villageName!.compareTo(a.villageName!));
    } else if (field == "no") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.villageNo!.compareTo(b.villageNo!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.villageNo!.compareTo(a.villageNo!));
    } else if (field == "address") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    } else if (field == "total") {
      ascending
          ? listVillageStatistics.obs.value
              .sort((a, b) => a.villageTotal!.compareTo(b.villageTotal!))
          : listVillageStatistics.obs.value
              .sort((a, b) => b.villageTotal!.compareTo(a.villageTotal!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
