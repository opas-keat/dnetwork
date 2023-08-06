import 'package:get/get.dart';

import '../../../api/services/member_service.dart';
import '../../../data/models/member_statistics_data.dart';
import '../../../shared/utils.dart';

class MemberController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddMember = true.obs;

  final listMemberStatistics = <MemberStatisticsData>[].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // listMemberStatistics.value = listMemberStatisticsData;
    // update();
    // getMember();
    listMember();
  }

  listMember() async {
    talker.info('$logTitle:listMember:');
    isLoading.value = true;
    String province = "";
    try {
      final result = await MemberService().listMember(province);
      listMemberStatistics.clear();
      for (final item in result!.data!) {
        listMemberStatistics.add(
          MemberStatisticsData(
            name: item.name,
            address: item.address,
            telephone: item.telephone,
            position: item.position,
            memberDate: item.memberDate,
            memberLocation: item.memberLocation,
          ),
        );
      }
      isLoading.value = false;
      update();
    } catch (e) {
      talker.error('$e');
    }
  }

  getMember() async {
    talker.info('$logTitle:getMember:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
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
              .sort((a, b) => a.name!.compareTo(b.name!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.name!.compareTo(a.name!));
    } else if (field == "position") {
      ascending
          ? listMemberStatistics.obs.value
              .sort((a, b) => a.position!.compareTo(b.position!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.position!.compareTo(a.position!));
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
              .sort((a, b) => a.address!.compareTo(b.address!))
          : listMemberStatistics.obs.value
              .sort((a, b) => b.address!.compareTo(a.address!));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
