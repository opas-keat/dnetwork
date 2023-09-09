import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend/app/api/api_params.dart';
import 'package:get/get.dart';

import '../../../api/services/member_position_service.dart';
import '../../../api/services/member_service.dart';
import '../../../data/models/summary_chart.dart';
import '../../../data/responses/member_service_response.dart';
import '../../../shared/utils.dart';
import '../../address/controllers/address_controller.dart';

class MemberController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddMember = true.obs;
  RxBool isLoadingChart = true.obs;
  AddressController addressController = Get.put(AddressController());

  final listMemberStatistics = <MemberData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  final memberIdCard = TextEditingController(text: "");
  final memberTelephone = TextEditingController(text: "");
  final memberStationName = TextEditingController(text: "");
  final memberFirstName = TextEditingController(text: "");
  final memberSurName = TextEditingController(text: "");

  final summaryChart = <SummaryChart>[].obs;

  int currentPage = 1;
  RxInt offset = 0.obs;

  @override
  void onInit() {
    super.onInit();
    listMember();
    listMemberPosition();
  }

  listMemberPosition() async {
    talker.info('$logTitle::listMemberPosition');
    isLoadingChart.value = true;
    Map<String, String> qParams = {
      "offset": queryParamOffset,
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": addressController.selectedProvince.value,
    };
    try {
      final result = await MemberPositionService().list(qParams);
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

  listMember() async {
    talker.info('$logTitle:listMember:');
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
      "member_id_card": memberIdCard.text,
      "member_telephone": memberTelephone.text,
      "member_station_name": memberStationName.text,
      "member_first_name": memberFirstName.text,
      "member_sur_name": memberSurName.text,
    };
    try {
      final result = await MemberService().list(qParams);
      // listMemberStatistics.clear();
      for (final item in result!.data!) {
        listMemberStatistics.add(
          MemberData(
            id: item.id,
            memberFirstName: item.memberFirstName,
            memberSurName: item.memberSurName,
            province: item.province,
            amphure: item.amphure,
            district: item.district,
            memberTelephone: item.memberTelephone,
            memberPosition: item.memberPosition,
            memberDate: item.memberDate,
            memberLocation: item.memberLocation,
            memberPreName: item.memberPreName,
          ),
        );
      }
      isLoading.value = false;
      resetSearch();
    } catch (e) {
      talker.error('$e');
    }
  }

  // getMember() async {
  //   talker.info('$logTitle:getMember:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }

  resetSearch() {
    memberIdCard.text = "";
    memberTelephone.text = "";
    memberStationName.text = "";
    memberFirstName.text = "";
    memberSurName.text = "";
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
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.memberFirstName!.compareTo(b.memberFirstName!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.memberFirstName!.compareTo(a.memberFirstName!));
    } else if (field == "position") {
      ascending
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.memberPosition!.compareTo(b.memberPosition!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.memberPosition!.compareTo(a.memberPosition!));
    } else if (field == "memberDate") {
      ascending
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.memberDate!.compareTo(b.memberDate!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.memberDate!.compareTo(a.memberDate!));
    } else if (field == "memberLocation") {
      ascending
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.memberLocation!.compareTo(b.memberLocation!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.memberLocation!.compareTo(a.memberLocation!));
    } else if (field == "address") {
      ascending
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.province!.compareTo(b.province!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.province!.compareTo(a.province!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
