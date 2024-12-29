import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../data/responses/authen_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class AuthenService {
  final title = "AuthenService";

  Future<AuthenServiceResponse?> login(String username, String password) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return AuthenServiceResponse.withError(
          code: codeNoInternet, msg: apiUtils.getNetworkError());
    }
    final login = {
      "userName": username,
      "userPass": password,
    };
    try {
      final result = await apiUtils.post(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.authen}/login',
        data: encryptionKeyValue(login),
        options: Options(
          headers: apiUtils.header,
        ),
      );
      // talker.debug('login:: ${result.statusCode}');
      // talker.debug('login:: ${result.toString()}');
      // talker.info(title, 'login:: ${result.data['status_code']}');
      // if (result.data['status_code'] == 200) {
      //   return AuthenServiceResponse.fromJson(result.data);
      // }
      String decryptData = "";
      final dynamic responseBody = jsonDecode(result.toString());
      if (responseBody is Map) {
        Map<String, dynamic> data = responseBody['data'];
        String key = data['key'];
        String value = data['value'];
        // talker.debug('key:: $key');
        // talker.debug('value:: $value');
        decryptData = decryptionKeyValue(key, value);
        // talker.debug('decryptData:: $decryptData');
      }
      result.data['data'] = jsonDecode(decryptData);
      AuthenServiceResponse authenServiceResponse =
          AuthenServiceResponse.fromJson(jsonDecode(result.toString()));
      if (authenServiceResponse.code == "000") {
        return AuthenServiceResponse(
          code: authenServiceResponse.code,
          message: result.data["message"],
          data: authenServiceResponse.data,
        );
      }
      // talker.info(title, 'login:: ${result.data["message"]}');
      return AuthenServiceResponse.withError(code: 200, msg: 'fail');
    } catch (e) {
      return AuthenServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<bool?> validateIDC(String idc) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    final idcRequest = {
      "id_card": idc,
    };
    try {
      final result = await apiUtils.post(
        url:
            '${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.user}/validate-idc',
        data: encryptionKeyValue(idcRequest),
        options: Options(
          headers: apiUtils.header,
        ),
      );
      String decryptData = "";
      final dynamic responseBody = jsonDecode(result.toString());
      if (responseBody is Map) {
        Map<String, dynamic> data = responseBody['data'];
        String key = data['key'];
        String value = data['value'];
        decryptData = decryptionKeyValue(key, value);
        talker.debug('decryptData:: $decryptData');
      }
      final dynamic resultCID = jsonDecode(decryptData);
      return resultCID['result'];
    } catch (e) {
      return false;
    }
  }
}
