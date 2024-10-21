library service;

import 'dart:html';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'dart:convert'; // สำหรับการแปลง base64
import 'dart:typed_data'; // สำหรับการจัดการ byte array
import 'package:crypto/crypto.dart'; // สำหรับสร้าง HMAC (ไม่ใช้ในกรณีนี้)
import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/export.dart';

import 'constant.dart'; // สำหรับ AES CBC

final formatterPrice = NumberFormat('#,###,##0.00');
final formatterItem = NumberFormat('#,###,##0.##');

final _random = math.Random();
int randomValue() {
  int min = 0;
  int max = 5;
  return min + _random.nextInt(max - min);
  // return int next(int min, int max) => min + _random.nextInt(max - min);
}

randomColor() {
  return ui.Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
}

final talker = Talker(
  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  // observers: [],
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: !kReleaseMode,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: 100,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),

  ///etc...
);

report(
  String reportName,
  String output,
  String province,
  String amphure,
  String district,
  String name,
  String lastName,
  String position,
  String tel,
  String stationName,
  String moo,
  String agency,
  String affiliate,
  String mainInfoName,
) {
  // String output = 'pdf'; //pdf xlsx docx
  // String province = 'จันทบุรี';
  // String tambol = 'เกาะขวาง';
  String whereName = "";
  name.isNotEmpty ? whereName = "&NAME=$name" : whereName = "";
  String whereLastName = "";
  lastName.isNotEmpty
      ? whereLastName = "&LASTNAME=$lastName"
      : whereLastName = "";
  String wherePosition = "";
  position.isNotEmpty
      ? wherePosition = "&POSITION=$position"
      : wherePosition = "";
  String whereTel = "";
  tel.isNotEmpty ? whereTel = "&TEL=$tel" : whereTel = "";
  String whereStationName = "";
  stationName.isNotEmpty ? whereTel = "&INFO_NAME=$stationName" : whereTel = "";
  String whereMoo = "";
  moo.isNotEmpty ? whereMoo = "&MOO=$moo" : whereMoo = "";
  String whereAgency = "";
  agency.isNotEmpty ? whereAgency = "&AGENCY=$agency" : whereAgency = "";
  String whereAffiliate = "";
  agency.isNotEmpty
      ? whereAffiliate = "&AFFILIATE=$affiliate"
      : whereAffiliate = "";
  String whereLocation = "";
  String whereMainInfoName = "";
  mainInfoName.isNotEmpty
      ? whereMainInfoName = "&MAIN_INFO_NAME=ศสร.ที่ $mainInfoName"
      : whereMainInfoName = "";
  // infoLocationController.text.isNotEmpty
  //     ? whereLocation =
  //         "&LOCATION=" + infoLocationController.text
  //     : whereLocation = "";
  String whereProvince = "";
  province.isNotEmpty
      ? whereProvince = "&PROVINCE=$province"
      : whereProvince = "";
  String whereAmphure = "";
  amphure.isNotEmpty ? whereAmphure = "&AMPHURE=$amphure" : whereAmphure = "";
  String whereTambol = "";
  district.isNotEmpty ? whereTambol = "&TAMBOL=$district" : whereTambol = "";
  String reportUrl =
      "https://d-network.ect.go.th/report/flow.html?_flowId=viewReportFlow&_flowId=viewReportFlow&ParentFolderUri=%2Freports%2FECT&reportUnit=%2Freports%2FECT%2F$reportName&standAlone=true&j_username=jasperadmin&j_password=jasperadmin&decorate=no&output=$output$whereProvince$whereName$whereMoo$whereLastName$wherePosition$whereTel$whereStationName$whereAgency$whereAffiliate$whereLocation$whereAmphure$whereTambol$whereMainInfoName";
  window.open(reportUrl, "report");
}

// ฟังก์ชันสร้างสตริงแบบสุ่ม
String generateRandomString(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = math.Random.secure();
  return List.generate(
          length, (index) => characters[random.nextInt(characters.length)])
      .join('');
}

dynamic encryptionKeyValue(Object? jsonData) {
  // The plaintext message to be encrypted
  final data = jsonEncode(jsonData);
  // Generate a 256-bit key (32 bytes) for AES
  final key = encrypt.Key.fromUtf8('32characterslongpassphraseneeded');
  // Generate a 128-bit initialization vector (IV) for AES (16 bytes)
  final iv = encrypt.IV.fromLength(16);
  // print('IV (Base64): ${iv.base64}');

  // สร้างคีย์แบบสุ่มขนาด 32 ไบต์ (256 บิต)
  final randomStr = generateRandomString(32);
  // แปลงเป็น string ในรูปแบบ hexadecimal
  // final keyHex = base64Encode(ranKey);
  // print('random string : ${randomStr.toString()}');
  final randomKey = encrypt.Key.fromUtf8(randomStr.toString());
  // print('randomKey (Base64): ${randomKey.base64}');

  // Create the AES encrypter data
  final encrypterData = encrypt.Encrypter(
      encrypt.AES(randomKey, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
  // Encrypt the data
  final encryptedData = encrypterData.encrypt(data, iv: iv);
  // print('encryptedData (Base64): ${encryptedData.base64}');

  // Create the AES encrypter randomKey
  final encrypterKey = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
  // Encrypt the data
  final encryptedKey = encrypterKey.encrypt(randomStr, iv: iv);
  // print('encryptedKey (Base64): ${encryptedKey.base64}');

  final dataEncrypted = {
    "iv": iv.base64,
    "key": encryptedKey.base64,
    "value": encryptedData.base64,
  };

  return dataEncrypted;
}

String decryptionKeyValue(String randomKey, String value) {
  final key = utf8.encode(PRIVATE_KEY); // ต้องตรงกับคีย์ใน Golang

  // Cipher text ที่ได้รับมาจาก Golang (Base64-encoded string)
  // final cipherTextBase64 = value;
  // IV ที่ได้รับจากฝั่ง Golang (Base64-encoded)
  // final ivBase64 = randomKey;

  // แปลง cipher text และ IV จาก Base64 เป็น byte array
  final cipherText = base64.decode(value);
  final iv = base64.decode(randomKey);

  // ถอดรหัส
  final decryptedData = aesCbcDecrypt(Uint8List.fromList(cipherText),
      Uint8List.fromList(key), Uint8List.fromList(iv));

  // ลบ padding (PKCS7)
  final unpaddedData = removePadding(decryptedData);

  // แปลงข้อมูลกลับมาเป็น String (UTF-8)
  final decryptedText = utf8.decode(unpaddedData);

  // print('Decrypted Text: $decryptedText');
  return decryptedText;
}

// ฟังก์ชันถอดรหัส AES-256 CBC
Uint8List aesCbcDecrypt(Uint8List cipherText, Uint8List key, Uint8List iv) {
  final cipher = CBCBlockCipher(AESEngine())
    ..init(false,
        ParametersWithIV(KeyParameter(key), iv)); // false = decryption mode

  // ถอดรหัสข้อมูล (CBC)
  final decrypted = Uint8List(cipherText.length);
  var offset = 0;
  while (offset < cipherText.length) {
    offset += cipher.processBlock(cipherText, offset, decrypted, offset);
  }

  return decrypted;
}

// ฟังก์ชันลบ padding แบบ PKCS7
Uint8List removePadding(Uint8List paddedData) {
  final paddingLength = paddedData.last;
  return paddedData.sublist(0, paddedData.length - paddingLength);
}
