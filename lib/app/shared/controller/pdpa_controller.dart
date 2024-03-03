import 'package:get/get.dart';

import '../../api/services/user_service.dart';
import '../utils.dart';

class PdpaController extends GetxController {
  final logTitle = "PdpaController";

  @override
  void onInit() {
    talker.info('$logTitle onInit');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    talker.info('$logTitle onReady');
  }

  @override
  void onClose() {
    talker.info('$logTitle onClose');
    super.onClose();
  }

  Future<bool> updatePdpa() async {
    talker.info('$logTitle:updatePdpa:');
    try {
      final result = await UserService().updatePdpa();
      return true;
    } catch (e) {
      talker.error('$e');
      return true;
    }
  }
}
