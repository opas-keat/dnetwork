import 'dart:html' as html;
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

import '../../../api/services/auth_service.dart';
import '../../../api/services/user_service.dart';
import '../../../shared/utils.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SigninController extends GetxController {
  final logTitle = "SigninController";
  var isObscure = true.obs;
  var isLoading = true.obs;
  // var isPdpaCheck = "Y".obs;

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
    // try {
    //   final result = await AuthenService().login(userName, password);
    //   // talker.debug('response message : ${result?.message}');
    //   if (result?.code == "000") {
    //     if (result!.data!.roles!.length > 1) {
    //       html.window.sessionStorage["roles"] = "admin";
    //     } else {
    //       html.window.sessionStorage["roles"] = "user";
    //     }
    //     html.window.sessionStorage["token"] = result.data!.token!;
    //     final user = await UserService().getByToken();
    //     if (user?.code == "000") {
    //       //   talker.debug(user!.data!.id);
    //       //   talker.debug(user.data!.firstName);
    //       // talker.debug(user!.data!.province);
    //       if (user!.data!.province! == "ส่วนกลาง" ||
    //           user.data!.province! == "") {
    //         html.window.sessionStorage["province"] = "";
    //       } else {
    //         html.window.sessionStorage["province"] = user.data!.province!;
    //       }
    //       html.window.sessionStorage["profile"] =
    //           '${user.data!.userName} ${user.data!.firstName}';
    //       // isPdpaCheck.value = user.data!.pdpaCheck!;
    //       html.window.sessionStorage["pdpa_check"] = user.data!.pdpaCheck!;
    //     }
    //     return true;
    //   }
    //   authenError.value = result!.message!;
    //   return false;
    // } catch (e) {
    //   talker.error('$e');
    //   // talker.error('${e.responseBody['message']}');
    //   // signUpError.value = '${e.responseBody['message']}';
    //   return false;
    // }

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
    final jsonData = {
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'age': 30,
    };
    // The plaintext message to be encrypted
    final data = jsonEncode(jsonData);
    // Generate a 256-bit key (32 bytes) for AES
    final key = encrypt.Key.fromUtf8('32characterslongpassphraseneeded');
    // Generate a 128-bit initialization vector (IV) for AES (16 bytes)
    final iv = encrypt.IV.fromLength(16);
    print('IV (Base64): ${iv.base64}');

    // สร้างคีย์แบบสุ่มขนาด 32 ไบต์ (256 บิต)
    final randomStr = generateRandomString(32);
    // แปลงเป็น string ในรูปแบบ hexadecimal
    // final keyHex = base64Encode(ranKey);
    print('random string : ${randomStr}');
    final Key randomKey = encrypt.Key.fromUtf8(randomStr);
    print('randomKey (Base64): ${randomKey.base64}');

    // Create the AES encrypter data
    final encrypterData = encrypt.Encrypter(
        encrypt.AES(randomKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    // Encrypt the data
    final encryptedData = encrypterData.encrypt(data, iv: iv);
    print('encryptedData (Base64): ${encryptedData.base64}');

    // Create the AES encrypter randomKey
    final encrypterKey = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    // Encrypt the data
    final encryptedDey = encrypterKey.encrypt(randomStr, iv: iv);
    print('encryptedDey (Base64): ${encryptedDey.base64}');

    return Future.delayed(const Duration(seconds: 3), () {
      return false;
    });
  }

  // ฟังก์ชันสร้างสตริงแบบสุ่ม
  String generateRandomString(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join('');
  }
}
