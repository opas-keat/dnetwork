import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/commiss_service.dart';
import '../../../data/models/commiss_statistics_data.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class CommissController extends GetxController {
  final logTitle = "CommissController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listCommissStatistics = <CommissStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final commissFirstName = TextEditingController(text: "");
  final commissSurName = TextEditingController(text: "");
  final commissTelephone = TextEditingController(text: "");
  final commissDate = TextEditingController(text: "");
  final commissStationName = TextEditingController(text: "");

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listCommissStatistics.value = listCommissStatisticsData;
    // update();
    // getCommiss();
    listCommiss();
  }

  listCommiss() async {
    talker.info('$logTitle:listCommiss:');
    isLoading.value = true;
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value.split('|').last,
      "amphure": addressController.selectedAmphure.value.split('|').last,
      "district": addressController.selectedTambol.value.split('|').last,
      "commiss_first_name": commissFirstName.text,
      "commiss_sur_name": commissSurName.text,
      "commiss_telephone": commissTelephone.text,
      "commiss_date": commissDate.text,
      "commiss_station_name": commissStationName.text,
    };
    try {
      final result = await CommissService().listCommiss(qParams);
      listCommissStatistics.clear();
      for (final item in result!.data!) {
        listCommissStatistics.add(
          CommissStatisticsData(
            name: item.name,
            telephone: item.telephone,
            position: item.position,
            commissDate: item.commissDate,
            commissLocation: item.commissLocation,
            address: '${item.province}/${item.amphure}/${item.district}',
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  getCommiss() async {
    talker.info('$logTitle:getCommiss:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  resetSearch() {
    commissFirstName.text = "";
    commissSurName.text = "";
    commissTelephone.text = "";
    commissDate.text = "";
    commissStationName.text = "";
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
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listCommissStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
