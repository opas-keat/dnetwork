import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/member_statistics_data.dart';
import '../../../shared/utils.dart';

class MemberController extends GetxController {
  final logTitle = "StationController";
  RxBool isLoading = true.obs;
  RxBool isLoadingAddMember = true.obs;

  final listMemberStatistics = [].obs;
  RxBool sortAscending = true.obs;
  RxInt sortColumnIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listMemberStatistics.value = listMemberStatisticsData;
    update();
    getMember();
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
          ? listMemberStatistics.value.sort((a, b) => a.name.compareTo(b.name))
          : listMemberStatistics.value.sort((a, b) => b.name.compareTo(a.name));
    } else if (field == "position") {
      ascending
          ? listMemberStatistics.value
              .sort((a, b) => a.position.compareTo(b.position))
          : listMemberStatistics.value
              .sort((a, b) => b.position.compareTo(a.position));
    } else if (field == "commissDate") {
      ascending
          ? listMemberStatistics.value
              .sort((a, b) => a.commissDate.compareTo(b.commissDate))
          : listMemberStatistics.value
              .sort((a, b) => b.commissDate.compareTo(a.commissDate));
    } else if (field == "commissLocation") {
      ascending
          ? listMemberStatistics.value
              .sort((a, b) => a.commissLocation.compareTo(b.commissLocation))
          : listMemberStatistics.value
              .sort((a, b) => b.commissLocation.compareTo(a.commissLocation));
    } else if (field == "address") {
      ascending
          ? listMemberStatistics.value
              .sort((a, b) => a.address.compareTo(b.address))
          : listMemberStatistics.value
              .sort((a, b) => b.address.compareTo(a.address));
    }
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    update();
  }
}
