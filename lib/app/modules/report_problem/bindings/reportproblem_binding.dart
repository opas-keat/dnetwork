import 'package:get/get.dart';

import '../controllers/reportproblem_controller.dart';

class ReportproblemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportproblemController>(
      () => ReportproblemController(),
    );
  }
}
