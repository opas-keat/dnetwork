import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_params.dart';
import '../../../api/services/incident_service.dart';
import '../../../data/requests/incident_service_request.dart';
import '../../../data/responses/incident_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class IncidentController extends GetxController {
  final logTitle = "IncidentController";
  RxBool isLoading = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listIncidentStatistics = <IncidentData>[].obs;
  final incidents = <Incidents>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final incidentCreatedBy = TextEditingController();
  final incidentModule = TextEditingController();
  final incidentTitle = TextEditingController();
  final incidentDetail = TextEditingController();
  final incidentResolvedDate = TextEditingController();
  final incidentResolvedDetail = TextEditingController();

  int currentPage = 1;
  RxInt offset = 0.obs;

  int selectedId = -1;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    list();
  }


  @override
  void onClose() {
    listIncidentStatistics.clear();
    super.onClose();
  }

  save() async {
    talker.info('$logTitle:save:');
    // isLoading.value = true;
    bool result = true;
    String province = html.window.sessionStorage["province"]!;
    if (province.isEmpty) {
      province = addressController.selectedProvince.value;
    }
    try {
      incidents.add(Incidents(
        createdBy: html.window.sessionStorage["profile"].toString(),
        incidentModule: incidentModule.text,
        incidentTitle: incidentTitle.text,
        incidentDetail: incidentDetail.text,
        province: province,
      ));
      final response = await IncidentService().create(incidents.obs.value);
      talker.debug('response message : ${response?.message}');
      incidents.clear();
      result = true;
    } catch (e) {
      talker.error('$e');
      result = true;
    }
    return result;
  }

  edit() async {
    talker.info('$logTitle:edit:');
    try {
      incidents.add(Incidents(
        id: selectedId,
        incidentModule: incidentModule.text,
        incidentTitle: incidentTitle.text,
        incidentDetail: incidentDetail.text,
        resolvedDetail: incidentResolvedDetail.text,
      ));
      final result = await IncidentService().update(incidents.obs.value);
      talker.debug('response message : ${result?.message}');
      listIncidentStatistics.refresh();
      incidents.clear();
      return true;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  list() async {
    talker.info('$logTitle:list:');
    isLoading.value = true;
    String province = html.window.sessionStorage["province"]!;
    if (province.isEmpty) {
      province = addressController.selectedProvince.value;
    }
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      // "incident_first_name": incidentFirstName.text,
      // "incident_sur_name": incidentSurName.text,
      // "incident_agency": incidentAgency.text,
      // "incident_affiliate": incidentAffiliate.text,
      // "incident_telephone": incidentTelephone.text,
      "province": province,
      // "amphure": addressController.selectedAmphure.value,
      // "district": addressController.selectedTambol.value,
    };
    try {
      final result = await IncidentService().list(qParams);
      // listIncidentStatistics.clear();
      for (final item in result!.data!) {
        listIncidentStatistics.add(
          IncidentData(
            id: item.id,
            createdBy: item.createdBy,
            incidentDate: item.incidentDate,
            incidentModule: item.incidentModule,
            incidentTitle: item.incidentTitle,
            incidentDetail: item.incidentDetail,
            resolvedDate: item.resolvedDate,
            resolvedDetail: item.resolvedDetail,
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

  resetSearch() {
    update();
  }

  void sort<T>(
    String field,
    int columnIndex,
    bool ascending,
  ) {
    talker.info('$logTitle:sort:$field');
    if (field == "incidentDate") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.incidentDate!.compareTo(b.incidentDate!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.incidentDate!.compareTo(a.incidentDate!));
    } else if (field == "incidentModule") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.incidentModule!.compareTo(b.incidentModule!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.incidentModule!.compareTo(a.incidentModule!));
    } else if (field == "incidentTitle") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.incidentTitle!.compareTo(b.incidentTitle!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.incidentTitle!.compareTo(a.incidentTitle!));
    } else if (field == "incidentDetail") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.incidentDetail!.compareTo(b.incidentDetail!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.incidentDetail!.compareTo(a.incidentDetail!));
    } else if (field == "resolvedDate") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.resolvedDate!.compareTo(b.resolvedDate!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.resolvedDate!.compareTo(a.resolvedDate!));
    } else if (field == "resolvedDetail") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.resolvedDetail!.compareTo(b.resolvedDetail!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.resolvedDetail!.compareTo(a.resolvedDetail!));
    } else if (field == "createdBy") {
      ascending
          ? listIncidentStatistics.obs.value
              .sort((a, b) => a.createdBy!.compareTo(b.createdBy!))
          : listIncidentStatistics.obs.value
              .sort((a, b) => b.createdBy!.compareTo(a.createdBy!));
    }

    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
