import 'package:get/get.dart';

import '../controllers/list_report_controller.dart';

class ListReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListReportController>(
      () => ListReportController(),
    );
  }
}
