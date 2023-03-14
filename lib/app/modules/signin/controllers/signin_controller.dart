import 'package:get/get.dart';

import '../../../../main.dart';

class SigninController extends GetxController {
  final logTitle = "SigninController";
  var isObscure = true.obs;

  @override
  void onInit() {
    talker.info('SigninController is started');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signIn({required String userName, required String password}) {
    talker.info('signIn');
    talker.debug('userName:$userName');
  }
}
