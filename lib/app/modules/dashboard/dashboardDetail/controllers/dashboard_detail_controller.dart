import 'package:get/get.dart';

import '../../../../api/api_params.dart';
import '../../../../api/services/commiss_service.dart';
import '../../../../api/services/member_service.dart';
import '../../../../data/responses/commiss_service_response.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../data/responses/station_service_response.dart';
import '../../../../shared/utils.dart';

class DashboardDetailController extends GetxController {
  final logTitle = "DashboardDetailController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAdd = true.obs;
  RxBool isLoadingChart = true.obs;
  RxBool isLoadingCommiss = true.obs;
  RxBool isLoadingMember = true.obs;

  final listCommissStatistics = <CommissData>[].obs;
  final listMemberStatistics = <MemberData>[].obs;

  // RxString selectedProvince = ''.obs;
  // final stationList = <StationData>[].obs;
  final stationData = StationData().obs;
  RxString stationName = ''.obs;

  int currentPage = 1;
  RxInt offset = 0.obs;
  String defaultCommissOrder = queryParamOrderBy;

  @override
  void onInit() {
    talker.info('$logTitle:onInit:');
    super.onInit();
  }

  @override
  void onReady() {
    update();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getMember() async {
    talker.info('$logTitle:getMember:');
    talker.info(stationData.value.id!);
    talker.info(stationData.value.name);
    stationName.value = stationData.value.name!;
    isLoadingMember.value = true;
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "province": stationData.value.province!,
      "amphure": stationData.value.amphure!,
      "district": stationData.value.district!,
      "year_of_data": nowYearForSearch,
    };
    try {
      final result = await MemberService().list(qParams);
      listMemberStatistics.clear();
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
            memberStationName: item.memberStationName,
            yearOfData: item.yearOfData,
          ),
        );
      }
      isLoadingMember.value = false;
    } catch (e) {
      talker.error('$e');
    }
  }

  getCommiss() async {
    talker.info('$logTitle:getCommiss:');
    talker.info(stationData.value.id!);
    talker.info(stationData.value.name);
    stationName.value = stationData.value.name!;
    isLoadingCommiss.value = true;
    Map<String, String> qParams = {
      "offset": offset.value.toString(),
      "limit": queryParamLimit,
      "order": defaultCommissOrder,
      "province": stationData.value.province!,
      "amphure": stationData.value.amphure!,
      "district": stationData.value.district!,
      "year_of_data": nowYearForSearch,
    };
    try {
      final result = await CommissService().list(qParams);
      listCommissStatistics.clear();
      for (final item in result!.data!) {
        listCommissStatistics.add(
          CommissData(
            id: item.id,
            commissPreName: item.commissPreName,
            commissFirstName: item.commissFirstName,
            commissSurName: item.commissSurName,
            province: item.province,
            amphure: item.amphure,
            district: item.district,
            commissTelephone: item.commissTelephone,
            commissPosition: item.commissPosition,
            commissDate: item.commissDate,
            commissLocation: item.commissLocation,
            commissStationName: item.commissStationName,
            yearOfData: item.yearOfData,
          ),
        );
      }
      update();
      isLoadingCommiss.value = false;
    } catch (e) {
      talker.error('$e');
    }
  }
}
