import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/responses/authen_service_response.dart';
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
          statusCode: CODE_NO_INTERNET, msg: apiUtils.getNetworkError());
    }

    Map<String, String> login = {
      'userName': username,
      'userPass': password,
    };

    String url =
        '${Api.baseUrl}${Api.baseContext}${Api.baseVersion}${ApiEndPoints.authen}/login';
    try {
      final result = await apiUtils.post(
        url: url,
        data: login,
      );
      // talker.info(title, 'login:: ${result.toString()}');
      // talker.info(title, 'login:: ${result.data['status_code']}');
      // if (result.data['status_code'] == 200) {
      //   return AuthenServiceResponse.fromJson(result.data);
      // }
      AuthenServiceData authenServiceData =
          AuthenServiceData.fromJson(jsonDecode(result.toString()));
      if (authenServiceData.message == "") {
        return AuthenServiceResponse(
          statusCode: 200,
          code: "",
          message: result.data["message"],
          data: authenServiceData,
        );
      }
      // talker.info(title, 'login:: ${result.data["message"]}');
      return AuthenServiceResponse.withError(
          statusCode: CODE_RESPONSE_NULL, msg: result.data["message"]);
    } catch (e) {
      return AuthenServiceResponse.withError(
          statusCode: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }
}
