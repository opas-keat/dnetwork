import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/list_report.dart';
import '../../../shared/utils.dart';

class ListReportController extends GetxController {
  final logTitle = "ListReportController";
  RxBool isLoading = true.obs;
  final bugReportList = <BugReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    update();
    getListReport();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getListReport() async {
    talker.info('$logTitle:getListReport:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      bugReportList.value = listBugReport;
      return false;
    });
    update();
  }
}
