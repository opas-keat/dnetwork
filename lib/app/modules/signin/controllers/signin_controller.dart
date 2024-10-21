import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../api/services/auth_service.dart';
import '../../../api/services/user_service.dart';
import '../../../shared/utils.dart';
import '../views/signin_cid.dart';

class SigninController extends GetxController {
  final logTitle = "SigninController";
  var isObscure = true.obs;
  var isLoading = true.obs;
  // var isPdpaCheck = "Y".obs;

  final cid = TextEditingController(text: "");
  var resultCID = false.obs;

  RxString authenError = ''.obs;

  @override
  void onInit() {
    talker.info('SigninController is started');
    super.onInit();
  }

  Future<bool> signIn(
      {required String userName, required String password}) async {
    talker.info('signIn');
    talker.debug('userName:$userName');
    talker.debug('password:$password');
    // userName = 'NPT001';
    // password = 'NPT#!123';
    try {
      final result = await AuthenService().login(userName, password);
      // talker.debug('response message : ${result?.message}');
      if (result?.code == "000") {
        html.window.sessionStorage["token"] = result!.data!.token!;
        final resultCID = await Get.dialog(
          SignInCID(),
          barrierDismissible: false,
        );
        if (resultCID.value) {
          if (result!.data!.roles!.length > 1) {
            html.window.sessionStorage["roles"] = "admin";
          } else {
            html.window.sessionStorage["roles"] = "user";
          }
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
            // isPdpaCheck.value = user.data!.pdpaCheck!;
            html.window.sessionStorage["pdpa_check"] = user.data!.pdpaCheck!;
          }
          return true;
        }
        return false;
      }
      authenError.value = result!.message!;
      return false;
    } catch (e) {
      talker.error('$e');
      // talker.error('${e.responseBody['message']}');
      // signUpError.value = '${e.responseBody['message']}';
      return false;
    }

    // Map<String, String> login = {
    //   "userName": userName,
    //   "userPass": password,
    // };
    // // The plaintext message to be encrypted
    // final plainText = jsonEncode(login);

    // // Generate a 256-bit key (32 bytes) for AES
    // final key = encrypt.Key.fromUtf8('32characterslongpassphraseneeded');

    // // Generate a 128-bit initialization vector (IV) for AES (16 bytes)
    // final iv = encrypt.IV.fromLength(16);

    // // Create the AES encrypter
    // final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // // Encrypt the plaintext
    // final encrypted = encrypter.encrypt(plainText, iv: iv);

    // // Decrypt the ciphertext
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);

    // // Convert the decrypted string back to JSON
    // final decryptedJson = jsonDecode(decrypted);

    // // Output
    // print('Original JSON: $login');
    // print('Encrypted: ${encrypted.base64}');
    // print('Decrypted JSON: $decryptedJson');
    // final jsonData = {
    //   'name': 'John Doe',
    //   'email': 'johndoe@example.com',
    //   'age': 30,
    // };

    // return Future.delayed(const Duration(seconds: 3), () {
    //   return false;
    // });
  }

  Future<bool> validateIDC() async {
    talker.info('validateIDC');
    talker.debug('idc:$cid.text');
    try {
      final result = await AuthenService().validateIDC(cid.text);
      // talker.debug('response message : ${result?.message}');
      // if (result?.code == "000") {
      //   return true;
      // }
      return result!;
    } catch (e) {
      talker.error('$e');
      // talker.error('${e.responseBody['message']}');
      // signUpError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
