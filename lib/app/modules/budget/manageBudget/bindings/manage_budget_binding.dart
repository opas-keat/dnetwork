import 'package:get/get.dart';

import '../controllers/manage_budget_controller.dart';

class ManageBudgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageBudgetController>(
      () => ManageBudgetController(),
    );
  }
}
