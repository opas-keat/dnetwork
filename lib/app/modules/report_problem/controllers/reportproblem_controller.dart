import 'package:get/get.dart';

import '../../../shared/utils.dart';

class ReportproblemController extends GetxController {
  final logTitle = "ReportproblemController";
  RxBool isLoading = true.obs;

  final RxString currentModuleSelected = '2'.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading(true);
    update();
    getReportProblem();
  }

  updateModuleSelected(String value) {
    talker.info('$logTitle:updateModuleSelected: $value');
    currentModuleSelected.value = value;

    // updateDiscount();
    // updateGrandTotal();
  }

  getReportProblem() async {
    talker.info('$logTitle:getReportProblem:');
    isLoading.value =
        await Future.delayed(Duration(seconds: randomValue()), () {
      return false;
    });
    update();
  }
}
