import 'dart:html' as html;

import 'package:get/get.dart';

import '../../../api/services/auth_service.dart';
import '../../../api/services/user_service.dart';
import '../../../shared/utils.dart';

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
    // userName = 'NPT001';
    // password = 'NPT#!123';
    try {
      final result = await AuthenService().login(userName, password);
      talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        if (result!.data!.roles!.length > 1) {
          html.window.sessionStorage["roles"] = "admin";
        } else {
          html.window.sessionStorage["roles"] = "user";
        }
        html.window.sessionStorage["token"] = result.data!.token!;
        final user = await UserService().getByToken();
        if (user?.code == "000") {
          //   talker.debug(user!.data!.id);
          //   talker.debug(user.data!.firstName);
          // talker.debug(user!.data!.province);
          if (user!.data!.province! == "ส่วนกลาง" ||
              user.data!.province! == "") {
            html.window.sessionStorage["province"] = "";
          } else {
            html.window.sessionStorage["province"] = user.data!.province!;
          }
          html.window.sessionStorage["profile"] =
              '${user.data!.userName} ${user.data!.firstName}';
        }
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
