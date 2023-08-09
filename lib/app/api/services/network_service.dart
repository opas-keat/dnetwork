import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import '../../data/requests/network_service_request.dart';
import '../../data/responses/network_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class NetworkService {
  final title = "NetworkService";

  Future<NetworkServiceResponse?> createNetwork(
    List<Networks> listNetworks,
  ) async {
    apiUtils.secureHeaders = {
      'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    };
    talker.debug(NetworkServiceRequest(networks: listNetworks).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.network,
        data: NetworkServiceRequest(networks: listNetworks),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      NetworkServiceResponse networkServiceResponse =
          NetworkServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${networkServiceResponse.code}');
      if (networkServiceResponse.code == "000") {
        return NetworkServiceResponse(
          code: networkServiceResponse.code,
          message: response.data["message"],
          data: networkServiceResponse.data,
        );
      }
      return NetworkServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return NetworkServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

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
