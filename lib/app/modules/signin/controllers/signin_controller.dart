import 'dart:io';

import 'package:get/get.dart';

import '../../../../main.dart';

class SigninController extends GetxController {
  final logTitle = "SigninController";
  var isObscure = true.obs;
  var isLoading = true.obs;

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

  Future<bool> signIn({required String userName, required String password}) {
    talker.info('signIn');
    talker.debug('userName:$userName');
    talker.debug('password:$password');
    return Future.delayed(const Duration(seconds: 3), () {
      return true;
    });
  }
}
