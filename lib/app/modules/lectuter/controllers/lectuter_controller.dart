import 'package:flutter/material.dart';
import 'package:frontend/app/api/services/lectuter_affiliate_service.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/lectuter_service.dart';
import '../../../data/models/lectuter_statistics_data.dart';
import '../../../data/models/summary_chart.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class LectuterController extends GetxController {
  final logTitle = "LectuterController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listLectuterStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final lectuterPreName = TextEditingController();
  final lectuterFirstName = TextEditingController();
  final lectuterSurName = TextEditingController();
  final lectuterTelephone = TextEditingController();
  final lectuterLine = TextEditingController();
  final lectuterFacebook = TextEditingController();
  final lectuterAgency = TextEditingController();
  final lectuterAffiliate = TextEditingController();
  final lectuterExp = TextEditingController();

  final summaryChart = <SummaryChart>[].obs;

  @override
  void onInit() {
    super.onInit();
    listLectuter();
    listLectuterAffiliate();
  }

  listLectuterAffiliate() async {
    talker.info('$logTitle::listLectuterAffiliate');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await LectuterAffiliateService().list(qParams);
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
      summaryChart.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  listLectuter() async {
    talker.info('$logTitle:listLectuter:');
    isLoading.value = true;
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "lectuter_first_name": lectuterFirstName.text,
      "lectuter_sur_name": lectuterSurName.text,
      "lectuter_agency": lectuterAgency.text,
      "lectuter_affiliate": lectuterAffiliate.text,
      "lectuter_telephone": lectuterTelephone.text,
      "province": addressController.selectedProvince.value,
      // "amphure": addressController.selectedAmphure.value,
      // "district": addressController.selectedTambol.value,
    };
    try {
      final result = await LectuterService().list(qParams);
      listLectuterStatistics.clear();
      for (final item in result!.data!) {
        listLectuterStatistics.add(
          LectuterStatisticsData(
            name: item.name,
            telephone: item.lectuterTelephone,
            agency: item.lectuterAgency,
            affiliate: item.lectuterAffiliate,
            province: item.province,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  getLectuter() async {
    talker.info('$logTitle:getLectuter:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }

  resetSearch() {
    lectuterFirstName.text = "";
    lectuterSurName.text = "";
    lectuterAgency.text = "";
    lectuterAffiliate.text = "";
    lectuterTelephone.text = "";
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
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.name.compareTo(b.name))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "agency") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.agency.compareTo(b.agency))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.agency.compareTo(a.agency));
    } else if (field == "affiliate") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.affiliate.compareTo(b.affiliate))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.affiliate.compareTo(a.affiliate));
    } else if (field == "province") {
      ascending
          ? listLectuterStatistics.obs.value
              .sort((a, b) => a.province.compareTo(b.province))
          : listLectuterStatistics.obs.value
              .sort((a, b) => b.province.compareTo(a.province));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
