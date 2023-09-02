import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import '../../data/requests/network_service_request.dart';
import '../../data/responses/delete_service_response.dart';
import '../../data/responses/network_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class NetworkService {
  final title = "NetworkService";

  Future<NetworkServiceResponse?> create(
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
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return NetworkServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<NetworkServiceResponse?> getById(
    int id,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.network}/$id",
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

  Future<NetworkServiceResponse?> update(
    List<Networks> listNetworks,
  ) async {
    talker.debug(NetworkServiceRequest(networks: listNetworks).toJson());
    try {
      final response = await apiUtils.put(
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
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return NetworkServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<DeleteServiceResponse?> delete(
    int id,
  ) async {
    try {
      final response = await apiUtils.delete(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.network}/$id",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      DeleteServiceResponse deleteServiceResponse =
          DeleteServiceResponse.fromJson(jsonDecode(response.toString()));
      return deleteServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<NetworkServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };

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
