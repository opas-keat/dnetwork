import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/network_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class NetworkService {
  final title = "NetworkService";

  Future<NetworkServiceResponse?> listNetwork(
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
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.network,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      NetworkServiceResponse networkServiceResponse =
          NetworkServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("networkServiceResponse $networkServiceResponse");
      return networkServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
