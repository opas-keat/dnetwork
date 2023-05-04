import 'package:get/get.dart';

import '../controllers/manage_training_controller.dart';

class ManageTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageTrainingController>(
      () => ManageTrainingController(),
    );
  }
}
