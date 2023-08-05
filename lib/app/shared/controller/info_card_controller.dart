import 'package:get/get.dart';

import '../../../main.dart';
import '../../api/services/summary_info_service.dart';
import '../../data/models/summary_info.dart';

class InfoCardController extends GetxController {
  final logTitle = "InfoCardController";
  RxBool isLoading = true.obs;

  final listSummaryInfo = <SummaryInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getSummaryInfo();
  }

  getSummaryInfo() async {
    talker.info('$logTitle:getSummaryInfo:');
    try {
      final result = await SummaryInfoService().getSummaryInfo();
      listSummaryInfo.clear();
      for (final item in result!.data!) {
        listSummaryInfo.value.add(SummaryInfo(
          name: item.name!,
          nameEn: item.nameEn!,
          value: item.value!,
        ));
      }
      isLoading.value = false;
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }
}
