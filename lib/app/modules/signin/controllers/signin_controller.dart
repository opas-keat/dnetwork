import 'dart:html';

import 'package:frontend/app/api/api_utils.dart';
import 'package:frontend/app/api/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class SigninController extends GetxController {
  final logTitle = "SigninController";
  var isObscure = true.obs;
  var isLoading = true.obs;

  RxString authenError = ''.obs;

  @override
  void onInit() {
    talker.info('SigninController is started');
    super.onInit();
  }

  Future<bool> signIn(
      {required String userName, required String password}) async {
    talker.info('signIn');
    // talker.debug('userName:$userName');
    // talker.debug('password:$password');
    try {
      final result = await AuthenService().login(userName, password);
      talker.debug('response message : ${result?.message}');
      // talker.debug('token : ${result?.data!.token}');
      if (result?.code == "000") {
        // ApiUtils().secureHeaders = {
        //   'Authorization': 'Bearer ${result?.data!.token}',
        // };
        window.sessionStorage["token"] = result!.data!.token!;
        return true;
      }
      authenError.value = result!.message!;
      return false;
    } catch (e) {
      talker.error('$e');
      // talker.error('${e.responseBody['message']}');
      // signUpError.value = '${e.responseBody['message']}';
      return false;
    }
    // return Future.delayed(const Duration(seconds: 3), () {
    //   return true;
    // });
  }
}
