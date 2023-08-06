import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/responses/commiss_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class CommissService {
  final title = "CommissService";

  Future<CommissServiceResponse?> listCommiss(
    String province,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      "offset": "0",
      "limit": "20",
      "order": "created_at",
      "province": province,
    };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.commiss,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      CommissServiceResponse commissServiceResponse =
          CommissServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("commissServiceResponse $commissServiceResponse");
      return commissServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
